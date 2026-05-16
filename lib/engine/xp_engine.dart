import 'dart:math';

/// QuestFit XP & Leveling Engine.
/// Leveling curve: XP_required(level) = floor(100 × level^1.5)
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
  /// Returns an [XpResult] with the new state.
  static XpResult addXp({
    required int currentLevel,
    required int currentXp,
    required int totalXp,
    required int amount,
  }) {
    var level = currentLevel;
    var xp = currentXp + amount;
    var total = totalXp + amount;
    var levelsGained = 0;

    var needed = xpForLevel(level);
    while (xp >= needed) {
      xp -= needed;
      level++;
      levelsGained++;
      needed = xpForLevel(level);
    }

    return XpResult(
      newLevel: level,
      newXp: xp,
      totalXp: total,
      levelsGained: levelsGained,
      didLevelUp: levelsGained > 0,
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

  const XpResult({
    required this.newLevel,
    required this.newXp,
    required this.totalXp,
    required this.levelsGained,
    required this.didLevelUp,
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
