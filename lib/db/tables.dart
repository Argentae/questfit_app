import 'package:drift/drift.dart';

/// Player profile table.
/// v3.0: LP/Tier system replaces XP/Level system.
class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withDefault(const Constant('Adventurer'))();
  // ─── Legacy columns (kept for migration safety) ─────────────────
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  IntColumn get totalXp => integer().withDefault(const Constant(0))();
  // ─── v3.0: LP/Tier system ───────────────────────────────────────
  /// Current tier name (lowercase): 'iron', 'bronze', 'silver', etc.
  TextColumn get tier => text().withDefault(const Constant('iron'))();
  /// Current division within tier: 4 (lowest) to 1 (highest).
  IntColumn get division => integer().withDefault(const Constant(4))();
  /// Current LP: 0–100.
  IntColumn get lp => integer().withDefault(const Constant(0))();
  /// Total quests completed (lifetime vanity stat).
  IntColumn get totalQuestsCompleted => integer().withDefault(const Constant(0))();
  /// Last time the player completed a quest (for 48h decay).
  DateTimeColumn get lastActivityAt => dateTime().nullable()();
  /// Whether a promotion is pending (LP hit 100, will promote on next launch).
  BoolColumn get pendingPromotion => boolean().withDefault(const Constant(false))();
  // ─── Existing columns ───────────────────────────────────────────
  TextColumn get rank => text().withDefault(const Constant('iron_1'))();
  TextColumn get classType => text().withDefault(const Constant('berserker'))();
  /// v2.0: Gold economy
  IntColumn get gold => integer().withDefault(const Constant(0))();
  /// v2.0: Awakening flag — true once the player clears the Proving Grounds
  BoolColumn get awakeningComplete => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Player stats derived from workout categories.
/// v3.0: Display names changed to Strength / Cardio / Flexibility
/// but column names remain str / end / agi for backward compatibility.
class Stats extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  /// Strength (STR) — earned from strength quests.
  IntColumn get str => integer().withDefault(const Constant(0))();
  /// Cardio (CDO) — earned from cardio quests (was "endurance").
  IntColumn get end => integer().withDefault(const Constant(0))();
  /// Flexibility (FLX) — earned from flexibility quests (was "agility").
  IntColumn get agi => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Daily and custom quests.
/// v3.0: Added lpReward column for LP system.
class Quests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get category => text()();
  TextColumn get description => text()();
  IntColumn get sets => integer().nullable()();
  IntColumn get reps => integer().nullable()();
  IntColumn get duration => integer().nullable()();
  /// Legacy XP reward (kept for migration safety).
  IntColumn get xpReward => integer()();
  /// v3.0: LP reward for this quest (base, before bonuses).
  IntColumn get lpReward => integer().withDefault(const Constant(8))();
  /// v2.0: Gold reward for quest completion.
  IntColumn get goldReward => integer().withDefault(const Constant(0))();
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

// ─── v2.0 NEW TABLES ─────────────────────────────────────────────────

/// Master equipment catalog (weapons).
class Equipment extends Table {
  IntColumn get id => integer().autoIncrement()();
  /// Unique slug key (e.g. 'dusted_longsword')
  TextColumn get key => text().unique()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  /// Rarity: common, rare, epic, legendary
  TextColumn get rarity => text().withDefault(const Constant('common'))();
  /// Path to asset image (e.g. 'assets/images/dusted_longsword.webp')
  TextColumn get imagePath => text()();
  /// Primary exercise category this weapon maps to
  TextColumn get category => text()();
  /// Whether the player owns this weapon
  BoolColumn get isOwned => boolean().withDefault(const Constant(false))();
  /// Price in gold (0 = starter/free)
  IntColumn get price => integer().withDefault(const Constant(0))();
}

/// Links equipment to specific exercises.
class EquipmentExercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get equipmentId => integer().references(Equipment, #id)();
  TextColumn get exerciseTitle => text()();
  TextColumn get exerciseCategory => text()();
  IntColumn get sets => integer().nullable()();
  IntColumn get reps => integer().nullable()();
  IntColumn get duration => integer().nullable()();
  IntColumn get baseXp => integer()();
  TextColumn get emoji => text().withDefault(const Constant('⚔️'))();
}

/// Player's active loadout — max 3 equipped weapon slots.
class EquippedSlots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  /// Slot index: 1, 2, or 3
  IntColumn get slotIndex => integer()();
  IntColumn get equipmentId => integer().references(Equipment, #id)();
}

/// Player consumable inventory (streak insurance, quest rerolls, etc.).
class Inventory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  /// Item key: 'streak_insurance', 'quest_reroll'
  TextColumn get itemKey => text()();
  IntColumn get quantity => integer().withDefault(const Constant(0))();
}

/// Rank promotion trial tracking.
/// v3.0: Kept for legacy data but no longer used for new promotions.
class RankTrials extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  /// The rank the player is trying to promote into (e.g. 'bronze_1')
  TextColumn get targetRank => text()();
  /// Trial type: 'consistency' or 'gatekeeper'
  TextColumn get trialType => text()();
  DateTimeColumn get startedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();
  /// Status: 'active', 'passed', 'failed'
  TextColumn get status => text().withDefault(const Constant('active'))();
  // Consistency trial fields
  IntColumn get streakDaysCompleted => integer().withDefault(const Constant(0))();
  IntColumn get requiredStreakDays => integer().withDefault(const Constant(5))();
  // Gatekeeper trial fields
  IntColumn get calorieGoal => integer().nullable()();
  IntColumn get stepGoal => integer().nullable()();
  IntColumn get caloriesAchieved => integer().withDefault(const Constant(0))();
  IntColumn get stepsAchieved => integer().withDefault(const Constant(0))();
}
