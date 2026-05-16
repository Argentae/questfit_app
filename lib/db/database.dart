import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Players, Stats, Quests, WorkoutLogs, Streaks, RankHistory])
class QuestFitDatabase extends _$QuestFitDatabase {
  QuestFitDatabase._() : super(_openConnection());

  static QuestFitDatabase? _instance;

  /// Singleton accessor.
  static QuestFitDatabase get instance {
    _instance ??= QuestFitDatabase._();
    return _instance!;
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // Seed default player on first run
          await _seedInitialData();
        },
      );

  /// Seeds a Level 1 Iron I player on first launch.
  Future<void> _seedInitialData() async {
    final now = DateTime.now();

    // Insert default player
    final playerId = await into(players).insert(PlayersCompanion(
      name: const Value('Adventurer'),
      level: const Value(1),
      xp: const Value(0),
      totalXp: const Value(0),
      rank: const Value('iron_1'),
      classType: const Value('berserker'),
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
      rank: const Value('iron_1'),
      achievedAt: Value(now),
    ));

    // Seed 4 initial daily quests
    final seedQuests = [
      QuestsCompanion(
        title: const Value('Barbell Squats'),
        category: const Value('strength'),
        description: const Value('3 sets × 10 reps'),
        sets: const Value(3),
        reps: const Value(10),
        xpReward: const Value(120),
        createdAt: Value(now),
      ),
      QuestsCompanion(
        title: const Value('Treadmill Sprint'),
        category: const Value('cardio'),
        description: const Value('15 min HIIT'),
        duration: const Value(15),
        xpReward: const Value(90),
        createdAt: Value(now),
      ),
      QuestsCompanion(
        title: const Value('Hip Mobility Flow'),
        category: const Value('flexibility'),
        description: const Value('10 min stretching'),
        duration: const Value(10),
        xpReward: const Value(50),
        createdAt: Value(now),
      ),
      QuestsCompanion(
        title: const Value('Plank Challenge'),
        category: const Value('core'),
        description: const Value('3 × 60 sec holds'),
        sets: const Value(3),
        duration: const Value(1),
        xpReward: const Value(75),
        createdAt: Value(now),
      ),
    ];

    for (final q in seedQuests) {
      await into(quests).insert(q);
    }
  }

  /// Resets the database to its initial state.
  Future<void> resetAllProgress() async {
    await delete(quests).go();
    await delete(workoutLogs).go();
    await delete(rankHistory).go();
    await delete(stats).go();
    await delete(streaks).go();
    await delete(players).go();
    await _seedInitialData();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'questfit.db'));
    return NativeDatabase.createInBackground(file);
  });
}
