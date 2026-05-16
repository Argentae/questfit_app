import 'dart:math';
import '../data/exercises.dart';

/// QuestFit Quest Generation & Validation.
/// Daily quest rotation, XP scaling, and boss raids.
class QuestEngine {
  const QuestEngine._();

  static final _rng = Random();

  static const _classPrimary = {
    'berserker': 'strength',
    'ranger': 'cardio',
    'monk': 'flexibility',
  };

  /// Generate 4 daily quests based on player class and level.
  static List<GeneratedQuest> generateDaily({
    required String classType,
    required int playerLevel,
  }) {
    final primary = _classPrimary[classType] ?? 'strength';
    final allCats = exerciseLibrary.keys.toList();
    final secondary = allCats.where((c) => c != primary).toList();

    final picks = <GeneratedQuest>[];

    // 2 from primary
    picks.addAll(_pickRandom(exerciseLibrary[primary]!, 2)
        .map((ex) => _buildQuest(ex, primary, playerLevel)));

    // 1 from random secondary
    final secCat = secondary[_rng.nextInt(secondary.length)];
    picks.addAll(_pickRandom(exerciseLibrary[secCat]!, 1)
        .map((ex) => _buildQuest(ex, secCat, playerLevel)));

    // 1 wildcard
    final wildCat = allCats[_rng.nextInt(allCats.length)];
    picks.addAll(_pickRandom(exerciseLibrary[wildCat]!, 1)
        .map((ex) => _buildQuest(ex, wildCat, playerLevel)));

    return picks;
  }

  /// Generate a boss raid (appears every 3rd day).
  static GeneratedQuest? getBossRaid(int playerLevel, int dayNumber) {
    if (dayNumber % 3 != 0) return null;

    const raids = [
      _RaidDef('Leg Day Annihilation', 'Complete all leg exercises for 3× bonus XP', 3.0),
      _RaidDef('Upper Body Siege', 'Conquer every push & pull exercise', 3.0),
      _RaidDef('Endurance Gauntlet', 'Survive 45 minutes of continuous cardio', 3.0),
      _RaidDef('Iron Will Challenge', 'Complete 5 exercises without rest', 2.5),
    ];

    final raid = raids[_rng.nextInt(raids.length)];
    final baseXp = (200 * (1 + playerLevel * 0.03)).round();

    return GeneratedQuest(
      title: 'Boss Raid: ${raid.title}',
      category: 'boss',
      emoji: '⚔️',
      description: raid.desc,
      xpReward: (baseXp * raid.multiplier).round(),
    );
  }

  /// Calculate XP for completing a quest (with streak bonus).
  static int completeQuest(int baseXp, double streakMultiplier) {
    return (baseXp * streakMultiplier).round();
  }

  /// Determine which stat a quest category maps to.
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

  static GeneratedQuest _buildQuest(ExerciseDef ex, String category, int playerLevel) {
    final scaledXp = (ex.baseXp * (1 + playerLevel * 0.02)).round();
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
      xpReward: scaledXp,
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
  final int xpReward;

  const GeneratedQuest({
    required this.title,
    required this.category,
    required this.emoji,
    required this.description,
    this.sets,
    this.reps,
    this.duration,
    required this.xpReward,
  });
}

class _RaidDef {
  final String title;
  final String desc;
  final double multiplier;
  const _RaidDef(this.title, this.desc, this.multiplier);
}
