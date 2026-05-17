import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import 'database_provider.dart';
import 'shop_provider.dart';

/// App initialization state.
enum AppInitState {
  /// Still checking whether a profile exists.
  loading,
  /// No profile found — show setup screen.
  needsSetup,
  /// v2.0: Profile exists but Awakening (Levels 1-5) not completed.
  awakening,
  /// Profile exists — ready to show home.
  ready,
}

/// Controls the app initialization flow:
/// 1. Check if a player profile exists in Drift
/// 2. Run streak verification on launch
/// 3. v2.0: Check Awakening status (locked until Level 5)
/// 4. Transition to ready, awakening, or setup state
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

      final player = players.first;

      // Run streak verification (with streak insurance check)
      await _verifyStreak(db);

      // v2.0: Check if Awakening is complete
      if (!player.awakeningComplete && player.level < 5) {
        // Auto-repair: if player level was bumped by a buggy health sync
        // during Awakening, reset back to level 1
        if (player.level > 1) {
          await (db.update(db.players)
                ..where((t) => t.id.equals(player.id)))
              .write(const PlayersCompanion(
            level: Value(1),
            xp: Value(0),
            totalXp: Value(0),
          ));
          debugPrint('Awakening: auto-repaired player level from ${player.level} to 1');
        }
        return AppInitState.awakening;
      }

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
  /// v2.0: Checks for Streak Insurance consumable before breaking.
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

          // v2.0: Check for Streak Insurance before breaking
          final hasInsurance = await ref
              .read(shopNotifierProvider.notifier)
              .useConsumable('streak_insurance');

          if (hasInsurance) {
            // Insurance consumed — preserve streak, update last active to yesterday
            await (db.update(db.streaks)
                  ..where((t) => t.id.equals(streak.id)))
                .write(StreaksCompanion(
              lastActiveDate: Value(yesterday),
            ));
            debugPrint('Streak Insurance consumed! Streak preserved at ${streak.currentStreak}');
          } else {
            // Streak is broken — reset to 0
            await (db.update(db.streaks)
                  ..where((t) => t.id.equals(streak.id)))
                .write(const StreaksCompanion(
              currentStreak: Value(0),
              // Keep longest streak
            ));
            debugPrint('Streak broken: was ${streak.currentStreak} days');
          }
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

    // v2.0: Transition to awakening (not ready) since Level < 5
    state = const AsyncData(AppInitState.awakening);
  }

  /// v2.0: Mark Awakening as complete and transition to ready.
  Future<void> completeAwakening() async {
    final db = ref.read(databaseProvider);
    final players = await db.select(db.players).get();

    if (players.isNotEmpty) {
      final player = players.first;
      await (db.update(db.players)
            ..where((t) => t.id.equals(player.id)))
          .write(const PlayersCompanion(
        awakeningComplete: Value(true),
      ));
    }

    state = const AsyncData(AppInitState.ready);
  }
}
