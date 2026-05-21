// QuestFit v2.3 — Combat Engine
// Handles damage calculation, elemental multipliers, and bounty resolution.

/// Combat damage calculation and bounty resolution engine.
class CombatEngine {
  const CombatEngine._();

  // ─── Difficulty Tier Multipliers ────────────────────────────────────

  /// Maps exercise difficulty level to a damage multiplier.
  static double getDifficultyMultiplier(String exerciseLevel) {
    switch (exerciseLevel.toLowerCase()) {
      case 'expert':
        return 2.0;
      case 'intermediate':
        return 1.5;
      case 'beginner':
      default:
        return 1.0;
    }
  }

  // ─── Elemental Multipliers ─────────────────────────────────────────

  /// Calculate elemental multiplier based on exercise category vs enemy profile.
  ///
  /// - Weakness: 2.0× (super effective)
  /// - Neutral: 1.0×
  /// - Resistance: 0.5× (not very effective)
  /// - Immune: 0.0× (no effect)
  static double getElementalMultiplier({
    required String exerciseCategory,
    required List<String> weaknesses,
    required List<String> resistances,
    required List<String> immunities,
  }) {
    final cat = exerciseCategory.toLowerCase();

    if (immunities.contains(cat)) return 0.0;
    if (weaknesses.contains(cat)) return 2.0;
    if (resistances.contains(cat)) return 0.5;
    return 1.0;
  }

  // ─── Damage Calculation ────────────────────────────────────────────

  /// Calculate the volume of a single exercise.
  /// For resistance training: Sets × Reps
  /// For cardio/isometrics: Duration (in minutes)
  static int calculateVolume({
    required int sets,
    int? reps,
    int? duration,
  }) {
    if (reps != null) {
      return sets * reps;
    } else if (duration != null) {
      return duration;
    }
    return sets; // Fallback: just use sets
  }

  /// Calculate damage dealt by a single completed exercise.
  ///
  /// Formula: Volume × DifficultyTier × ElementalMultiplier
  static ExerciseDamage calculateExerciseDamage({
    required int sets,
    int? reps,
    int? duration,
    required String exerciseLevel,
    required String exerciseCategory,
    required List<String> weaknesses,
    required List<String> resistances,
    required List<String> immunities,
  }) {
    final volume = calculateVolume(sets: sets, reps: reps, duration: duration);
    final diffMult = getDifficultyMultiplier(exerciseLevel);
    final elemMult = getElementalMultiplier(
      exerciseCategory: exerciseCategory,
      weaknesses: weaknesses,
      resistances: resistances,
      immunities: immunities,
    );

    final rawDamage = (volume * diffMult * elemMult).round();

    String effectiveness;
    if (elemMult >= 2.0) {
      effectiveness = 'super_effective';
    } else if (elemMult <= 0.0) {
      effectiveness = 'immune';
    } else if (elemMult < 1.0) {
      effectiveness = 'not_effective';
    } else {
      effectiveness = 'neutral';
    }

    return ExerciseDamage(
      volume: volume,
      difficultyMultiplier: diffMult,
      elementalMultiplier: elemMult,
      totalDamage: rawDamage,
      effectiveness: effectiveness,
    );
  }

  /// Preview total expected damage for a planned routine.
  static RoutineDamagePreview previewRoutineDamage({
    required List<RoutineExerciseInput> exercises,
    required List<String> weaknesses,
    required List<String> resistances,
    required List<String> immunities,
    required int enemyHp,
  }) {
    int totalDamage = 0;
    final breakdown = <ExerciseDamage>[];

    for (final ex in exercises) {
      final dmg = calculateExerciseDamage(
        sets: ex.sets,
        reps: ex.reps,
        duration: ex.duration,
        exerciseLevel: ex.level,
        exerciseCategory: ex.category,
        weaknesses: weaknesses,
        resistances: resistances,
        immunities: immunities,
      );
      totalDamage += dmg.totalDamage;
      breakdown.add(dmg);
    }

    return RoutineDamagePreview(
      totalDamage: totalDamage,
      enemyHp: enemyHp,
      canDefeat: totalDamage >= enemyHp,
      overkill: totalDamage > enemyHp ? totalDamage - enemyHp : 0,
      breakdown: breakdown,
    );
  }

  // ─── Bounty Resolution ─────────────────────────────────────────────

  /// Resolve a bounty at midnight (or app launch).
  ///
  /// If enemy HP <= 0: Victory → award LP + Gold.
  /// If enemy HP > 0: Defeat → apply LP penalty + break streak.
  static BountyResolution resolveBounty({
    required int enemyMaxHp,
    required int enemyCurrentHp,
    required int lpReward,
    required int goldReward,
    required int lpPenalty,
    required String difficulty,
  }) {
    final isVictory = enemyCurrentHp <= 0;

    if (isVictory) {
      // Bonus for overkill
      final overkillPercent = ((enemyMaxHp - enemyCurrentHp) / enemyMaxHp * 100).round();
      int bonusGold = 0;
      if (overkillPercent > 150) bonusGold = (goldReward * 0.25).round();

      return BountyResolution(
        isVictory: true,
        lpChange: lpReward,
        goldChange: goldReward + bonusGold,
        streakBroken: false,
        message: _victoryMessage(difficulty),
        bonusGold: bonusGold,
        totalDamageDealt: enemyMaxHp + overkillPercent.round(), // Approximate for now or pass actual
      );
    } else {
      // Defeat: LP penalty scales with how much HP remained
      final hpRemainingPercent = enemyCurrentHp / enemyMaxHp;
      // Full penalty if > 50% HP remaining, half if < 50%
      final adjustedPenalty = hpRemainingPercent > 0.5
          ? lpPenalty
          : (lpPenalty * 0.6).round();

      return BountyResolution(
        isVictory: false,
        lpChange: -adjustedPenalty,
        goldChange: 0,
        streakBroken: true,
        message: _defeatMessage(difficulty),
        bonusGold: 0,
        totalDamageDealt: enemyMaxHp - enemyCurrentHp,
      );
    }
  }

  static String _victoryMessage(String difficulty) {
    switch (difficulty) {
      case 'hard':
        return 'LEGENDARY VICTORY! You conquered the impossible!';
      case 'medium':
        return 'GLORIOUS VICTORY! A worthy challenge overcome!';
      case 'easy':
      default:
        return 'VICTORY! The beast has fallen!';
    }
  }

  static String _defeatMessage(String difficulty) {
    switch (difficulty) {
      case 'hard':
        return 'Defeated... but the courage to face such a foe earns respect.';
      case 'medium':
        return 'The enemy survives... your weakness has been exposed.';
      case 'easy':
      default:
        return 'Defeated by a mere creature... train harder, warrior.';
    }
  }
}

// ─── Data Classes ──────────────────────────────────────────────────────

class ExerciseDamage {
  final int volume;
  final double difficultyMultiplier;
  final double elementalMultiplier;
  final int totalDamage;
  /// 'super_effective', 'neutral', 'not_effective', 'immune'
  final String effectiveness;

  const ExerciseDamage({
    required this.volume,
    required this.difficultyMultiplier,
    required this.elementalMultiplier,
    required this.totalDamage,
    required this.effectiveness,
  });
}

class RoutineDamagePreview {
  final int totalDamage;
  final int enemyHp;
  final bool canDefeat;
  final int overkill;
  final List<ExerciseDamage> breakdown;

  const RoutineDamagePreview({
    required this.totalDamage,
    required this.enemyHp,
    required this.canDefeat,
    required this.overkill,
    required this.breakdown,
  });
}

class RoutineExerciseInput {
  final int sets;
  final int? reps;
  final int? duration;
  final String level;
  final String category;

  const RoutineExerciseInput({
    required this.sets,
    this.reps,
    this.duration,
    required this.level,
    required this.category,
  });
}

class BountyResolution {
  final bool isVictory;
  final int lpChange;
  final int goldChange;
  final bool streakBroken;
  final String message;
  final int bonusGold;
  final int totalDamageDealt;

  const BountyResolution({
    required this.isVictory,
    required this.lpChange,
    required this.goldChange,
    required this.streakBroken,
    required this.message,
    required this.bonusGold,
    required this.totalDamageDealt,
  });
}
