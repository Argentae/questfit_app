import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import 'database_provider.dart';
import 'bounty_provider.dart';
import 'shop_provider.dart';
import 'step_provider.dart';
import 'user_provider.dart';

/// App initialization state.
enum AppInitState {
  /// Still checking whether a profile exists.
  loading,
  /// No profile found — show setup screen.
  needsSetup,
  /// v2.0: Profile exists but Awakening (first 5 days) not completed.
  awakening,
  /// Profile exists — ready to show home.
  ready,
}

/// Controls the app initialization flow:
/// 1. Check if a player profile exists in Drift
/// 2. Run streak verification on launch
/// 3. v3.0: Process pending promotions and LP decay
/// 4. v2.0: Check Awakening status
/// 5. Transition to ready, awakening, or setup state
final appInitProvider =
    AsyncNotifierProvider<AppInitNotifier, AppInitState>(AppInitNotifier.new);

class AppInitNotifier extends AsyncNotifier<AppInitState> {
  @override
  Future<AppInitState> build() async {
    try {
      debugPrint('QF_INIT: Starting app init...');
      final db = ref.read(databaseProvider);
      final players = await db.select(db.players).get();
      debugPrint('QF_INIT: Found ${players.length} players');

      if (players.isEmpty) {
        return AppInitState.needsSetup;
      }

      final player = players.first;
      debugPrint('QF_INIT: Player "${player.name}" tier=${player.tier} div=${player.division}');

      // Check enemy count
      final enemyCount = await db.select(db.enemies).get();
      debugPrint('QF_INIT: Enemies in DB: ${enemyCount.length}');
      final exCount = await db.select(db.exerciseDb).get();
      debugPrint('QF_INIT: Exercises in DB: ${exCount.length}');

      // Run streak verification (with streak insurance check)
      await _verifyStreak(db);
      debugPrint('QF_INIT: Streak verified');

      // v3.0: Process pending promotion (LP reached 100 yesterday)
      if (player.pendingPromotion) {
        final promoted = await ref
            .read(userNotifierProvider.notifier)
            .processPromotion();
        if (promoted) {
          debugPrint('LP System: Auto-promoted to next division!');
        }
      }

      // v3.0: Check for LP decay (48h inactivity)
      final decayResult = await ref
          .read(userNotifierProvider.notifier)
          .applyInactivityDecay();
      if (decayResult != null) {
        debugPrint('LP Decay: Lost ${decayResult.lpLost} LP'
            '${decayResult.shouldDemote ? " (DEMOTED!)" : ""}');
      }
      debugPrint('QF_INIT: LP decay checked');

      // v2.2: Check and apply Momentum Buff from yesterday's steps
      await ref
          .read(stepNotifierProvider.notifier)
          .checkMomentumBuff();
      debugPrint('QF_INIT: Momentum buff checked');

      // v2.3: Resolve any unresolved bounties from previous days
      final bountyResolution = await ref
          .read(bountyNotifierProvider.notifier)
          .resolveYesterdaysBounty();
      if (bountyResolution != null) {
        debugPrint('Bounty Resolution: '
            '${bountyResolution.isVictory ? "VICTORY" : "DEFEAT"} '
            'LP: ${bountyResolution.lpChange}');
      }
      debugPrint('QF_INIT: Yesterday bounty resolved');

      // v2.3: Generate today's bounty draft if needed
      await ref
          .read(bountyNotifierProvider.notifier)
          .generateDailyDraft();
      debugPrint('QF_INIT: Daily draft generated');

      // Check bounty count
      final bountyCount = await db.select(db.bounties).get();
      debugPrint('QF_INIT: Bounties in DB: ${bountyCount.length}');
      for (final b in bountyCount) {
        debugPrint('QF_INIT: Bounty id=${b.id} date=${b.date} status=${b.status} enemyId=${b.enemyId}');
      }

      // v2.0: Check if Awakening is complete
      // [Bypassed for beta testing]
      // if (!player.awakeningComplete) {
      //   return AppInitState.awakening;
      // }

      debugPrint('QF_INIT: App init complete — READY');
      return AppInitState.ready;
    } catch (e, s) {
      debugPrint('App init error: $e');
      debugPrint('Stack: $s');
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

    // v2.0: Transition to awakening (not ready) since awakening not complete
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
