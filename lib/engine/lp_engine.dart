/// QuestFit LP (League Points) Engine.
///
/// LP range: 0–100 per division.
/// Reaching 100 LP marks a pending promotion (applied on next app launch).
/// LP cannot exceed 100 or go below 0 (decay below 0 triggers demotion).
///
/// Mastery bonus: Every 25 stat points in the relevant category = +1 bonus LP.
/// Streak bonus: +1 LP at 3+ days, +2 at 7+, +3 at 14+.
class LpEngine {
  const LpEngine._();

  /// Base LP awarded per quest.
  static const int baseQuestLp = 8;

  /// LP at which promotion is triggered.
  static const int maxLp = 100;

  /// LP you land on after demotion.
  static const int demotionLandingLp = 75;

  // ─── LP Gain ──────────────────────────────────────────────────────

  /// Add LP to a player's current LP. Caps at 100.
  static LpResult addLp({
    required int currentLp,
    required int amount,
  }) {
    final newLp = (currentLp + amount).clamp(0, maxLp);
    return LpResult(
      newLp: newLp,
      lpGained: newLp - currentLp,
      isPromotionReady: newLp >= maxLp,
    );
  }

  /// Calculate the total LP reward for a quest, including bonuses.
  ///
  /// [baseLp] — The quest's base LP reward.
  /// [masteryPoints] — Stat points in the quest's category (STR/Cardio/FLX).
  /// [currentStreak] — Player's current streak length.
  /// [momentumBuff] — v2.2: Whether the Momentum Buff is active (+10%).
  /// [companionBonusPct] — v2.2: Active companion LP bonus percentage.
  /// [restBuffMultiplier] — v2.4: Rest buff from sleep quality (1.0–1.20).
  static int calculateQuestLp({
    required int baseLp,
    required int masteryPoints,
    required int currentStreak,
    bool momentumBuff = false,
    int companionBonusPct = 0,
    double restBuffMultiplier = 1.0,
  }) {
    // Mastery bonus: +1 LP per 25 stat points in the relevant category
    final masteryBonus = masteryPoints ~/ 25;

    // Streak bonus: scales with streak length
    int streakBonus = 0;
    if (currentStreak >= 14) {
      streakBonus = 3;
    } else if (currentStreak >= 7) {
      streakBonus = 2;
    } else if (currentStreak >= 3) {
      streakBonus = 1;
    }

    var total = baseLp + masteryBonus + streakBonus;

    // v2.2: Momentum Buff (+10%)
    if (momentumBuff) {
      total = (total * 1.10).round();
    }

    // v2.2: Companion bonus
    if (companionBonusPct > 0) {
      total = (total * (1 + companionBonusPct / 100.0)).round();
    }

    // v2.4: Rest buff from sleep quality
    if (restBuffMultiplier > 1.0) {
      total = (total * restBuffMultiplier).round();
    }

    return total;
  }

  // ─── LP Loss / Decay ──────────────────────────────────────────────

  /// Remove LP (from inactivity decay). Can trigger demotion.
  static LpDecayResult removeLp({
    required int currentLp,
    required int amount,
  }) {
    final result = currentLp - amount;
    final shouldDemote = result < 0;

    return LpDecayResult(
      // After demotion, land at 75 LP in the lower division
      newLp: shouldDemote ? demotionLandingLp : result,
      lpLost: amount,
      shouldDemote: shouldDemote,
    );
  }

  // ─── Progress Display ──────────────────────────────────────────────

  /// Get LP progress data for UI display.
  static LpProgress getProgress(int lp) {
    return LpProgress(
      current: lp.clamp(0, maxLp),
      max: maxLp,
      percentage: lp.clamp(0, maxLp),
    );
  }
}

// ─── Data Classes ──────────────────────────────────────────────────────

class LpResult {
  final int newLp;
  final int lpGained;
  final bool isPromotionReady;

  const LpResult({
    required this.newLp,
    required this.lpGained,
    required this.isPromotionReady,
  });
}

class LpProgress {
  final int current;
  final int max;
  final int percentage;

  const LpProgress({
    required this.current,
    required this.max,
    required this.percentage,
  });
}

class LpDecayResult {
  final int newLp;
  final int lpLost;
  final bool shouldDemote;

  const LpDecayResult({
    required this.newLp,
    required this.lpLost,
    required this.shouldDemote,
  });
}
