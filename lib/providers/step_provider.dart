import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../db/database.dart';
import '../engine/step_engine.dart';
import 'database_provider.dart';
import 'user_provider.dart';

// ─── Step State ──────────────────────────────────────────────────────

/// Today's step count (updated after health sync).
final todayStepsProvider = StateProvider<int>((ref) => 0);

/// Momentum Buff active state (derived from player data).
final momentumBuffProvider = Provider<bool>((ref) {
  final player = ref.watch(playerStreamProvider).valueOrNull;
  return player?.momentumBuffActive ?? false;
});

/// Player's daily step goal.
final dailyStepGoalProvider = Provider<int>((ref) {
  final player = ref.watch(playerStreamProvider).valueOrNull;
  return player?.dailyStepGoal ?? 8000;
});

/// Today's step milestone data.
final stepMilestoneProvider = StreamProvider<StepMilestone?>((ref) {
  final db = ref.watch(databaseProvider);
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  return (db.select(db.stepMilestones)
        ..where((t) => t.date.equals(today)))
      .watchSingleOrNull();
});

// ─── Step Notifier ───────────────────────────────────────────────────

class StepState {
  final List<ExpeditionReward> pendingRewards;
  final bool isProcessing;

  const StepState({
    this.pendingRewards = const [],
    this.isProcessing = false,
  });
}

final stepNotifierProvider =
    NotifierProvider<StepNotifier, StepState>(StepNotifier.new);

class StepNotifier extends Notifier<StepState> {
  @override
  StepState build() => const StepState();

  QuestFitDatabase get _db => ref.read(databaseProvider);

  /// Process step milestones after a health sync.
  /// Returns any new rewards earned.
  Future<List<ExpeditionReward>> processSteps(int totalStepsToday) async {
    if (state.isProcessing) return [];
    state = const StepState(isProcessing: true);

    final rewards = <ExpeditionReward>[];
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      // Update today's step count in the state
      ref.read(todayStepsProvider.notifier).state = totalStepsToday;

      // Get or create today's milestone record
      var milestone = await ((_db.select(_db.stepMilestones))
            ..where((t) => t.date.equals(today)))
          .getSingleOrNull();

      final playerId = await _getPlayerId();

      if (milestone == null) {
        // First sync of the day
        await _db.into(_db.stepMilestones).insert(StepMilestonesCompanion(
          playerId: Value(playerId),
          date: Value(today),
          milestonesClaimed: const Value(0),
          stepsAtLastClaim: const Value(0),
        ));
        milestone = await ((_db.select(_db.stepMilestones))
              ..where((t) => t.date.equals(today)))
            .getSingle();
      }

      // Calculate unclaimed milestones
      final unclaimed = StepEngine.unclaimedMilestones(
        totalSteps: totalStepsToday,
        milestonesClaimed: milestone.milestonesClaimed,
      );

      // Generate rewards for each unclaimed milestone
      for (var i = 0; i < unclaimed; i++) {
        final milestoneNum = milestone.milestonesClaimed + i + 1;
        final reward = StepEngine.generateMilestoneReward(milestoneNum);
        rewards.add(reward);

        // Apply the reward
        switch (reward.type) {
          case 'gold':
            await ref
                .read(userNotifierProvider.notifier)
                .awardGold(reward.amount);
            break;
          case 'lp':
            await ref
                .read(userNotifierProvider.notifier)
                .awardLp(reward.amount);
            break;
          case 'egg':
            // Add an egg — handled by companion provider
            // reward.metadata contains the rarity
            break;
        }
      }

      // Update milestone record
      if (unclaimed > 0) {
        final currentMilestone = await ((_db.select(_db.stepMilestones))
              ..where((t) => t.date.equals(today)))
            .getSingle();
        await (_db.update(_db.stepMilestones)
              ..where((t) => t.id.equals(currentMilestone.id)))
            .write(StepMilestonesCompanion(
          milestonesClaimed:
              Value(currentMilestone.milestonesClaimed + unclaimed),
          stepsAtLastClaim: Value(totalStepsToday),
        ));
      }
    } catch (e) {
      debugPrint('StepNotifier.processSteps error: $e');
    }

    state = StepState(pendingRewards: rewards);
    return rewards;
  }

  /// Check and apply Momentum Buff on app launch.
  /// Evaluates yesterday's step milestone data.
  Future<void> checkMomentumBuff() async {
    try {
      final yesterday = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(const Duration(days: 1)));
      final yesterdayMilestone = await ((_db.select(_db.stepMilestones))
            ..where((t) => t.date.equals(yesterday)))
          .getSingleOrNull();

      final dailyGoal = ref.read(dailyStepGoalProvider);
      final yesterdaySteps = yesterdayMilestone?.stepsAtLastClaim ?? 0;

      final shouldActivate = StepEngine.shouldGrantMomentumBuff(
        yesterdaySteps: yesterdaySteps,
        dailyStepGoal: dailyGoal,
      );

      // Update player's momentum buff status
      final player =
          await ((_db.select(_db.players))..limit(1)).getSingle();
      if (player.momentumBuffActive != shouldActivate) {
        await (_db.update(_db.players)
              ..where((t) => t.id.equals(player.id)))
            .write(PlayersCompanion(
          momentumBuffActive: Value(shouldActivate),
        ));
      }
    } catch (e) {
      debugPrint('StepNotifier.checkMomentumBuff error: $e');
    }
  }

  Future<int> _getPlayerId() async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();
    return player.id;
  }

  /// Clear pending rewards (after they've been shown in UI).
  void clearPendingRewards() {
    state = const StepState();
  }
}
