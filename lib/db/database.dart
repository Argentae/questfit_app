import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables.dart';
import '../data/weapon_catalog.dart';
import '../data/enemy_catalog.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Players, Stats, Quests, WorkoutLogs, Streaks, RankHistory,
  // v2.0 tables
  Equipment, EquipmentExercises, EquippedSlots, Inventory, RankTrials,
  // v2.2 tables
  ExerciseDb, StepMilestones, Eggs, Companions,
  // v2.3 tables
  Enemies, Bounties, RoutineExercises,
  // v2.5 tables
  Routines, RoutineBuilderExercises,
  Bestiary, Consumables,
])
class QuestFitDatabase extends _$QuestFitDatabase {
  QuestFitDatabase._() : super(_openConnection());

  static QuestFitDatabase? _instance;

  /// Singleton accessor.
  static QuestFitDatabase get instance {
    _instance ??= QuestFitDatabase._();
    return _instance!;
  }

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // Seed default player on first run
          await _seedInitialData();
          // Seed weapon catalog
          await _seedWeaponCatalog();
          // v2.2: Seed exercise database
          await _seedExerciseDatabase();
          // v2.3: Seed enemy catalog
          await _seedEnemyCatalog();
        },
        onUpgrade: (m, from, to) async {
          Future<void> safeAddCol(TableInfo t, GeneratedColumn c) async {
            try { await m.addColumn(t, c); } catch (e) {
              if (!e.toString().contains('duplicate column')) rethrow;
            }
          }
          Future<void> safeCreateTab(TableInfo t) async {
            try { await m.createTable(t); } catch (e) {
              if (!e.toString().contains('already exists')) rethrow;
            }
          }

          if (from < 2) {
            // v1 → v2 migration: add new columns and tables
            await safeAddCol(players, players.gold);
            await safeAddCol(players, players.awakeningComplete);
            await safeAddCol(quests, quests.goldReward);
            await safeCreateTab(equipment);
            await safeCreateTab(equipmentExercises);
            await safeCreateTab(equippedSlots);
            await safeCreateTab(inventory);
            await safeCreateTab(rankTrials);
            // Seed weapon catalog for existing users
            await _seedWeaponCatalog();
          }
          if (from < 3) {
            // v2 → v3 migration: LP/Tier system
            await safeAddCol(players, players.tier);
            await safeAddCol(players, players.division);
            await safeAddCol(players, players.lp);
            await safeAddCol(players, players.totalQuestsCompleted);
            await safeAddCol(players, players.lastActivityAt);
            await safeAddCol(players, players.pendingPromotion);
            await safeAddCol(quests, quests.lpReward);

            // Migrate existing player rank data to new tier/division columns
            await _migrateRankToTier();
          }
          if (from < 4) {
            // v3 → v4 migration: Exercise DB, Step mechanics, Companions
            await safeCreateTab(exerciseDb);
            await safeCreateTab(stepMilestones);
            await safeCreateTab(eggs);
            await safeCreateTab(companions);
            await safeAddCol(players, players.dailyStepGoal);
            await safeAddCol(players, players.momentumBuffActive);
            // Seed the exercise database for existing users
            await _seedExerciseDatabase();
          }
          if (from < 5) {
            // v4 → v5 migration: Bounty Hunt combat system
            await safeCreateTab(enemies);
            await safeCreateTab(bounties);
            await safeCreateTab(routineExercises);
            // Seed enemy catalog for existing users
            await _seedEnemyCatalog();
          }
          if (from < 6) {
            // v5 → v6 migration: Rhythm System (Samsung Health)
            await safeAddCol(players, players.aether);
            await safeAddCol(players, players.lastSleepMinutes);
            await safeAddCol(players, players.restBuffMultiplier);
            await safeAddCol(players, players.lastHealthSync);
          }
          if (from < 7) {
            // v6 → v7 migration: Grimoire favorites
            await safeAddCol(exerciseDb, exerciseDb.isFavorite);
          }
          if (from < 8) {
            // v7 → v8 migration: Routines and PR Tracking
            await safeCreateTab(routines);
            await safeCreateTab(routineBuilderExercises);
            await safeAddCol(workoutLogs, workoutLogs.weight);
            await safeAddCol(workoutLogs, workoutLogs.reps);
          }
          if (from < 9) {
            // v8 → v9 migration: Bestiary and Companions Expansion
            await safeCreateTab(bestiary);
            await safeCreateTab(consumables);
            await safeAddCol(companions, companions.level);
            await safeAddCol(companions, companions.xp);
            await safeAddCol(companions, companions.hunger);
            await safeAddCol(companions, companions.bond);
          }
        },
        beforeOpen: (details) async {
          // Fix potentially null columns from legacy migrations.
          // Use single quotes for SQL string literals.
          // Wrap in try-catch so a missing table/column doesn't crash the app.
          try {
            await customStatement("UPDATE players SET gold = 0 WHERE gold IS NULL");
            await customStatement("UPDATE players SET awakening_complete = 0 WHERE awakening_complete IS NULL");
            await customStatement("UPDATE players SET tier = 'iron' WHERE tier IS NULL");
            await customStatement("UPDATE players SET division = 4 WHERE division IS NULL");
            await customStatement("UPDATE players SET lp = 0 WHERE lp IS NULL");
            await customStatement("UPDATE players SET total_quests_completed = 0 WHERE total_quests_completed IS NULL");
            await customStatement("UPDATE players SET pending_promotion = 0 WHERE pending_promotion IS NULL");
            await customStatement("UPDATE players SET daily_step_goal = 8000 WHERE daily_step_goal IS NULL");
            await customStatement("UPDATE players SET momentum_buff_active = 0 WHERE momentum_buff_active IS NULL");
            await customStatement("UPDATE players SET aether = 0 WHERE aether IS NULL");
            await customStatement("UPDATE players SET last_sleep_minutes = 0 WHERE last_sleep_minutes IS NULL");
            await customStatement("UPDATE players SET rest_buff_multiplier = 1.0 WHERE rest_buff_multiplier IS NULL");
          } catch (_) {}
          try {
            await customStatement("UPDATE exercise_db SET is_favorite = 0 WHERE is_favorite IS NULL");
          } catch (_) {}
          try {
            await customStatement("UPDATE quests SET gold_reward = 0 WHERE gold_reward IS NULL");
            await customStatement("UPDATE quests SET lp_reward = 0 WHERE lp_reward IS NULL");
          } catch (_) {}

          // Safety: re-seed reference data if tables are empty
          // (handles case where DB was already at v5 but seeding failed)
          try {
            final enemyCount = await select(enemies).get();
            if (enemyCount.isEmpty) {
              await _seedEnemyCatalog();
            }
          } catch (_) {}
          try {
            final exerciseCount = await select(exerciseDb).get();
            if (exerciseCount.isEmpty) {
              await _seedExerciseDatabase();
            }
          } catch (_) {}
        },
      );

  /// Migrates legacy rank string (e.g. 'iron_1') into tier + division columns.
  Future<void> _migrateRankToTier() async {
    // Use customSelect to avoid mapping to the full Player object,
    // which expects newer columns to be non-null (they might be null until beforeOpen runs).
    final playerRows = await customSelect('SELECT id, rank FROM players').get();
    for (final row in playerRows) {
      final id = row.read<int>('id');
      final rank = row.read<String>('rank');
      // Parse legacy rank key like 'iron_1', 'bronze_3'
      final parts = rank.split('_');
      final tierName = parts.isNotEmpty ? parts[0] : 'iron';
      final div = parts.length > 1 ? int.tryParse(parts[1]) ?? 4 : 4;

      await (update(players)..where((t) => t.id.equals(id))).write(
        PlayersCompanion(
          tier: Value(tierName),
          division: Value(div),
          lp: const Value(0),
          pendingPromotion: const Value(false),
        ),
      );
    }
  }

  /// Seeds a new player at Iron IV, 0 LP on first launch.
  Future<void> _seedInitialData() async {
    final now = DateTime.now();

    // Insert default player
    final playerId = await into(players).insert(PlayersCompanion(
      name: const Value('Adventurer'),
      level: const Value(1),
      xp: const Value(0),
      totalXp: const Value(0),
      tier: const Value('iron'),
      division: const Value(4),
      lp: const Value(0),
      totalQuestsCompleted: const Value(0),
      pendingPromotion: const Value(false),
      rank: const Value('iron_4'),
      classType: const Value('berserker'),
      gold: const Value(0),
      awakeningComplete: const Value(false),
      createdAt: Value(now),
    ));

    // Insert stats
    await into(stats).insert(StatsCompanion(
      playerId: Value(playerId),
      str: const Value(0),
      end: const Value(0),
      agi: const Value(0),
      updatedAt: Value(now),
    ));

    // Insert streak
    await into(streaks).insert(StreaksCompanion(
      playerId: Value(playerId),
      currentStreak: const Value(0),
      longestStreak: const Value(0),
    ));

    // Record initial rank
    await into(rankHistory).insert(RankHistoryCompanion(
      playerId: Value(playerId),
      rank: const Value('iron_4'),
      achievedAt: Value(now),
    ));

    // Seed starter consumable inventory
    await into(inventory).insert(InventoryCompanion(
      playerId: Value(playerId),
      itemKey: const Value('streak_insurance'),
      quantity: const Value(0),
    ));
    await into(inventory).insert(InventoryCompanion(
      playerId: Value(playerId),
      itemKey: const Value('quest_reroll'),
      quantity: const Value(0),
    ));
  }

  /// Seeds the 20 weapons + their exercise linkages from the catalog.
  Future<void> _seedWeaponCatalog() async {
    for (final def in weaponCatalog) {
      // Check if already seeded (for upgrade path)
      final existing = await (select(equipment)
            ..where((t) => t.key.equals(def.key)))
          .get();
      if (existing.isNotEmpty) continue;

      final equipId = await into(equipment).insert(EquipmentCompanion(
        key: Value(def.key),
        name: Value(def.name),
        description: Value(def.description),
        rarity: Value(def.rarity),
        imagePath: Value(def.imagePath),
        category: Value(def.category),
        isOwned: Value(def.isOwned),
        price: Value(def.price),
      ));

      // Seed linked exercises
      for (final ex in def.exercises) {
        await into(equipmentExercises).insert(EquipmentExercisesCompanion(
          equipmentId: Value(equipId),
          exerciseTitle: Value(ex.title),
          exerciseCategory: Value(ex.category),
          sets: Value(ex.sets),
          reps: Value(ex.reps),
          duration: Value(ex.duration),
          baseXp: Value(ex.baseXp),
          emoji: Value(ex.emoji),
        ));
      }
    }
  }

  /// Seeds the expanded exercise library from the bundled JSON asset.
  Future<void> _seedExerciseDatabase() async {
    // Check if already seeded
    final count = await (selectOnly(exerciseDb)..addColumns([exerciseDb.id.count()])).map((r) => r.read(exerciseDb.id.count()) ?? 0).getSingle();
    if (count > 0) return;

    final jsonStr = await rootBundle.loadString('assets/data/exercises.json');
    final List<dynamic> exercises = jsonDecode(jsonStr);

    await batch((b) {
      for (final ex in exercises) {
        b.insert(exerciseDb, ExerciseDbCompanion(
          externalId: Value(ex['id'] as String? ?? ex['name'] as String),
          name: Value(ex['name'] as String),
          force: Value(ex['force'] as String?),
          level: Value(ex['level'] as String? ?? 'beginner'),
          mechanic: Value(ex['mechanic'] as String?),
          equipment: Value(ex['equipment'] as String?),
          category: Value(ex['category'] as String? ?? 'strength'),
          instructions: Value(jsonEncode(ex['instructions'] ?? [])),
          primaryMuscles: Value((ex['primaryMuscles'] as List?)?.join(',') ?? ''),
          secondaryMuscles: Value((ex['secondaryMuscles'] as List?)?.join(',') ?? ''),
          images: Value(jsonEncode(ex['images'] ?? [])),
        ));
      }
    });
  }

  /// v2.3: Seeds the enemy catalog from the enemy_catalog.dart definitions.
  Future<void> _seedEnemyCatalog() async {
    // Check if already seeded
    final count = await (selectOnly(enemies)..addColumns([enemies.id.count()]))
        .map((r) => r.read(enemies.id.count()) ?? 0)
        .getSingle();
    if (count > 0) return;

    await batch((b) {
      for (final def in enemyCatalog) {
        b.insert(enemies, EnemiesCompanion(
          key: Value(def.key),
          name: Value(def.name),
          description: Value(def.description),
          elementType: Value(def.elementType),
          tier: Value(def.tier),
          difficulty: Value(def.difficulty),
          hp: Value(def.hp),
          lpReward: Value(def.lpReward),
          goldReward: Value(def.goldReward),
          lpPenalty: Value(def.lpPenalty),
          weaknesses: Value(jsonEncode(def.weaknesses)),
          resistances: Value(jsonEncode(def.resistances)),
          immunities: Value(jsonEncode(def.immunities)),
          requiredStat: Value(def.requiredStat),
          requiredStatValue: Value(def.requiredStatValue),
          imagePath: Value(def.imagePath),
          emoji: Value(def.emoji),
        ));
      }
    });
  }

  /// Resets the database to its initial state.
  Future<void> resetAllProgress() async {
    await delete(routineExercises).go();
    await delete(bounties).go();
    await delete(companions).go();
    await delete(eggs).go();
    await delete(stepMilestones).go();
    await delete(equippedSlots).go();
    await delete(equipmentExercises).go();
    await delete(equipment).go();
    await delete(inventory).go();
    await delete(rankTrials).go();
    await delete(quests).go();
    await delete(workoutLogs).go();
    await delete(rankHistory).go();
    await delete(stats).go();
    await delete(streaks).go();
    await delete(players).go();
    await _seedInitialData();
    await _seedWeaponCatalog();
    // Exercise DB and Enemy catalog are not reset — they're reference data
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'questfit.db'));
    return NativeDatabase.createInBackground(file);
  });
}
