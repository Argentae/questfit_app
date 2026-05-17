import 'dart:math';
import '../data/exercises.dart';
import '../data/weapon_catalog.dart';
import 'gold_engine.dart';
import 'lp_engine.dart';

/// QuestFit Quest Generation & Validation.
/// Daily quest rotation, LP scaling, boss raids, and equipment-driven routines.
///
/// v3.0: Quests award LP instead of XP. LP rewards are smaller (5–15 base).
class QuestEngine {
  const QuestEngine._();

  static final _rng = Random();

  static const _classPrimary = {
    'berserker': 'strength',
    'ranger': 'cardio',
    'monk': 'flexibility',
  };

  /// v2.0: Generate daily quests from the player's equipped weapon loadout.
  ///
  /// Each equipped weapon contributes its linked exercises.
  /// The engine picks from the combined exercise pool.
  /// If fewer than 3 weapons are equipped, supplements from the general pool.
  static List<GeneratedQuest> generateFromLoadout({
    required List<WeaponDef> equippedWeapons,
    required String classType,
    required int tierIndex,
  }) {
    final picks = <GeneratedQuest>[];

    if (equippedWeapons.isEmpty) {
      // Fallback: use legacy generation
      return generateDaily(classType: classType, tierIndex: tierIndex);
    }

    // Gather all exercises from equipped weapons
    final weaponExercises = <_WeaponExerciseEntry>[];
    for (final weapon in equippedWeapons) {
      for (final ex in weapon.exercises) {
        weaponExercises.add(_WeaponExerciseEntry(weapon: weapon, exercise: ex));
      }
    }

    // Shuffle and pick up to 4 quests from the weapon pool
    weaponExercises.shuffle(_rng);
    final seen = <String>{};

    for (final entry in weaponExercises) {
      if (picks.length >= 4) break;
      if (seen.contains(entry.exercise.title)) continue;
      seen.add(entry.exercise.title);

      picks.add(_buildFromWeaponExercise(
        entry.exercise,
        tierIndex,
        entry.weapon.name,
        entry.weapon.rarity,
      ));
    }

    // If we still need more quests, supplement from the general pool
    if (picks.length < 4) {
      final primary = _classPrimary[classType] ?? 'strength';
      final pool = exerciseLibrary[primary] ?? [];
      final supplement = _pickRandom(
        pool.where((e) => !seen.contains(e.title)).toList(),
        4 - picks.length,
      );
      for (final ex in supplement) {
        picks.add(_buildQuest(ex, primary, tierIndex));
      }
    }

    return picks;
  }

  /// Legacy: Generate 4 daily quests based on player class and tier.
  static List<GeneratedQuest> generateDaily({
    required String classType,
    required int tierIndex,
  }) {
    final primary = _classPrimary[classType] ?? 'strength';
    final allCats = exerciseLibrary.keys.toList();
    final secondary = allCats.where((c) => c != primary).toList();

    final picks = <GeneratedQuest>[];

    // 2 from primary
    picks.addAll(_pickRandom(exerciseLibrary[primary]!, 2)
        .map((ex) => _buildQuest(ex, primary, tierIndex)));

    // 1 from random secondary
    final secCat = secondary[_rng.nextInt(secondary.length)];
    picks.addAll(_pickRandom(exerciseLibrary[secCat]!, 1)
        .map((ex) => _buildQuest(ex, secCat, tierIndex)));

    // 1 wildcard
    final wildCat = allCats[_rng.nextInt(allCats.length)];
    picks.addAll(_pickRandom(exerciseLibrary[wildCat]!, 1)
        .map((ex) => _buildQuest(ex, wildCat, tierIndex)));

    return picks;
  }

  /// Generate a boss raid (appears every 3rd day).
  static GeneratedQuest? getBossRaid(int tierIndex, int dayNumber) {
    if (dayNumber % 3 != 0) return null;

    const raids = [
      _RaidDef('Leg Day Annihilation', 'Complete all leg exercises for 3× bonus LP', 3.0),
      _RaidDef('Upper Body Siege', 'Conquer every push & pull exercise', 3.0),
      _RaidDef('Endurance Gauntlet', 'Survive 45 minutes of continuous cardio', 3.0),
      _RaidDef('Iron Will Challenge', 'Complete 5 exercises without rest', 2.5),
    ];

    final raid = raids[_rng.nextInt(raids.length)];
    // Boss raids give bigger LP rewards
    final baseLp = (LpEngine.baseQuestLp * raid.multiplier).round();
    final goldChest = GoldEngine.bossRaidGold(tierIndex * 10);

    return GeneratedQuest(
      title: 'Boss Raid: ${raid.title}',
      category: 'boss',
      emoji: '⚔️',
      description: raid.desc,
      xpReward: 0,
      lpReward: baseLp,
      goldReward: goldChest,
    );
  }

  /// Determine which stat a quest category maps to.
  /// v3.0: str = Strength, end = Cardio, agi = Flexibility
  static String categoryToStat(String category) {
    switch (category) {
      case 'strength':
        return 'str';
      case 'cardio':
        return 'end';
      case 'flexibility':
      case 'core':
        return 'agi';
      default:
        return 'str';
    }
  }

  /// Get the stat display name for a category.
  static String statDisplayName(String statKey) {
    switch (statKey) {
      case 'str':
        return 'Strength';
      case 'end':
        return 'Cardio';
      case 'agi':
        return 'Flexibility';
      default:
        return 'Strength';
    }
  }

  /// Get the stat abbreviation.
  static String statAbbrev(String statKey) {
    switch (statKey) {
      case 'str':
        return 'STR';
      case 'end':
        return 'CDO';
      case 'agi':
        return 'FLX';
      default:
        return 'STR';
    }
  }

  /// Calculate LP reward based on quest difficulty and tier.
  /// Higher tiers get slightly more base LP to keep progression feeling meaningful.
  static int _questLpReward(int baseXp, int tierIndex) {
    // Convert old XP-style values to LP scale (5–15 range)
    // baseXp is typically 20-60, so we scale down
    final baseLp = (baseXp / 5).round().clamp(5, 15);
    // Slight tier bonus: +1 LP per 3 tier levels
    return baseLp + (tierIndex ~/ 3);
  }

  static GeneratedQuest _buildFromWeaponExercise(
    WeaponExerciseDef ex,
    int tierIndex,
    String weaponName,
    String weaponRarity,
  ) {
    final lpReward = _questLpReward(ex.baseXp, tierIndex);
    // v2.1: Gold scales with difficulty + equipped weapon rarity
    final goldReward = GoldEngine.questGold(
      baseXp: ex.baseXp,
      fromWeapon: true,
      weaponRarity: weaponRarity,
    );
    String desc;
    if (ex.sets != null && ex.reps != null) {
      desc = '${ex.sets} sets × ${ex.reps} reps';
    } else if (ex.sets != null && ex.duration != null) {
      desc = '${ex.sets} × ${ex.duration} min holds';
    } else if (ex.duration != null) {
      desc = '${ex.duration} min';
    } else {
      desc = '';
    }

    return GeneratedQuest(
      title: ex.title,
      category: ex.category,
      emoji: ex.emoji,
      description: desc,
      sets: ex.sets,
      reps: ex.reps,
      duration: ex.duration,
      xpReward: 0,
      lpReward: lpReward,
      goldReward: goldReward,
      sourceWeapon: weaponName,
    );
  }

  static GeneratedQuest _buildQuest(ExerciseDef ex, String category, int tierIndex) {
    final lpReward = _questLpReward(ex.baseXp, tierIndex);
    // v2.1: Gold scales with difficulty (no weapon bonus for general pool quests)
    final goldReward = GoldEngine.questGold(baseXp: ex.baseXp);
    String desc;
    if (ex.sets != null && ex.reps != null) {
      desc = '${ex.sets} sets × ${ex.reps} reps';
    } else if (ex.sets != null && ex.duration != null) {
      desc = '${ex.sets} × ${ex.duration} min holds';
    } else if (ex.duration != null) {
      desc = '${ex.duration} min';
    } else {
      desc = '';
    }

    return GeneratedQuest(
      title: ex.title,
      category: category,
      emoji: ex.emoji,
      description: desc,
      sets: ex.sets,
      reps: ex.reps,
      duration: ex.duration,
      xpReward: 0,
      lpReward: lpReward,
      goldReward: goldReward,
    );
  }

  static List<T> _pickRandom<T>(List<T> list, int n) {
    final pool = List<T>.from(list);
    final result = <T>[];
    for (var i = 0; i < n && pool.isNotEmpty; i++) {
      final idx = _rng.nextInt(pool.length);
      result.add(pool.removeAt(idx));
    }
    return result;
  }
}

class GeneratedQuest {
  final String title;
  final String category;
  final String emoji;
  final String description;
  final int? sets;
  final int? reps;
  final int? duration;
  /// Legacy XP reward (kept as 0 for backward compat).
  final int xpReward;
  /// v3.0: LP reward for this quest (base, before mastery/streak bonuses).
  final int lpReward;
  /// v2.0: Gold reward for this quest.
  final int goldReward;
  /// v2.0: Which weapon generated this quest (null = general pool).
  final String? sourceWeapon;

  const GeneratedQuest({
    required this.title,
    required this.category,
    required this.emoji,
    required this.description,
    this.sets,
    this.reps,
    this.duration,
    this.xpReward = 0,
    this.lpReward = 8,
    this.goldReward = 0,
    this.sourceWeapon,
  });
}

class _RaidDef {
  final String title;
  final String desc;
  final double multiplier;
  const _RaidDef(this.title, this.desc, this.multiplier);
}

class _WeaponExerciseEntry {
  final WeaponDef weapon;
  final WeaponExerciseDef exercise;
  const _WeaponExerciseEntry({required this.weapon, required this.exercise});
}
