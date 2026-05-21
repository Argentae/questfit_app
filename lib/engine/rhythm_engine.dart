/// QuestFit Rhythm Engine — v2.4
///
/// Translates Samsung Health biometric data into game mechanics:
/// - Sleep quality → "Well-Rested" buff (LP/damage multiplier)
/// - Active calories → "Aether" currency
/// - Heart rate intensity → workout bonus multiplier
/// - Consistency → routine detection bonus
class RhythmEngine {
  const RhythmEngine._();

  // ─── Sleep → Rest Buff ──────────────────────────────────────────────

  /// Minimum sleep minutes to qualify for any buff.
  static const int minSleepMinutes = 300; // 5 hours

  /// Optimal sleep minutes for maximum buff.
  static const int optimalSleepMinutes = 420; // 7 hours

  /// Maximum sleep minutes considered (beyond this, no extra benefit).
  static const int maxSleepMinutes = 540; // 9 hours

  /// Calculate the "Well-Rested" buff from last night's sleep.
  ///
  /// Returns a [RestBuff] with:
  /// - [multiplier]: 1.0 (no buff) to 1.20 (max buff)
  /// - [tier]: 'none', 'light', 'rested', 'well_rested'
  /// - [description]: Human-readable buff description
  static RestBuff calculateRestBuff({
    required int sleepMinutes,
    int deepSleepMinutes = 0,
    int remSleepMinutes = 0,
  }) {
    if (sleepMinutes < minSleepMinutes) {
      return const RestBuff(
        multiplier: 1.0,
        tier: 'none',
        label: 'Sleep Deprived',
        description: 'Get 5+ hours of sleep for a buff',
        emoji: '😴',
      );
    }

    // Base multiplier from total sleep duration
    // 5h = 1.05, 7h = 1.10, 8h = 1.15
    final durationFactor = ((sleepMinutes - minSleepMinutes) /
            (optimalSleepMinutes - minSleepMinutes))
        .clamp(0.0, 1.0);
    var multiplier = 1.0 + (durationFactor * 0.10);

    // Quality bonus from deep + REM sleep
    // Good quality (60+ min deep, 90+ min REM) adds up to +0.05
    final qualityMinutes = deepSleepMinutes + remSleepMinutes;
    if (qualityMinutes > 120) {
      multiplier += 0.05;
    } else if (qualityMinutes > 60) {
      multiplier += 0.03;
    }

    multiplier = multiplier.clamp(1.0, 1.20);

    // Determine tier
    String tier;
    String label;
    String emoji;
    if (multiplier >= 1.15) {
      tier = 'well_rested';
      label = 'Well-Rested';
      emoji = '✨';
    } else if (multiplier >= 1.08) {
      tier = 'rested';
      label = 'Rested';
      emoji = '😊';
    } else {
      tier = 'light';
      label = 'Light Rest';
      emoji = '🌙';
    }

    final bonusPct = ((multiplier - 1.0) * 100).round();

    return RestBuff(
      multiplier: multiplier,
      tier: tier,
      label: label,
      description: '+$bonusPct% LP & Damage today',
      emoji: emoji,
    );
  }

  // ─── Calories → Aether Currency ─────────────────────────────────────

  /// Minimum active calories to generate any Aether.
  static const int minCaloriesForAether = 100;

  /// Calories per 1 Aether point.
  static const int caloriesPerAether = 50;

  /// Maximum Aether earnable per day.
  static const int maxDailyAether = 30;

  /// Convert active calories burned today into Aether currency.
  ///
  /// Returns [AetherResult] with earned amount and breakdown.
  static AetherResult calculateAether({
    required int activeCalories,
  }) {
    if (activeCalories < minCaloriesForAether) {
      return AetherResult(
        earned: 0,
        totalCalories: activeCalories,
        description: 'Burn ${minCaloriesForAether - activeCalories} more cal for Aether',
      );
    }

    final raw = activeCalories ~/ caloriesPerAether;
    final earned = raw.clamp(0, maxDailyAether);

    return AetherResult(
      earned: earned,
      totalCalories: activeCalories,
      description: '$earned Aether from $activeCalories cal',
    );
  }

  // ─── Heart Rate → Intensity Multiplier ──────────────────────────────

  /// Analyze workout heart rate data to determine intensity bonus.
  ///
  /// [avgHeartRate] — Average heart rate during the workout.
  /// [peakHeartRate] — Peak heart rate recorded.
  /// [age] — Player's age (for zone calculation). Default 30.
  ///
  /// Returns [IntensityBonus] with multiplier and zone info.
  static IntensityBonus analyzeIntensity({
    required double avgHeartRate,
    double? peakHeartRate,
    int age = 30,
  }) {
    // Max heart rate estimate (Tanaka formula)
    final maxHr = 208 - (0.7 * age);

    // Determine zone from average HR
    final avgPct = avgHeartRate / maxHr;

    // Zone thresholds (% of max HR)
    // Zone 1: <60% (Recovery)
    // Zone 2: 60-70% (Fat burn)
    // Zone 3: 70-80% (Aerobic)
    // Zone 4: 80-90% (Threshold)
    // Zone 5: 90%+ (Max effort)

    int zone;
    String zoneName;
    double multiplier;

    if (avgPct >= 0.90) {
      zone = 5;
      zoneName = 'MAX EFFORT';
      multiplier = 1.50;
    } else if (avgPct >= 0.80) {
      zone = 4;
      zoneName = 'THRESHOLD';
      multiplier = 1.30;
    } else if (avgPct >= 0.70) {
      zone = 3;
      zoneName = 'AEROBIC';
      multiplier = 1.15;
    } else if (avgPct >= 0.60) {
      zone = 2;
      zoneName = 'FAT BURN';
      multiplier = 1.05;
    } else {
      zone = 1;
      zoneName = 'RECOVERY';
      multiplier = 1.0;
    }

    return IntensityBonus(
      zone: zone,
      zoneName: zoneName,
      multiplier: multiplier,
      avgHeartRate: avgHeartRate,
      peakHeartRate: peakHeartRate ?? avgHeartRate,
      maxHeartRate: maxHr,
    );
  }

  // ─── Rhythm Consistency ─────────────────────────────────────────────

  /// Check if the player maintains a consistent workout time.
  ///
  /// [recentWorkoutHours] — List of hour-of-day for recent workouts (e.g. [7, 7, 8, 7]).
  /// If the standard deviation is low (< 2 hours), award a consistency bonus.
  static ConsistencyBonus checkConsistency({
    required List<int> recentWorkoutHours,
  }) {
    if (recentWorkoutHours.length < 3) {
      return const ConsistencyBonus(
        isConsistent: false,
        multiplier: 1.0,
        description: 'Work out 3+ days at similar times to unlock',
      );
    }

    final mean = recentWorkoutHours.reduce((a, b) => a + b) /
        recentWorkoutHours.length;
    final variance = recentWorkoutHours
            .map((h) => (h - mean) * (h - mean))
            .reduce((a, b) => a + b) /
        recentWorkoutHours.length;
    final stdDev = variance > 0 ? variance * 0.5 : 0.0; // Approximate sqrt

    if (stdDev < 2.0) {
      return ConsistencyBonus(
        isConsistent: true,
        multiplier: 1.10,
        description: '+10% Gold — Consistent rhythm detected!',
        preferredHour: mean.round(),
      );
    }

    return const ConsistencyBonus(
      isConsistent: false,
      multiplier: 1.0,
      description: 'Keep a regular workout schedule for bonus Gold',
    );
  }
}

// ─── Data Classes ──────────────────────────────────────────────────────

class RestBuff {
  final double multiplier;
  final String tier; // 'none', 'light', 'rested', 'well_rested'
  final String label;
  final String description;
  final String emoji;

  const RestBuff({
    required this.multiplier,
    required this.tier,
    required this.label,
    required this.description,
    required this.emoji,
  });

  bool get isActive => tier != 'none';
}

class AetherResult {
  final int earned;
  final int totalCalories;
  final String description;

  const AetherResult({
    required this.earned,
    required this.totalCalories,
    required this.description,
  });
}

class IntensityBonus {
  final int zone;
  final String zoneName;
  final double multiplier;
  final double avgHeartRate;
  final double peakHeartRate;
  final double maxHeartRate;

  const IntensityBonus({
    required this.zone,
    required this.zoneName,
    required this.multiplier,
    required this.avgHeartRate,
    required this.peakHeartRate,
    required this.maxHeartRate,
  });

  String get zoneEmoji {
    switch (zone) {
      case 5: return '🔥🔥';
      case 4: return '🔥';
      case 3: return '💪';
      case 2: return '🏃';
      default: return '🧘';
    }
  }
}

class ConsistencyBonus {
  final bool isConsistent;
  final double multiplier;
  final String description;
  final int? preferredHour;

  const ConsistencyBonus({
    required this.isConsistent,
    required this.multiplier,
    required this.description,
    this.preferredHour,
  });
}
