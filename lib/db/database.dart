import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables.dart';
import '../data/weapon_catalog.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Players, Stats, Quests, WorkoutLogs, Streaks, RankHistory,
  // v2.0 tables
  Equipment, EquipmentExercises, EquippedSlots, Inventory, RankTrials,
  // v2.2 tables
  ExerciseDb, StepMilestones, Eggs, Companions,
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
  int get schemaVersion => 4;

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
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            // v1 → v2 migration: add new columns and tables
            await m.addColumn(players, players.gold);
            await m.addColumn(players, players.awakeningComplete);
            await m.addColumn(quests, quests.goldReward);
            await m.createTable(equipment);
            await m.createTable(equipmentExercises);
            await m.createTable(equippedSlots);
            await m.createTable(inventory);
            await m.createTable(rankTrials);
            // Seed weapon catalog for existing users
            await _seedWeaponCatalog();
          }
          if (from < 3) {
            // v2 → v3 migration: LP/Tier system
            await m.addColumn(players, players.tier);
            await m.addColumn(players, players.division);
            await m.addColumn(players, players.lp);
            await m.addColumn(players, players.totalQuestsCompleted);
            await m.addColumn(players, players.lastActivityAt);
            await m.addColumn(players, players.pendingPromotion);
            await m.addColumn(quests, quests.lpReward);

            // Migrate existing player rank data to new tier/division columns
            await _migrateRankToTier();
          }
          if (from < 4) {
            // v3 → v4 migration: Exercise DB, Step mechanics, Companions
            await m.createTable(exerciseDb);
            await m.createTable(stepMilestones);
            await m.createTable(eggs);
            await m.createTable(companions);
            await m.addColumn(players, players.dailyStepGoal);
            await m.addColumn(players, players.momentumBuffActive);
            // Seed the exercise database for existing users
            await _seedExerciseDatabase();
          }
        },
      );

  /// Migrates legacy rank string (e.g. 'iron_1') into tier + division columns.
  Future<void> _migrateRankToTier() async {
    final playerRows = await select(players).get();
    for (final player in playerRows) {
      // Parse legacy rank key like 'iron_1', 'bronze_3'
      final parts = player.rank.split('_');
      final tierName = parts.isNotEmpty ? parts[0] : 'iron';
      final div = parts.length > 1 ? int.tryParse(parts[1]) ?? 4 : 4;

      await (update(players)..where((t) => t.id.equals(player.id))).write(
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

  /// Resets the database to its initial state.
  Future<void> resetAllProgress() async {
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
    // Exercise DB is not reset — it's reference data
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'questfit.db'));
    return NativeDatabase.createInBackground(file);
  });
}
