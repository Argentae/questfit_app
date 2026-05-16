import 'package:drift/drift.dart';

/// Player profile table.
class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withDefault(const Constant('Adventurer'))();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  IntColumn get totalXp => integer().withDefault(const Constant(0))();
  TextColumn get rank => text().withDefault(const Constant('iron_1'))();
  TextColumn get classType => text().withDefault(const Constant('berserker'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Player stats derived from workout categories.
class Stats extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  IntColumn get str => integer().withDefault(const Constant(0))();
  IntColumn get end => integer().withDefault(const Constant(0))();
  IntColumn get agi => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Daily and custom quests.
class Quests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get category => text()();
  TextColumn get description => text()();
  IntColumn get sets => integer().nullable()();
  IntColumn get reps => integer().nullable()();
  IntColumn get duration => integer().nullable()();
  IntColumn get xpReward => integer()();
  BoolColumn get isDaily => boolean().withDefault(const Constant(true))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Workout completion logs (manual + Health Connect).
class WorkoutLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get questId => integer().nullable().references(Quests, #id)();
  IntColumn get playerId => integer().references(Players, #id)();
  DateTimeColumn get completedAt => dateTime()();
  IntColumn get xpEarned => integer()();
  TextColumn get source => text().withDefault(const Constant('manual'))();
  TextColumn get healthConnectId => text().nullable()();
}

/// Streak tracking.
class Streaks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  TextColumn get lastActiveDate => text().nullable()();
}

/// Rank progression history.
class RankHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  TextColumn get rank => text()();
  DateTimeColumn get achievedAt => dateTime().withDefault(currentDateAndTime)();
}
