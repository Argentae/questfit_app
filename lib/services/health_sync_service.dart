import 'package:health/health.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../engine/health_xp_converter.dart';

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
  ];

  static final _permissions = [
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
