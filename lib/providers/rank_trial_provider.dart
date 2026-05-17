import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import '../engine/rank_engine.dart';
import '../engine/xp_engine.dart';
import 'database_provider.dart';
import 'user_provider.dart';

// ─── Reactive Streams ────────────────────────────────────────────────

/// Watches the currently active rank trial (if any).
final activeTrialProvider = StreamProvider<RankTrial?>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.rankTrials)
        ..where((t) => t.status.equals('active'))
        ..limit(1))
      .watchSingleOrNull();
});

/// Derived: Whether the player is at a promotion boundary
/// (XP capped, needs to start/complete a trial).
final isAtPromotionBoundaryProvider = Provider<AsyncValue<bool>>((ref) {
  final playerAsync = ref.watch(playerStreamProvider);
  return playerAsync.whenData(
    (player) => RankEngine.isPromotionBoundary(player.level),
  );
});

/// Derived: Get current trial requirements for the player's level.
final trialRequirementsProvider = Provider<AsyncValue<TrialRequirement?>>((ref) {
  final playerAsync = ref.watch(playerStreamProvider);
  return playerAsync.whenData((player) {
    if (!RankEngine.isPromotionBoundary(player.level)) return null;
    return RankEngine.getTrialRequirements(player.level);
  });
});

// ─── Mutations ───────────────────────────────────────────────────────

final rankTrialNotifierProvider =
    AsyncNotifierProvider<RankTrialNotifier, void>(RankTrialNotifier.new);

class RankTrialNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  QuestFitDatabase get _db => ref.read(databaseProvider);

  /// Start a promotion trial. Can only start if at a promotion boundary
  /// and no active trial exists.
  Future<bool> startTrial() async {
    final player = await ((_db.select(_db.players))..limit(1)).getSingle();

    if (!RankEngine.isPromotionBoundary(player.level)) return false;

    // Check for existing active trial
    final existing = await (_db.select(_db.rankTrials)
          ..where((t) =>
              t.playerId.equals(player.id) & t.status.equals('active')))
        .getSingleOrNull();
    if (existing != null) return false;

    final req = RankEngine.getTrialRequirements(player.level);

    await _db.into(_db.rankTrials).insert(RankTrialsCompanion(
      playerId: Value(player.id),
      targetRank: Value(req.targetRankKey),
      trialType: Value(req.trialType),
      status: const Value('active'),
      streakDaysCompleted: const Value(0),
      requiredStreakDays: Value(req.requiredStreakDays),
      calorieGoal: Value(req.calorieGoal),
      stepGoal: Value(req.stepGoal),
      caloriesAchieved: const Value(0),
      stepsAchieved: const Value(0),
    ));

    return true;
  }

  /// Update consistency trial progress (called on streak check-in).
  Future<void> updateConsistencyProgress(int currentStreak) async {
    final player = await ((_db.select(_db.players))..limit(1)).getSingle();
    final trial = await (_db.select(_db.rankTrials)
          ..where((t) =>
              t.playerId.equals(player.id) &
              t.status.equals('active') &
              t.trialType.equals('consistency')))
        .getSingleOrNull();

    if (trial == null) return;

    final newDays = trial.streakDaysCompleted + 1;

    if (newDays >= trial.requiredStreakDays) {
      // Trial passed!
      await (_db.update(_db.rankTrials)
            ..where((t) => t.id.equals(trial.id)))
          .write(RankTrialsCompanion(
        streakDaysCompleted: Value(newDays),
        status: const Value('passed'),
        completedAt: Value(DateTime.now()),
      ));
    } else {
      await (_db.update(_db.rankTrials)
            ..where((t) => t.id.equals(trial.id)))
          .write(RankTrialsCompanion(
        streakDaysCompleted: Value(newDays),
      ));
    }
  }

  /// Update gatekeeper trial progress with health data.
  Future<void> updateGatekeeperProgress({
    required int calories,
    required int steps,
  }) async {
    final player = await ((_db.select(_db.players))..limit(1)).getSingle();
    final trial = await (_db.select(_db.rankTrials)
          ..where((t) =>
              t.playerId.equals(player.id) &
              t.status.equals('active') &
              t.trialType.equals('gatekeeper')))
        .getSingleOrNull();

    if (trial == null) return;

    final newCalories = trial.caloriesAchieved + calories;
    final newSteps = trial.stepsAchieved + steps;

    final caloriesMet = trial.calorieGoal == null || newCalories >= trial.calorieGoal!;
    final stepsMet = trial.stepGoal == null || newSteps >= trial.stepGoal!;

    if (caloriesMet && stepsMet) {
      // Trial passed!
      await (_db.update(_db.rankTrials)
            ..where((t) => t.id.equals(trial.id)))
          .write(RankTrialsCompanion(
        caloriesAchieved: Value(newCalories),
        stepsAchieved: Value(newSteps),
        status: const Value('passed'),
        completedAt: Value(DateTime.now()),
      ));
    } else {
      await (_db.update(_db.rankTrials)
            ..where((t) => t.id.equals(trial.id)))
          .write(RankTrialsCompanion(
        caloriesAchieved: Value(newCalories),
        stepsAchieved: Value(newSteps),
      ));
    }
  }

  /// Fail a trial due to streak break or time expiry.
  /// Applies rank decay (15% XP loss).
  Future<XpDecayResult?> failTrial() async {
    final player = await ((_db.select(_db.players))..limit(1)).getSingle();
    final trial = await (_db.select(_db.rankTrials)
          ..where((t) =>
              t.playerId.equals(player.id) & t.status.equals('active')))
        .getSingleOrNull();

    if (trial == null) return null;

    // Mark trial as failed
    await (_db.update(_db.rankTrials)
          ..where((t) => t.id.equals(trial.id)))
        .write(RankTrialsCompanion(
      status: const Value('failed'),
      completedAt: Value(DateTime.now()),
    ));

    // Apply rank decay
    final decay = XpEngine.applyDecay(
      currentXp: player.xp,
      totalXp: player.totalXp,
      decayPercentage: RankEngine.decayPercentage,
    );

    await (_db.update(_db.players)
          ..where((t) => t.id.equals(player.id)))
        .write(PlayersCompanion(
      xp: Value(decay.newXp),
    ));

    return decay;
  }

  /// Complete a passed trial — allow the player to level up past the boundary.
  Future<void> promotePastBoundary() async {
    final player = await ((_db.select(_db.players))..limit(1)).getSingle();

    // Check for a passed trial
    final trial = await (_db.select(_db.rankTrials)
          ..where((t) =>
              t.playerId.equals(player.id) & t.status.equals('passed')))
        .getSingleOrNull();

    if (trial == null) return;

    // Re-process the capped XP with the trial flag
    final result = XpEngine.addXp(
      currentLevel: player.level,
      currentXp: player.xp,
      totalXp: player.totalXp,
      amount: 0, // No new XP, just uncap
      hasActiveTrialOrPassed: true,
    );

    // If the player had enough XP to level up, apply it
    if (result.didLevelUp) {
      await (_db.update(_db.players)
            ..where((t) => t.id.equals(player.id)))
          .write(PlayersCompanion(
        level: Value(result.newLevel),
        xp: Value(result.newXp),
        rank: Value(RankEngine.getRankKey(result.newLevel)),
      ));

      // Record rank history
      if (RankEngine.didRankUp(player.level, result.newLevel)) {
        await _db.into(_db.rankHistory).insert(RankHistoryCompanion(
          playerId: Value(player.id),
          rank: Value(RankEngine.getRankKey(result.newLevel)),
          achievedAt: Value(DateTime.now()),
        ));
      }
    }
  }

  /// Check if a gatekeeper trial has expired (24h time limit).
  Future<bool> checkTrialExpiry() async {
    final player = await ((_db.select(_db.players))..limit(1)).getSingle();
    final trial = await (_db.select(_db.rankTrials)
          ..where((t) =>
              t.playerId.equals(player.id) &
              t.status.equals('active') &
              t.trialType.equals('gatekeeper')))
        .getSingleOrNull();

    if (trial == null) return false;

    final elapsed = DateTime.now().difference(trial.startedAt);
    if (elapsed.inHours >= 24) {
      await failTrial();
      return true;
    }

    return false;
  }
}
