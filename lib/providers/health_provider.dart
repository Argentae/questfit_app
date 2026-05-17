import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import '../engine/quest_engine.dart';
import '../services/haptic_service.dart';
import '../services/health_sync_service.dart';
import 'database_provider.dart';
import 'user_provider.dart';

// ─── Service singleton provider ──────────────────────────────────────

final healthSyncServiceProvider = Provider<HealthSyncService>((ref) {
  return HealthSyncService.instance;
});

// ─── Health status providers ─────────────────────────────────────────

/// Whether Health Connect is available on this device.
final healthAvailableProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(healthSyncServiceProvider);
  return service.isAvailable();
});

/// Whether we currently have Health Connect permissions.
final healthAuthorizedProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(healthSyncServiceProvider);
  return service.isAuthorized();
});

// ─── Sync Notifier ───────────────────────────────────────────────────

/// State for the health sync process.
class HealthSyncState {
  final bool isSyncing;
  final SyncResult? lastResult;
  final String? error;

  const HealthSyncState({
    this.isSyncing = false,
    this.lastResult,
    this.error,
  });

  HealthSyncState copyWith({
    bool? isSyncing,
    SyncResult? lastResult,
    String? error,
  }) {
    return HealthSyncState(
      isSyncing: isSyncing ?? this.isSyncing,
      lastResult: lastResult ?? this.lastResult,
      error: error,
    );
  }
}

final healthSyncNotifierProvider =
    NotifierProvider<HealthSyncNotifier, HealthSyncState>(
        HealthSyncNotifier.new);

class HealthSyncNotifier extends Notifier<HealthSyncState> {
  @override
  HealthSyncState build() => const HealthSyncState();

  QuestFitDatabase get _db => ref.read(databaseProvider);
  HealthSyncService get _service => ref.read(healthSyncServiceProvider);

  /// Request Health Connect permissions. Returns true if granted.
  Future<bool> requestPermissions() async {
    try {
      final granted = await _service.requestPermissions();
      // Invalidate the authorized cache
      ref.invalidate(healthAuthorizedProvider);
      return granted;
    } catch (e) {
      debugPrint('Health permission request failed: $e');
      return false;
    }
  }

  /// Run a full sync: fetch new workouts → convert to LP → write to DB.
  Future<SyncResult> sync() async {
    if (state.isSyncing) {
      return const SyncResult(importedCount: 0, totalXp: 0, results: []);
    }

    state = state.copyWith(isSyncing: true, error: null);

    try {
      // Get player for tier scaling
      final player =
          await ((_db.select(_db.players))..limit(1)).getSingle();

      // Get existing Health Connect IDs for deduplication
      final existingLogs = await (_db.select(_db.workoutLogs)
            ..where(
                (t) => t.source.equals('health_connect')))
          .get();
      final existingIds = existingLogs
          .where((l) => l.healthConnectId != null)
          .map((l) => l.healthConnectId!)
          .toSet();

      // Fetch and convert (service still uses playerLevel internally,
      // but the LP amounts are now scaled in the service)
      final result = await _service.syncNewWorkouts(
        playerLevel: player.level,
        existingHealthIds: existingIds,
      );

      // Write each imported workout to the DB
      for (final r in result.results) {
        // Create a quest record for the imported workout
        final questId = await _db.into(_db.quests).insert(QuestsCompanion(
          title: Value(r.questTitle),
          category: Value(r.category),
          description: Value(r.questDescription),
          xpReward: Value(r.lpAwarded),
          lpReward: Value(r.lpAwarded),
          isDaily: const Value(false),
          isCompleted: const Value(true),
          completedAt: Value(DateTime.now()),
          createdAt: Value(DateTime.now()),
        ));

        // Log it
        await _db.into(_db.workoutLogs).insert(WorkoutLogsCompanion(
          questId: Value(questId),
          playerId: Value(player.id),
          completedAt: Value(DateTime.now()),
          xpEarned: Value(r.lpAwarded),
          source: const Value('health_connect'),
        ));

        // Award LP (using the converted value as LP)
        await ref.read(userNotifierProvider.notifier).awardLp(r.lpAwarded);

        // Award stat point
        final stat = QuestEngine.categoryToStat(r.category);
        await ref.read(userNotifierProvider.notifier).addStat(stat, 1);

        // Increment quests completed counter
        await ref.read(userNotifierProvider.notifier).incrementQuestsCompleted();
      }

      // Haptic feedback for imported workouts
      if (result.importedCount > 0) {
        HapticService.onQuestImported();
      }

      state = state.copyWith(
        isSyncing: false,
        lastResult: result,
      );
      return result;
    } catch (e) {
      debugPrint('Health sync failed: $e');
      state = state.copyWith(
        isSyncing: false,
        error: e.toString(),
      );
      return const SyncResult(importedCount: 0, totalXp: 0, results: []);
    }
  }
}
