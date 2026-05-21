import 'package:health/health.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../engine/health_xp_converter.dart';
import '../engine/rhythm_engine.dart';

/// QuestFit Health Connect sync service.
/// READ-ONLY access to Samsung Watch workout data via Health Connect.
///
/// Data flow: Samsung Watch → Samsung Health → Health Connect → QuestFit
class HealthSyncService {
  HealthSyncService._();

  static final HealthSyncService _instance = HealthSyncService._();
  static HealthSyncService get instance => _instance;

  final Health _health = Health();

  static const _lastSyncKey = 'health_connect_last_sync';

  // READ-ONLY data types
  static final _types = [
    HealthDataType.WORKOUT,
    HealthDataType.STEPS,
    HealthDataType.TOTAL_CALORIES_BURNED,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    // v2.4: Sleep & Heart Rate
    HealthDataType.SLEEP_SESSION,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_DEEP,
    HealthDataType.SLEEP_LIGHT,
    HealthDataType.SLEEP_REM,
    HealthDataType.HEART_RATE,
  ];

  static final _permissions = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    // v2.4: Sleep & Heart Rate
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  /// Check if Health Connect is available on this device.
  Future<bool> isAvailable() async {
    try {
      return await Health().isHealthConnectAvailable();
    } catch (e) {
      debugPrint('HealthConnect availability check failed: $e');
      return false;
    }
  }

  /// Check if we already have read permissions.
  Future<bool> isAuthorized() async {
    try {
      final result = await _health.hasPermissions(_types, permissions: _permissions);
      return result ?? false;
    } catch (e) {
      debugPrint('HealthConnect permission check failed: $e');
      return false;
    }
  }

  /// Request read-only permissions from the user.
  Future<bool> requestPermissions() async {
    try {
      return await _health.requestAuthorization(_types, permissions: _permissions);
    } catch (e) {
      debugPrint('HealthConnect permission request failed: $e');
      return false;
    }
  }

  /// Pull new workouts since last sync.
  ///
  /// Returns a [SyncResult] with imported workout data converted to XP.
  /// Requires [playerLevel] for XP scaling.
  /// Requires [existingHealthIds] for deduplication.
  Future<SyncResult> syncNewWorkouts({
    required int playerLevel,
    required Set<String> existingHealthIds,
  }) async {
    final lastSync = await _getLastSyncTimestamp();
    final now = DateTime.now();
    final since = lastSync ?? now.subtract(const Duration(days: 7));
    final todayStart = DateTime(now.year, now.month, now.day);

    final results = <HealthLpResult>[];
    var totalSteps = 0;
    var totalCalories = 0;

    try {
      // Fetch workout sessions
      final workoutData = await _health.getHealthDataFromTypes(
        types: [HealthDataType.WORKOUT],
        startTime: since,
        endTime: now,
      );

      // Process workouts (deduplicate)
      for (final point in workoutData) {
        final hcId = point.uuid;
        if (existingHealthIds.contains(hcId)) continue;

        final duration = point.dateTo.difference(point.dateFrom).inMinutes;
        if (duration <= 0) continue;

        final xpResult = HealthLpConverter.convert(
          workoutType: point.typeString,
          durationMinutes: duration,
          tierIndex: playerLevel, // Uses playerLevel as proxy for tier
        );

        results.add(xpResult);
        existingHealthIds.add(hcId);
      }

      // ── Steps ─────────────────────────────────────────────────────
      // Fetch raw step data points and use removeDuplicates() to merge
      // overlapping records from phone + watch sources.
      final rawStepData = await _health.getHealthDataFromTypes(
        types: [HealthDataType.STEPS],
        startTime: todayStart,
        endTime: now,
      );
      final dedupedSteps = _health.removeDuplicates(rawStepData);
      for (final point in dedupedSteps) {
        totalSteps += (point.value as NumericHealthValue).numericValue.toInt();
      }
      debugPrint('QuestFit SYNC: raw step records=${rawStepData.length}, '
          'deduped=${dedupedSteps.length}, totalSteps=$totalSteps');

      final stepResult = HealthLpConverter.convertSteps(
        totalSteps: totalSteps,
        tierIndex: playerLevel,
      );
      if (stepResult != null) {
        results.add(stepResult);
      }

      // ── Calories ──────────────────────────────────────────────────
      // Try TOTAL_CALORIES_BURNED first (Samsung Health typically reports this).
      // Fall back to ACTIVE_ENERGY_BURNED if total returns nothing.
      var rawCalData = await _health.getHealthDataFromTypes(
        types: [HealthDataType.TOTAL_CALORIES_BURNED],
        startTime: todayStart,
        endTime: now,
      );
      debugPrint('QuestFit SYNC: TOTAL_CALORIES_BURNED records=${rawCalData.length}');

      if (rawCalData.isEmpty) {
        // Fallback: try ACTIVE_ENERGY_BURNED
        rawCalData = await _health.getHealthDataFromTypes(
          types: [HealthDataType.ACTIVE_ENERGY_BURNED],
          startTime: todayStart,
          endTime: now,
        );
        debugPrint('QuestFit SYNC: ACTIVE_ENERGY_BURNED fallback records=${rawCalData.length}');
      }

      final dedupedCals = _health.removeDuplicates(rawCalData);
      for (final point in dedupedCals) {
        totalCalories += (point.value as NumericHealthValue).numericValue.toInt();
      }
      debugPrint('QuestFit SYNC: deduped cal records=${dedupedCals.length}, '
          'totalCalories=$totalCalories');

      // Update last sync timestamp
      await _setLastSyncTimestamp(now);
    } catch (e) {
      debugPrint('HealthConnect sync error: $e');
    }

    final totalXp = results.fold<int>(0, (sum, r) => sum + r.lpAwarded);

    debugPrint('QuestFit SYNC RESULT: steps=$totalSteps, '
        'calories=$totalCalories, workouts=${results.length}, xp=$totalXp');

    return SyncResult(
      importedCount: results.length,
      totalXp: totalXp,
      results: results,
      totalStepsToday: totalSteps,
      totalCaloriesToday: totalCalories,
    );
  }

  /// Lightweight read-only fetch of today's step and calorie totals.
  /// Does NOT import workouts or award XP.
  ///
  /// Samsung Health syncs to Health Connect from MULTIPLE sources (phone + watch).
  /// These sources report overlapping step/calorie data.
  /// Strategy: fetch raw records, group by source, take the SOURCE with the
  /// highest total. This matches what Samsung Health displays.
  Future<TodayHealthSummary> getTodayHealthSummary() async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    var totalSteps = 0;
    var totalCalories = 0;
    final debugInfo = <String>[];

    try {
      // ── Steps ─────────────────────────────────────────────────────
      final rawSteps = await _health.getHealthDataFromTypes(
        types: [HealthDataType.STEPS],
        startTime: todayStart,
        endTime: now,
      );

      // Group by source and take the max
      totalSteps = _maxBySource(rawSteps);
      debugInfo.addAll(_sourceBreakdown('STEPS', rawSteps));

      // ── Calories ──────────────────────────────────────────────────
      // Samsung Health displays "Active Calories" but Health Connect may
      // report them under TOTAL_CALORIES_BURNED or ACTIVE_ENERGY_BURNED
      // depending on the source. Query BOTH and take the higher result.
      final rawTotalCals = await _health.getHealthDataFromTypes(
        types: [HealthDataType.TOTAL_CALORIES_BURNED],
        startTime: todayStart,
        endTime: now,
      );
      final totalCalsMax = _maxBySource(rawTotalCals);
      debugInfo.addAll(_sourceBreakdown('TOTAL_CAL', rawTotalCals));

      final rawActiveCals = await _health.getHealthDataFromTypes(
        types: [HealthDataType.ACTIVE_ENERGY_BURNED],
        startTime: todayStart,
        endTime: now,
      );
      final activeCalsMax = _maxBySource(rawActiveCals);
      debugInfo.addAll(_sourceBreakdown('ACTIVE_CAL', rawActiveCals));

      // Samsung Health doesn't sync ACTIVE_ENERGY_BURNED to Health Connect.
      // Estimate active calories from steps (~0.03 kcal/step is standard for walking).
      final estimatedFromSteps = (totalSteps * 0.03).round();
      debugInfo.add('Estimated from steps: $estimatedFromSteps');

      // Take the highest value: HC total, HC active, or step estimate
      totalCalories = [totalCalsMax, activeCalsMax, estimatedFromSteps]
          .reduce((a, b) => a > b ? a : b);
      debugInfo.add('Best cal: $totalCalories (total=$totalCalsMax, active=$activeCalsMax, est=$estimatedFromSteps)');

    } catch (e) {
      debugPrint('QuestFit AWAKENING sync error: $e');
      debugInfo.add('ERROR: $e');
    }

    debugPrint('QuestFit AWAKENING RESULT: steps=$totalSteps, calories=$totalCalories');

    return TodayHealthSummary(
      steps: totalSteps,
      calories: totalCalories,
      syncedAt: DateTime.now(),
      debugInfo: debugInfo,
    );
  }

  /// Groups health data points by source name, sums each source's values,
  /// and returns the maximum total across all sources.
  /// This avoids double-counting when phone + watch both report to Health Connect.
  int _maxBySource(List<HealthDataPoint> points) {
    if (points.isEmpty) return 0;

    final bySource = <String, int>{};
    for (final p in points) {
      final source = p.sourceName;
      final value = (p.value as NumericHealthValue).numericValue.toInt();
      bySource[source] = (bySource[source] ?? 0) + value;
    }

    debugPrint('QuestFit AWAKENING: sources=$bySource');

    // Return the source with the highest total
    return bySource.values.reduce((a, b) => a > b ? a : b);
  }

  /// Returns per-source breakdown as debug strings.
  List<String> _sourceBreakdown(String label, List<HealthDataPoint> points) {
    if (points.isEmpty) return ['$label: 0 records'];

    final bySource = <String, int>{};
    for (final p in points) {
      final source = p.sourceName;
      final value = (p.value as NumericHealthValue).numericValue.toInt();
      bySource[source] = (bySource[source] ?? 0) + value;
    }

    return [
      '$label: ${points.length} records',
      ...bySource.entries.map((e) => '  ${e.key}: ${e.value}'),
    ];
  }

  Future<DateTime?> _getLastSyncTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    final ms = prefs.getInt(_lastSyncKey);
    return ms != null ? DateTime.fromMillisecondsSinceEpoch(ms) : null;
  }

  Future<void> _setLastSyncTimestamp(DateTime dt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastSyncKey, dt.millisecondsSinceEpoch);
  }

  // ─── v2.4: Sleep Data ────────────────────────────────────────────────

  /// Fetch last night's sleep data from Health Connect.
  ///
  /// Looks at sleep sessions from 6 PM yesterday to noon today
  /// to capture typical overnight sleep windows.
  Future<SleepSummary> getLastNightSleep() async {
    final now = DateTime.now();
    // Sleep window: 6 PM yesterday to noon today
    final sleepWindowStart = DateTime(now.year, now.month, now.day - 1, 18);
    final sleepWindowEnd = DateTime(now.year, now.month, now.day, 12);

    var totalMinutes = 0;
    var deepMinutes = 0;
    var remMinutes = 0;
    var lightMinutes = 0;

    try {
      // Fetch sleep session (total duration)
      final sessions = await _health.getHealthDataFromTypes(
        types: [HealthDataType.SLEEP_SESSION],
        startTime: sleepWindowStart,
        endTime: sleepWindowEnd,
      );

      // Sum total sleep from sessions
      for (final s in sessions) {
        totalMinutes += s.dateTo.difference(s.dateFrom).inMinutes;
      }

      // Fetch sleep stages for quality analysis
      final deepData = await _health.getHealthDataFromTypes(
        types: [HealthDataType.SLEEP_DEEP],
        startTime: sleepWindowStart,
        endTime: sleepWindowEnd,
      );
      for (final d in deepData) {
        deepMinutes += d.dateTo.difference(d.dateFrom).inMinutes;
      }

      final remData = await _health.getHealthDataFromTypes(
        types: [HealthDataType.SLEEP_REM],
        startTime: sleepWindowStart,
        endTime: sleepWindowEnd,
      );
      for (final r in remData) {
        remMinutes += r.dateTo.difference(r.dateFrom).inMinutes;
      }

      final lightData = await _health.getHealthDataFromTypes(
        types: [HealthDataType.SLEEP_LIGHT],
        startTime: sleepWindowStart,
        endTime: sleepWindowEnd,
      );
      for (final l in lightData) {
        lightMinutes += l.dateTo.difference(l.dateFrom).inMinutes;
      }

      // If no session data but stages exist, sum stages as total
      if (totalMinutes == 0 && (deepMinutes + remMinutes + lightMinutes) > 0) {
        totalMinutes = deepMinutes + remMinutes + lightMinutes;
      }

      debugPrint('QF_RHYTHM: Sleep — total=${totalMinutes}min, '
          'deep=${deepMinutes}min, rem=${remMinutes}min, light=${lightMinutes}min');
    } catch (e) {
      debugPrint('QF_RHYTHM: Sleep fetch error: $e');
    }

    return SleepSummary(
      totalMinutes: totalMinutes,
      deepMinutes: deepMinutes,
      remMinutes: remMinutes,
      lightMinutes: lightMinutes,
      buff: RhythmEngine.calculateRestBuff(
        sleepMinutes: totalMinutes,
        deepSleepMinutes: deepMinutes,
        remSleepMinutes: remMinutes,
      ),
    );
  }

  // ─── v2.4: Heart Rate Data ──────────────────────────────────────────

  /// Fetch average and peak heart rate from recent workout windows.
  ///
  /// [workoutStart] and [workoutEnd] define the workout time range.
  Future<HeartRateSummary> getWorkoutHeartRate({
    required DateTime workoutStart,
    required DateTime workoutEnd,
  }) async {
    try {
      final hrData = await _health.getHealthDataFromTypes(
        types: [HealthDataType.HEART_RATE],
        startTime: workoutStart,
        endTime: workoutEnd,
      );

      if (hrData.isEmpty) {
        return const HeartRateSummary(avgBpm: 0, peakBpm: 0, sampleCount: 0);
      }

      final values = hrData
          .map((p) => (p.value as NumericHealthValue).numericValue.toDouble())
          .toList();

      final avg = values.reduce((a, b) => a + b) / values.length;
      final peak = values.reduce((a, b) => a > b ? a : b);

      debugPrint('QF_RHYTHM: HR — avg=${avg.round()}bpm, '
          'peak=${peak.round()}bpm, samples=${values.length}');

      return HeartRateSummary(
        avgBpm: avg,
        peakBpm: peak,
        sampleCount: values.length,
      );
    } catch (e) {
      debugPrint('QF_RHYTHM: HR fetch error: $e');
      return const HeartRateSummary(avgBpm: 0, peakBpm: 0, sampleCount: 0);
    }
  }
}

/// Lightweight health summary for Awakening screen (read-only, no XP).
class TodayHealthSummary {
  final int steps;
  final int calories;
  final DateTime syncedAt;
  final List<String> debugInfo;

  const TodayHealthSummary({
    required this.steps,
    required this.calories,
    required this.syncedAt,
    this.debugInfo = const [],
  });
}

class SyncResult {
  final int importedCount;
  final int totalXp;
  final List<HealthLpResult> results;
  final int totalStepsToday;
  final int totalCaloriesToday;

  const SyncResult({
    required this.importedCount,
    required this.totalXp,
    required this.results,
    this.totalStepsToday = 0,
    this.totalCaloriesToday = 0,
  });
}

/// v2.4: Sleep data summary from last night.
class SleepSummary {
  final int totalMinutes;
  final int deepMinutes;
  final int remMinutes;
  final int lightMinutes;
  final RestBuff buff;

  const SleepSummary({
    required this.totalMinutes,
    required this.deepMinutes,
    required this.remMinutes,
    required this.lightMinutes,
    required this.buff,
  });

  String get totalFormatted {
    final hours = totalMinutes ~/ 60;
    final mins = totalMinutes % 60;
    return '${hours}h ${mins}m';
  }

  bool get hasData => totalMinutes > 0;
}

/// v2.4: Heart rate summary from a workout window.
class HeartRateSummary {
  final double avgBpm;
  final double peakBpm;
  final int sampleCount;

  const HeartRateSummary({
    required this.avgBpm,
    required this.peakBpm,
    required this.sampleCount,
  });

  bool get hasData => sampleCount > 0;
}
