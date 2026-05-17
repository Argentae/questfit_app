import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables.dart';
import '../data/weapon_catalog.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Players, Stats, Quests, WorkoutLogs, Streaks, RankHistory,
  // v2.0 tables
  Equipment, EquipmentExercises, EquippedSlots, Inventory, RankTrials,
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
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // Seed default player on first run
          await _seedInitialData();
          // Seed weapon catalog
          await _seedWeaponCatalog();
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

  /// Resets the database to its initial state.
  Future<void> resetAllProgress() async {
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
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'questfit.db'));
    return NativeDatabase.createInBackground(file);
  });
}
