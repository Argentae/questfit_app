// QuestFit v2.3 — Bounty Provider
// Manages the daily bounty lifecycle: Draft → Lock-in → Combat → Resolution.

import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import '../data/enemy_catalog.dart';
import '../engine/combat_engine.dart';
import 'database_provider.dart';
import 'user_provider.dart';

// ─── Reactive Streams ────────────────────────────────────────────────

/// Today's active bounty (if any).
final activeBountyProvider = StreamProvider<Bounty?>((ref) {
  final db = ref.watch(databaseProvider);
  final today = DateTime.now().toIso8601String().split('T')[0];
  return (db.select(db.bounties)
        ..where((t) => t.date.equals(today))
        ..limit(1))
      .watchSingleOrNull();
});

/// Watches the locked-in enemy for the active bounty.
final activeEnemyProvider = FutureProvider<Enemy?>((ref) async {
  final bounty = ref.watch(activeBountyProvider).value;
  if (bounty == null || bounty.enemyId == null) return null;

  final db = ref.read(databaseProvider);
  return (db.select(db.enemies)
        ..where((t) => t.id.equals(bounty.enemyId!)))
      .getSingleOrNull();
});

/// The 3 drafted enemies for today.
final draftedEnemiesProvider = FutureProvider<List<Enemy>>((ref) async {
  final bountyAsync = ref.watch(activeBountyProvider);
  final bounty = bountyAsync.value;
  if (bounty == null) return [];

  final draftedIds = (jsonDecode(bounty.draftedEnemyIds) as List)
      .map((e) => e as int)
      .toList();
  if (draftedIds.isEmpty) return [];

  final db = ref.read(databaseProvider);
  return (db.select(db.enemies)
        ..where((t) => t.id.isIn(draftedIds)))
      .get();
});

/// Routine exercises for the active bounty.
final routineExercisesProvider = StreamProvider<List<RoutineExercise>>((ref) {
  final bountyAsync = ref.watch(activeBountyProvider);
  final bounty = bountyAsync.value;
  if (bounty == null) return Stream.value([]);

  final db = ref.read(databaseProvider);
  return (db.select(db.routineExercises)
        ..where((t) => t.bountyId.equals(bounty.id))
        ..orderBy([(t) => OrderingTerm.asc(t.id)]))
      .watch();
});

/// Enemy HP percentage for the health bar (0.0 to 1.0).
final enemyHpPercentProvider = Provider<double>((ref) {
  final bountyAsync = ref.watch(activeBountyProvider);
  final enemyAsync = ref.watch(activeEnemyProvider);

  final bounty = bountyAsync.value;
  final enemy = enemyAsync.value;

  if (bounty == null || enemy == null) return 1.0;
  if (enemy.hp <= 0) return 0.0;

  return (bounty.currentHp / enemy.hp).clamp(0.0, 1.0);
});

/// Total damage dealt so far in the active bounty.
final totalDamageDealtProvider = Provider<int>((ref) {
  final routineAsync = ref.watch(routineExercisesProvider);
  final exercises = routineAsync.value ?? [];
  return exercises.where((e) => e.isCompleted).fold(0, (sum, e) => sum + e.damageDealt);
});

// ─── Mutations ───────────────────────────────────────────────────────

final bountyNotifierProvider =
    AsyncNotifierProvider<BountyNotifier, void>(BountyNotifier.new);

class BountyNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  QuestFitDatabase get _db => ref.read(databaseProvider);

  /// Generate today's bounty draft (3 enemies: easy/medium/hard).
  /// Called on app launch if no bounty exists for today.
  Future<void> generateDailyDraft() async {
    final today = DateTime.now().toIso8601String().split('T')[0];

    // Check if a bounty already exists for today
    final existing = await (_db.select(_db.bounties)
          ..where((t) => t.date.equals(today)))
        .getSingleOrNull();
    if (existing != null) return;

    // Get player tier for enemy scaling
    final player = await (_db.select(_db.players)..limit(1)).getSingle();

    // Get all enemies from DB, filter by tier
    final allEnemies = await _db.select(_db.enemies).get();
    final tierIdx = tierOrder.indexOf(player.tier.toLowerCase());
    final validTiers = <String>{};
    if (tierIdx >= 0) {
      validTiers.add(tierOrder[tierIdx]);
      if (tierIdx > 0) validTiers.add(tierOrder[tierIdx - 1]);
    } else {
      validTiers.add('iron');
    }

    final pool = allEnemies.where((e) => validTiers.contains(e.tier)).toList();
    if (pool.isEmpty) return;

    // Pick one easy, one medium, one hard
    final easy = pool.where((e) => e.difficulty == 'easy').toList()..shuffle();
    final medium = pool.where((e) => e.difficulty == 'medium').toList()..shuffle();
    final hard = pool.where((e) => e.difficulty == 'hard').toList()..shuffle();

    final draftIds = <int>[];
    if (easy.isNotEmpty) draftIds.add(easy.first.id);
    if (medium.isNotEmpty) draftIds.add(medium.first.id);
    if (hard.isNotEmpty) draftIds.add(hard.first.id);

    // Fallback: fill from any available if we don't have 3
    if (draftIds.length < 3) {
      for (final e in pool) {
        if (!draftIds.contains(e.id)) {
          draftIds.add(e.id);
          if (draftIds.length >= 3) break;
        }
      }
    }

    // Create the bounty in drafting state
    await _db.into(_db.bounties).insert(BountiesCompanion(
      playerId: Value(player.id),
      date: Value(today),
      status: const Value('drafting'),
      draftedEnemyIds: Value(jsonEncode(draftIds)),
    ));

    debugPrint('Bounty: Generated draft with ${draftIds.length} enemies');
  }

  /// Lock in an enemy from the draft. Transitions to "combat" state.
  Future<void> lockInEnemy(int enemyId) async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final bounty = await (_db.select(_db.bounties)
          ..where((t) => t.date.equals(today)))
        .getSingle();

    final enemy = await (_db.select(_db.enemies)
          ..where((t) => t.id.equals(enemyId)))
        .getSingle();

    await (_db.update(_db.bounties)
          ..where((t) => t.id.equals(bounty.id)))
        .write(BountiesCompanion(
      enemyId: Value(enemyId),
      status: const Value('combat'),
      currentHp: Value(enemy.hp),
      lockedAt: Value(DateTime.now()),
    ));

    debugPrint('Bounty: Locked in ${enemy.name} (HP: ${enemy.hp})');
  }

  /// Add an exercise from the Grimoire to the routine.
  Future<void> addExerciseToRoutine({
    required int bountyId,
    required int exerciseDbId,
    required int sets,
    int? reps,
    int? duration,
  }) async {
    await _db.into(_db.routineExercises).insert(RoutineExercisesCompanion(
      bountyId: Value(bountyId),
      exerciseDbId: Value(exerciseDbId),
      sets: Value(sets),
      reps: Value(reps),
      duration: Value(duration),
    ));
  }

  /// Remove an exercise from the routine.
  Future<void> removeExerciseFromRoutine(int routineExerciseId) async {
    await (_db.delete(_db.routineExercises)
          ..where((t) => t.id.equals(routineExerciseId)))
        .go();
  }

  /// Complete an exercise — calculates damage and updates enemy HP.
  /// Returns the damage dealt.
  Future<int> completeExercise(int routineExerciseId) async {
    // Get the routine exercise
    final routineEx = await (_db.select(_db.routineExercises)
          ..where((t) => t.id.equals(routineExerciseId)))
        .getSingle();

    if (routineEx.isCompleted) return 0;

    // Get the exercise definition
    final exercise = await (_db.select(_db.exerciseDb)
          ..where((t) => t.id.equals(routineEx.exerciseDbId)))
        .getSingle();

    // Get the bounty and enemy
    final bounty = await (_db.select(_db.bounties)
          ..where((t) => t.id.equals(routineEx.bountyId)))
        .getSingle();

    final enemy = await (_db.select(_db.enemies)
          ..where((t) => t.id.equals(bounty.enemyId!)))
        .getSingle();

    // Parse enemy weakness/resistance arrays
    final weaknesses = (jsonDecode(enemy.weaknesses) as List).cast<String>();
    final resistances = (jsonDecode(enemy.resistances) as List).cast<String>();
    final immunities = (jsonDecode(enemy.immunities) as List).cast<String>();

    // Get player to apply rhythm buffs
    final player = await (_db.select(_db.players)..limit(1)).getSingle();

    // Calculate damage
    final baseDmg = CombatEngine.calculateExerciseDamage(
      sets: routineEx.sets,
      reps: routineEx.reps,
      duration: routineEx.duration,
      exerciseLevel: exercise.level,
      exerciseCategory: exercise.category,
      weaknesses: weaknesses,
      resistances: resistances,
      immunities: immunities,
    );
    
    // v2.5: Apply Sleep Buff Multiplier
    final dmg = (baseDmg * player.restBuffMultiplier).round();

    // Update routine exercise as completed
    await (_db.update(_db.routineExercises)
          ..where((t) => t.id.equals(routineExerciseId)))
        .write(RoutineExercisesCompanion(
      isCompleted: const Value(true),
      completedAt: Value(DateTime.now()),
      damageDealt: Value(dmg.totalDamage),
    ));

    // Deduct damage from enemy HP
    final newHp = (bounty.currentHp - dmg.totalDamage).clamp(0, enemy.hp);
    await (_db.update(_db.bounties)
          ..where((t) => t.id.equals(bounty.id)))
        .write(BountiesCompanion(
      currentHp: Value(newHp),
    ));

    debugPrint('Combat: Dealt ${dmg.totalDamage} dmg (${dmg.effectiveness}). '
        'Enemy HP: $newHp/${enemy.hp}');

    // Check for victory
    if (newHp <= 0) {
      await _resolveVictory(bounty.id);
    }

    return dmg.totalDamage;
  }

  /// Uncomplete an exercise — reverses the damage.
  Future<void> uncompleteExercise(int routineExerciseId) async {
    final routineEx = await (_db.select(_db.routineExercises)
          ..where((t) => t.id.equals(routineExerciseId)))
        .getSingle();

    if (!routineEx.isCompleted) return;

    // Get bounty and restore HP
    final bounty = await (_db.select(_db.bounties)
          ..where((t) => t.id.equals(routineEx.bountyId)))
        .getSingle();

    final enemy = await (_db.select(_db.enemies)
          ..where((t) => t.id.equals(bounty.enemyId!)))
        .getSingle();

    final restoredHp = (bounty.currentHp + routineEx.damageDealt).clamp(0, enemy.hp);

    // Undo the exercise completion
    await (_db.update(_db.routineExercises)
          ..where((t) => t.id.equals(routineExerciseId)))
        .write(const RoutineExercisesCompanion(
      isCompleted: Value(false),
      completedAt: Value(null),
      damageDealt: Value(0),
    ));

    // Restore enemy HP and revert status if previously won
    await (_db.update(_db.bounties)
          ..where((t) => t.id.equals(bounty.id)))
        .write(BountiesCompanion(
      currentHp: Value(restoredHp),
      status: const Value('combat'),
    ));
  }

  /// Resolve a bounty as Victory.
  Future<BountyResolution> _resolveVictory(int bountyId) async {
    final bounty = await (_db.select(_db.bounties)
          ..where((t) => t.id.equals(bountyId)))
        .getSingle();

    final enemy = await (_db.select(_db.enemies)
          ..where((t) => t.id.equals(bounty.enemyId!)))
        .getSingle();

    final resolution = CombatEngine.resolveBounty(
      enemyMaxHp: enemy.hp,
      enemyCurrentHp: bounty.currentHp,
      lpReward: enemy.lpReward,
      goldReward: enemy.goldReward,
      lpPenalty: enemy.lpPenalty,
      difficulty: enemy.difficulty,
    );

    // Award LP and Gold
    await ref.read(userNotifierProvider.notifier).awardLp(resolution.lpChange);
    await ref.read(userNotifierProvider.notifier).awardGold(resolution.goldChange);

    // Mark bounty as victory
    await (_db.update(_db.bounties)
          ..where((t) => t.id.equals(bountyId)))
        .write(BountiesCompanion(
      status: const Value('victory'),
      resolvedAt: Value(DateTime.now()),
    ));

    debugPrint('Bounty: VICTORY! +${resolution.lpChange} LP, +${resolution.goldChange} Gold');

    return resolution;
  }

  /// Resolve an unresolved bounty as Defeat (called on app launch for past days).
  Future<BountyResolution?> resolveYesterdaysBounty() async {
    final today = DateTime.now().toIso8601String().split('T')[0];

    // Find unresolved bounties from before today
    final unresolved = await (_db.select(_db.bounties)
          ..where((t) =>
              t.date.isSmallerThanValue(today) &
              t.status.isIn(['drafting', 'combat', 'preparing'])))
        .get();

    if (unresolved.isEmpty) return null;

    BountyResolution? lastResolution;

    for (final bounty in unresolved) {
      if (bounty.enemyId == null) {
        // Never locked in — treat as skipped, no penalty
        await (_db.update(_db.bounties)
              ..where((t) => t.id.equals(bounty.id)))
            .write(BountiesCompanion(
          status: const Value('defeat'),
          resolvedAt: Value(DateTime.now()),
        ));
        continue;
      }

      final enemy = await (_db.select(_db.enemies)
            ..where((t) => t.id.equals(bounty.enemyId!)))
          .getSingle();

      final resolution = CombatEngine.resolveBounty(
        enemyMaxHp: enemy.hp,
        enemyCurrentHp: bounty.currentHp,
        lpReward: enemy.lpReward,
        goldReward: enemy.goldReward,
        lpPenalty: enemy.lpPenalty,
        difficulty: enemy.difficulty,
      );

      // Apply LP penalty
      if (!resolution.isVictory) {
        await ref.read(userNotifierProvider.notifier).applyLpPenalty(
            resolution.lpChange.abs());

        // Break streak
        final streak = await (_db.select(_db.streaks)..limit(1)).getSingle();
        await (_db.update(_db.streaks)
              ..where((t) => t.id.equals(streak.id)))
            .write(const StreaksCompanion(
          currentStreak: Value(0),
        ));
      }

      // Mark as defeat
      await (_db.update(_db.bounties)
            ..where((t) => t.id.equals(bounty.id)))
          .write(BountiesCompanion(
        status: const Value('defeat'),
        resolvedAt: Value(DateTime.now()),
      ));

      debugPrint('Bounty: DEFEAT on ${bounty.date}. '
          'LP penalty: ${resolution.lpChange}');

      lastResolution = resolution;
    }

    return lastResolution;
  }

  /// Get the damage preview for the current routine against the enemy.
  Future<RoutineDamagePreview?> getRoutineDamagePreview() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final bounty = await (_db.select(_db.bounties)
          ..where((t) => t.date.equals(today)))
        .getSingleOrNull();

    if (bounty == null || bounty.enemyId == null) return null;

    final enemy = await (_db.select(_db.enemies)
          ..where((t) => t.id.equals(bounty.enemyId!)))
        .getSingle();

    final routineExs = await (_db.select(_db.routineExercises)
          ..where((t) => t.bountyId.equals(bounty.id)))
        .get();

    // Build input list from routine exercises
    final inputs = <RoutineExerciseInput>[];
    for (final re in routineExs) {
      final exercise = await (_db.select(_db.exerciseDb)
            ..where((t) => t.id.equals(re.exerciseDbId)))
          .getSingle();

      inputs.add(RoutineExerciseInput(
        sets: re.sets,
        reps: re.reps,
        duration: re.duration,
        level: exercise.level,
        category: exercise.category,
      ));
    }

    final weaknesses = (jsonDecode(enemy.weaknesses) as List).cast<String>();
    final resistances = (jsonDecode(enemy.resistances) as List).cast<String>();
    final immunities = (jsonDecode(enemy.immunities) as List).cast<String>();

    return CombatEngine.previewRoutineDamage(
      exercises: inputs,
      weaknesses: weaknesses,
      resistances: resistances,
      immunities: immunities,
      enemyHp: enemy.hp,
    );
  }
}
