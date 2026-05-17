import 'dart:math';
import 'rank_engine.dart';

/// QuestFit XP & Leveling Engine.
/// Leveling curve: XP_required(level) = floor(100 × level^1.5)
///
/// v2.0: XP capping at promotion boundaries.
class XpEngine {
  const XpEngine._();

  /// Get XP required to complete a given level.
  static int xpForLevel(int level) {
    return (100 * pow(level, 1.5)).floor();
  }

  /// Get cumulative XP from level 1 to [level].
  static int cumulativeXp(int level) {
    var total = 0;
    for (var i = 1; i <= level; i++) {
      total += xpForLevel(i);
    }
    return total;
  }

  /// Add XP to a player, handling multi-level-ups.
  ///
  /// v2.0: If the player hits a promotion boundary, XP is capped
  /// at that level's max and [isXpCapped] is true in the result.
  ///
  /// Returns an [XpResult] with the new state.
  static XpResult addXp({
    required int currentLevel,
    required int currentXp,
    required int totalXp,
    required int amount,
    bool hasActiveTrialOrPassed = false,
  }) {
    var level = currentLevel;
    var xp = currentXp + amount;
    var total = totalXp + amount;
    var levelsGained = 0;
    var isXpCapped = false;

    var needed = xpForLevel(level);
    while (xp >= needed) {
      final nextLevel = level + 1;

      // Check if this is a promotion boundary
      if (!hasActiveTrialOrPassed && RankEngine.isPromotionBoundary(level)) {
        // Cap XP at max for this level — promotion trial required
        xp = needed;
        isXpCapped = true;
        break;
      }

      xp -= needed;
      level = nextLevel;
      levelsGained++;
      needed = xpForLevel(level);
    }

    return XpResult(
      newLevel: level,
      newXp: xp,
      totalXp: total,
      levelsGained: levelsGained,
      didLevelUp: levelsGained > 0,
      isXpCapped: isXpCapped,
    );
  }

  /// Apply rank decay — lose a percentage of current XP.
  static XpDecayResult applyDecay({
    required int currentXp,
    required int totalXp,
    double decayPercentage = 0.15,
  }) {
    final lost = (currentXp * decayPercentage).round();
    return XpDecayResult(
      newXp: (currentXp - lost).clamp(0, currentXp),
      xpLost: lost,
    );
  }

  /// Get current XP progress as percentage.
  static XpProgress getProgress(int level, int xp) {
    final max = xpForLevel(level);
    return XpProgress(
      current: xp,
      max: max,
      percentage: max > 0 ? (xp / max * 100).round().clamp(0, 100) : 0,
    );
  }
}

class XpResult {
  final int newLevel;
  final int newXp;
  final int totalXp;
  final int levelsGained;
  final bool didLevelUp;
  /// v2.0: True when XP hit a promotion boundary cap.
  final bool isXpCapped;

  const XpResult({
    required this.newLevel,
    required this.newXp,
    required this.totalXp,
    required this.levelsGained,
    required this.didLevelUp,
    this.isXpCapped = false,
  });
}

class XpProgress {
  final int current;
  final int max;
  final int percentage;

  const XpProgress({
    required this.current,
    required this.max,
    required this.percentage,
  });
}

class XpDecayResult {
  final int newXp;
  final int xpLost;

  const XpDecayResult({required this.newXp, required this.xpLost});
}
