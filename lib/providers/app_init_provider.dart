import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import 'database_provider.dart';

/// App initialization state.
enum AppInitState {
  /// Still checking whether a profile exists.
  loading,
  /// No profile found — show setup screen.
  needsSetup,
  /// Profile exists — ready to show home.
  ready,
}

/// Controls the app initialization flow:
/// 1. Check if a player profile exists in Drift
/// 2. Run streak verification on launch
/// 3. Transition to ready or setup state
final appInitProvider =
    AsyncNotifierProvider<AppInitNotifier, AppInitState>(AppInitNotifier.new);

class AppInitNotifier extends AsyncNotifier<AppInitState> {
  @override
  Future<AppInitState> build() async {
    try {
      final db = ref.read(databaseProvider);
      final players = await db.select(db.players).get();

      if (players.isEmpty) {
        return AppInitState.needsSetup;
      }

      // Profile exists — run streak verification
      await _verifyStreak(db);

      return AppInitState.ready;
    } catch (e) {
      debugPrint('App init error: $e');
      // On first ever launch, the DB seeds data via migration.
      // If we get here, something unexpected happened.
      // Default to ready and let the seed data handle it.
      return AppInitState.ready;
    }
  }

  /// Run streak engine on launch to verify/break streaks.
  Future<void> _verifyStreak(QuestFitDatabase db) async {
    try {
      final streaks = await db.select(db.streaks).get();
      if (streaks.isEmpty) return;

      final streak = streaks.first;

      // Verify: if lastActiveDate is not yesterday or today,
      // the streak should reset to 0.
      if (streak.lastActiveDate != null) {
        final today = DateTime.now().toIso8601String().split('T')[0];
        final yesterday = DateTime.now()
            .subtract(const Duration(days: 1))
            .toIso8601String()
            .split('T')[0];

        if (streak.lastActiveDate != today &&
            streak.lastActiveDate != yesterday &&
            streak.currentStreak > 0) {
          // Streak is broken — reset to 0
          await (db.update(db.streaks)
                ..where((t) => t.id.equals(streak.id)))
              .write(StreaksCompanion(
            currentStreak: const Value(0),
            // Keep longest streak
          ));
          debugPrint('Streak broken: was ${streak.currentStreak} days');
        }
      }
    } catch (e) {
      debugPrint('Streak verification error: $e');
    }
  }

  /// Complete the setup flow: update player name and class, then transition.
  Future<void> completeSetup({
    required String name,
    required String classType,
  }) async {
    final db = ref.read(databaseProvider);
    final players = await db.select(db.players).get();

    if (players.isNotEmpty) {
      // Update existing seeded player
      final player = players.first;
      await (db.update(db.players)
            ..where((t) => t.id.equals(player.id)))
          .write(PlayersCompanion(
        name: Value(name),
        classType: Value(classType),
      ));
    }

    // Run streak verification
    await _verifyStreak(db);

    // Transition to ready
    state = const AsyncData(AppInitState.ready);
  }
}
