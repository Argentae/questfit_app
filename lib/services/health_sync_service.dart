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
  ];

  static final _permissions = [
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

    final results = <HealthXpResult>[];

    try {
      // Fetch workout sessions
      final workoutData = await _health.getHealthDataFromTypes(
        types: [HealthDataType.WORKOUT],
        startTime: since,
        endTime: now,
      );

      // Fetch steps
      final stepData = await _health.getHealthDataFromTypes(
        types: [HealthDataType.STEPS],
        startTime: DateTime(now.year, now.month, now.day), // Today only
        endTime: now,
      );

      // Process workouts (deduplicate)
      for (final point in workoutData) {
        final hcId = point.uuid;
        if (existingHealthIds.contains(hcId)) continue;

        final duration = point.dateTo.difference(point.dateFrom).inMinutes;
        if (duration <= 0) continue;

        final xpResult = HealthXpConverter.convert(
          workoutType: point.typeString,
          durationMinutes: duration,
          playerLevel: playerLevel,
        );

        results.add(xpResult);
        existingHealthIds.add(hcId);
      }

      // Process daily steps
      var totalSteps = 0;
      for (final point in stepData) {
        totalSteps += (point.value as NumericHealthValue).numericValue.toInt();
      }

      final stepResult = HealthXpConverter.convertSteps(
        totalSteps: totalSteps,
        playerLevel: playerLevel,
      );
      if (stepResult != null) {
        results.add(stepResult);
      }

      // Update last sync timestamp
      await _setLastSyncTimestamp(now);
    } catch (e) {
      debugPrint('HealthConnect sync error: $e');
    }

    final totalXp = results.fold<int>(0, (sum, r) => sum + r.xpAwarded);

    return SyncResult(
      importedCount: results.length,
      totalXp: totalXp,
      results: results,
    );
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

class SyncResult {
  final int importedCount;
  final int totalXp;
  final List<HealthXpResult> results;

  const SyncResult({
    required this.importedCount,
    required this.totalXp,
    required this.results,
  });
}
