/// QuestFit v2.0 — Gold Economy Engine.
/// Handles gold earning, streak multipliers, and boss raid chests.
class GoldEngine {
  const GoldEngine._();

  /// Base gold reward for completing a daily quest.
  static const int baseQuestGold = 25;

  /// Gold reward for boss raid completion (scales with level).
  static int bossRaidGold(int playerLevel) {
    return (200 + playerLevel * 5).clamp(200, 500);
  }

  /// Calculate gold reward with streak multiplier.
  ///
  /// Streak thresholds:
  /// - 3+ days  → 1.2×
  /// - 7+ days  → 1.5×
  /// - 14+ days → 2.0×
  /// - 30+ days → 3.0×
  static GoldReward calculateReward({
    required int baseGold,
    required int currentStreak,
  }) {
    final multiplier = getStreakMultiplier(currentStreak);
    final total = (baseGold * multiplier).round();

    return GoldReward(
      baseGold: baseGold,
      multiplier: multiplier,
      totalGold: total,
      streakBonus: total - baseGold,
    );
  }

  /// Get the gold multiplier for a given streak length.
  static double getStreakMultiplier(int currentStreak) {
    if (currentStreak >= 30) return 3.0;
    if (currentStreak >= 14) return 2.0;
    if (currentStreak >= 7) return 1.5;
    if (currentStreak >= 3) return 1.2;
    return 1.0;
  }

  /// Shop item prices.
  static const Map<String, int> shopPrices = {
    'streak_insurance': 300,
    'quest_reroll': 150,
  };

  /// Check if the player can afford an item.
  static bool canAfford(int currentGold, int price) {
    return currentGold >= price;
  }
}

class GoldReward {
  final int baseGold;
  final double multiplier;
  final int totalGold;
  final int streakBonus;

  const GoldReward({
    required this.baseGold,
    required this.multiplier,
    required this.totalGold,
    required this.streakBonus,
  });
}
