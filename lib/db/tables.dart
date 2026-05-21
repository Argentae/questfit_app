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
  /// v2.2: Daily step goal for Momentum Buff (default 8000)
  IntColumn get dailyStepGoal => integer().withDefault(const Constant(8000))();
  /// v2.2: Whether the Momentum Buff is active today
  BoolColumn get momentumBuffActive => boolean().withDefault(const Constant(false))();
  // ─── v2.4: Rhythm System (Samsung Health) ─────────────────────────
  /// Aether currency earned from active calories burned
  IntColumn get aether => integer().withDefault(const Constant(0))();
  /// Last night's total sleep duration in minutes (from Health Connect)
  IntColumn get lastSleepMinutes => integer().withDefault(const Constant(0))();
  /// Active rest buff multiplier (1.0 = no buff, max 1.20)
  RealColumn get restBuffMultiplier => real().withDefault(const Constant(1.0))();
  /// Timestamp of the last Health Connect sync
  DateTimeColumn get lastHealthSync => dateTime().nullable()();
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
  // v2.5: PR Tracking
  RealColumn get weight => real().nullable()();
  IntColumn get reps => integer().nullable()();
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

// ─── v2.2 NEW TABLES ─────────────────────────────────────────────────

/// Expanded exercise library (800+ exercises from Free Exercise DB).
class ExerciseDb extends Table {
  IntColumn get id => integer().autoIncrement()();
  /// Original ID from Free Exercise DB (e.g. 'Barbell_Full_Squat')
  TextColumn get externalId => text().unique()();
  TextColumn get name => text()();
  /// Force type: 'push', 'pull', 'static', or null
  TextColumn get force => text().nullable()();
  /// Difficulty: 'beginner', 'intermediate', 'expert'
  TextColumn get level => text()();
  /// Mechanic: 'compound', 'isolation', or null
  TextColumn get mechanic => text().nullable()();
  /// Equipment: 'barbell', 'dumbbell', 'body only', etc. or null
  TextColumn get equipment => text().nullable()();
  /// Category: 'strength', 'stretching', 'plyometrics', 'cardio', etc.
  TextColumn get category => text()();
  /// Step-by-step instructions stored as JSON array string
  TextColumn get instructions => text()();
  /// Comma-separated primary muscle names
  TextColumn get primaryMuscles => text()();
  /// Comma-separated secondary muscle names (can be empty)
  TextColumn get secondaryMuscles => text().withDefault(const Constant(''))();
  /// Relative image paths stored as JSON array string
  TextColumn get images => text().withDefault(const Constant('[]'))();
  /// v2.5: Whether the user has favorited this exercise
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
}

/// Step milestone tracking for expedition rewards.
class StepMilestones extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  /// Date string 'YYYY-MM-DD' for daily tracking
  TextColumn get date => text()();
  /// Number of milestones claimed today
  IntColumn get milestonesClaimed => integer().withDefault(const Constant(0))();
  /// Steps at last milestone claim
  IntColumn get stepsAtLastClaim => integer().withDefault(const Constant(0))();
}

/// Companion eggs being incubated by walking.
class Eggs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  /// Companion type that will hatch (matches CompanionDef.type)
  TextColumn get companionType => text()();
  /// Rarity: common, rare, epic, legendary
  TextColumn get rarity => text()();
  /// Total steps required to hatch
  IntColumn get stepsRequired => integer()();
  /// Steps accumulated so far
  IntColumn get stepsAccumulated => integer().withDefault(const Constant(0))();
  DateTimeColumn get foundAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get hatchedAt => dateTime().nullable()();
}

/// Hatched companion collection.
class Companions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get rarity => text()();
  /// Passive buff type (e.g. 'gold_bonus', 'lp_bonus')
  TextColumn get buffType => text()();
  /// Buff value (e.g. 5 for +5%)
  IntColumn get buffValue => integer().withDefault(const Constant(0))();
  /// Whether this companion is active (only 1 active at a time)
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  DateTimeColumn get hatchedAt => dateTime().withDefault(currentDateAndTime)();
}

// ─── v2.3 NEW TABLES ─────────────────────────────────────────────────

/// Master enemy catalog (seeded on migration).
class Enemies extends Table {
  IntColumn get id => integer().autoIncrement()();
  /// Unique slug key (e.g. 'iron_flame_goblin')
  TextColumn get key => text().unique()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  /// Element: 'fire', 'water', 'wind', 'earth', 'shadow'
  TextColumn get elementType => text()();
  /// Player rank tier this enemy is designed for
  TextColumn get tier => text()();
  /// Difficulty: 'easy', 'medium', 'hard'
  TextColumn get difficulty => text()();
  /// Total HP (volume required to defeat)
  IntColumn get hp => integer()();
  /// LP awarded on victory
  IntColumn get lpReward => integer()();
  /// Gold awarded on victory
  IntColumn get goldReward => integer()();
  /// LP lost on defeat
  IntColumn get lpPenalty => integer()();
  /// JSON array of exercise categories that deal 2× damage
  TextColumn get weaknesses => text()();
  /// JSON array of exercise categories that deal 0.5× damage
  TextColumn get resistances => text()();
  /// JSON array of exercise categories that deal 0× damage
  TextColumn get immunities => text().withDefault(const Constant('[]'))();
  /// Stat prerequisite key (e.g. 'str') or null
  TextColumn get requiredStat => text().nullable()();
  /// Minimum stat value required, or null
  IntColumn get requiredStatValue => integer().nullable()();
  /// Asset path for enemy art
  TextColumn get imagePath => text()();
  /// Display emoji
  TextColumn get emoji => text().withDefault(const Constant('👹'))();
}

/// Daily bounty state — 1 active per day per player.
class Bounties extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  /// Date string 'YYYY-MM-DD'
  TextColumn get date => text()();
  /// The locked-in enemy
  IntColumn get enemyId => integer().nullable().references(Enemies, #id)();
  /// Status: 'drafting', 'preparing', 'combat', 'victory', 'defeat'
  TextColumn get status => text().withDefault(const Constant('drafting'))();
  /// Enemy's remaining HP (starts at enemy.hp)
  IntColumn get currentHp => integer().withDefault(const Constant(0))();
  /// JSON array of 3 enemy IDs offered in draft
  TextColumn get draftedEnemyIds => text().withDefault(const Constant('[]'))();
  DateTimeColumn get lockedAt => dateTime().nullable()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
}

/// Player's planned/completed workout routine for a bounty.
class RoutineExercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bountyId => integer().references(Bounties, #id)();
  /// Reference to the Grimoire exercise
  IntColumn get exerciseDbId => integer().references(ExerciseDb, #id)();
  IntColumn get sets => integer().withDefault(const Constant(1))();
  IntColumn get reps => integer().nullable()();
  IntColumn get duration => integer().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  /// Calculated damage from this exercise
  IntColumn get damageDealt => integer().withDefault(const Constant(0))();
}

// ─── v2.5 NEW TABLES ─────────────────────────────────────────────────

/// User-created workout routines (Decks).
class Routines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// The exercises saved inside a Routine.
class RoutineBuilderExercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get routineId => integer().references(Routines, #id)();
  IntColumn get exerciseDbId => integer().references(ExerciseDb, #id)();
  IntColumn get sets => integer().withDefault(const Constant(1))();
  IntColumn get reps => integer().nullable()();
  IntColumn get duration => integer().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
