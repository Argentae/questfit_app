/// QuestFit v2.1 — Gold Economy Engine.
/// Handles gold earning, streak multipliers, equipment bonuses, and boss raid chests.
///
/// v2.1: Reduced base gold from 25 → 5 per quest.
/// Hard exercises and equipped items now drive higher gold rewards.
class GoldEngine {
  const GoldEngine._();

  /// Base gold reward for completing a daily quest.
  static const int baseQuestGold = 5;

  /// Bonus gold when a quest comes from an equipped weapon.
  static const int equipmentBonus = 3;

  /// Gold reward for boss raid completion (scales with tier).
  static int bossRaidGold(int playerLevel) {
    return (50 + playerLevel * 2).clamp(50, 150);
  }

  /// Calculate the gold reward for a quest based on difficulty.
  ///
  /// Uses [baseXp] from the exercise definition as a difficulty proxy:
  /// - Low difficulty  (baseXp < 70):  base gold (5)
  /// - Medium difficulty (70–109):     base + 2 (7)
  /// - Hard difficulty   (110–139):    base + 5 (10)
  /// - Very hard         (140+):       base + 8 (13)
  static int questGold({
    required int baseXp,
    bool fromWeapon = false,
    String? weaponRarity,
  }) {
    int gold = baseQuestGold;

    // Difficulty bonus based on exercise intensity
    if (baseXp >= 140) {
      gold += 8;
    } else if (baseXp >= 110) {
      gold += 5;
    } else if (baseXp >= 70) {
      gold += 2;
    }

    // Equipment bonus: quests from equipped weapons pay more
    if (fromWeapon) {
      gold += equipmentBonus;

      // Rarity multiplier for equipped weapon
      if (weaponRarity != null) {
        gold += _rarityBonus(weaponRarity);
      }
    }

    return gold;
  }

  /// Extra gold from weapon rarity.
  static int _rarityBonus(String rarity) {
    switch (rarity) {
      case 'rare':
        return 2;
      case 'epic':
        return 5;
      case 'legendary':
        return 10;
      default:
        return 0; // common
    }
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
