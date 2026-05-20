// QuestFit v2.3 — Enemy Catalog
// Defines all enemies across tiers and difficulties.
// Each enemy has an element, HP, weaknesses/resistances, and reward/penalty values.

import 'dart:math';
/// Element types in the combat system.
class Elements {
  static const fire = 'fire';
  static const water = 'water';
  static const wind = 'wind';
  static const earth = 'earth';
  static const shadow = 'shadow';

  /// Maps exercise categories to elements.
  static const Map<String, String> categoryToElement = {
    'strength': fire,
    'cardio': wind,
    'flexibility': water,
    'stretching': water,
    'plyometrics': wind,
    'powerlifting': earth,
    'strongman': earth,
    'olympic weightlifting': fire,
  };

  /// Element display info.
  static const Map<String, String> emoji = {
    fire: '🔥',
    water: '💧',
    wind: '🌪️',
    earth: '🪨',
    shadow: '🌑',
  };

  static const Map<String, int> color = {
    fire: 0xFFFF6B35,
    water: 0xFF60A5FA,
    wind: 0xFF2DD4A8,
    earth: 0xFFCD7F32,
    shadow: 0xFFA78BFA,
  };
}

/// Defines an enemy in the catalog.
class EnemyDef {
  final String key;
  final String name;
  final String description;
  final String elementType;
  final String tier;
  final String difficulty; // easy, medium, hard
  final int hp;
  final int lpReward;
  final int goldReward;
  final int lpPenalty;
  final List<String> weaknesses; // exercise categories that deal 2× dmg
  final List<String> resistances; // exercise categories that deal 0.5× dmg
  final List<String> immunities; // exercise categories that deal 0× dmg
  final String? requiredStat;
  final int? requiredStatValue;
  final String imagePath;
  final String emoji;

  const EnemyDef({
    required this.key,
    required this.name,
    required this.description,
    required this.elementType,
    required this.tier,
    required this.difficulty,
    required this.hp,
    required this.lpReward,
    required this.goldReward,
    required this.lpPenalty,
    required this.weaknesses,
    required this.resistances,
    this.immunities = const [],
    this.requiredStat,
    this.requiredStatValue,
    required this.imagePath,
    required this.emoji,
  });
}

/// All enemies in the game, organized by tier.
const List<EnemyDef> enemyCatalog = [
  // ═══════════════════════════════════════════════════════════════════
  // IRON TIER — Entry-level enemies (low HP, generous rewards)
  // ═══════════════════════════════════════════════════════════════════

  // Easy
  EnemyDef(
    key: 'iron_flame_goblin',
    name: 'Flame Goblin',
    description: 'A mischievous imp that throws firecrackers. More annoying than dangerous.',
    elementType: Elements.fire,
    tier: 'iron', difficulty: 'easy',
    hp: 200,
    lpReward: 12, goldReward: 20, lpPenalty: 5,
    weaknesses: ['flexibility', 'stretching'],
    resistances: ['strength'],
    imagePath: 'assets/images/enemies/flame_goblin.png',
    emoji: '👺',
  ),
  // Medium
  EnemyDef(
    key: 'iron_frost_goblin',
    name: 'Frost Goblin',
    description: 'An icy variant of the common goblin. Its frozen armor slows your blows.',
    elementType: Elements.water,
    tier: 'iron', difficulty: 'medium',
    hp: 400,
    lpReward: 18, goldReward: 35, lpPenalty: 10,
    weaknesses: ['cardio', 'plyometrics'],
    resistances: ['flexibility', 'stretching'],
    imagePath: 'assets/images/enemies/frost_goblin.png',
    emoji: '🧊',
  ),
  // Hard
  EnemyDef(
    key: 'iron_shadow_goblin',
    name: 'Shadow Goblin',
    description: 'A goblin infused with dark energy. Fast, vicious, and hungry for your LP.',
    elementType: Elements.shadow,
    tier: 'iron', difficulty: 'hard',
    hp: 600,
    lpReward: 25, goldReward: 50, lpPenalty: 15,
    weaknesses: ['strength', 'powerlifting'],
    resistances: ['cardio'],
    immunities: ['stretching'],
    imagePath: 'assets/images/enemies/shadow_goblin.png',
    emoji: '🌑',
  ),

  // ═══════════════════════════════════════════════════════════════════
  // BRONZE TIER — Tougher enemies, harder tradeoffs
  // ═══════════════════════════════════════════════════════════════════

  // Easy
  EnemyDef(
    key: 'bronze_lava_hound',
    name: 'Lava Hound',
    description: 'A molten beast that prowls the volcanic wastelands. Its hide resists blunt force.',
    elementType: Elements.fire,
    tier: 'bronze', difficulty: 'easy',
    hp: 500,
    lpReward: 15, goldReward: 30, lpPenalty: 8,
    weaknesses: ['cardio', 'flexibility'],
    resistances: ['strength'],
    imagePath: 'assets/images/enemies/lava_hound.png',
    emoji: '🐕‍🦺',
  ),
  // Medium
  EnemyDef(
    key: 'bronze_storm_hawk',
    name: 'Storm Hawk',
    description: 'A raptor cloaked in lightning. Only grounded by overwhelming endurance.',
    elementType: Elements.wind,
    tier: 'bronze', difficulty: 'medium',
    hp: 800,
    lpReward: 22, goldReward: 45, lpPenalty: 12,
    weaknesses: ['strength', 'powerlifting'],
    resistances: ['cardio', 'plyometrics'],
    imagePath: 'assets/images/enemies/storm_hawk.png',
    emoji: '🦅',
  ),
  // Hard
  EnemyDef(
    key: 'bronze_stone_troll',
    name: 'Stone Troll',
    description: 'An ancient troll made of living rock. Crush it with explosive power or drown it with flexibility.',
    elementType: Elements.earth,
    tier: 'bronze', difficulty: 'hard',
    hp: 1200,
    lpReward: 30, goldReward: 65, lpPenalty: 18,
    weaknesses: ['flexibility', 'cardio'],
    resistances: ['strength', 'powerlifting'],
    immunities: ['stretching'],
    requiredStat: 'str', requiredStatValue: 10,
    imagePath: 'assets/images/enemies/stone_troll.png',
    emoji: '🧌',
  ),

  // ═══════════════════════════════════════════════════════════════════
  // SILVER TIER — Dangerous foes
  // ═══════════════════════════════════════════════════════════════════

  // Easy
  EnemyDef(
    key: 'silver_tide_serpent',
    name: 'Tide Serpent',
    description: 'A sea creature that strikes from the depths. Weak to sustained pressure.',
    elementType: Elements.water,
    tier: 'silver', difficulty: 'easy',
    hp: 800,
    lpReward: 18, goldReward: 40, lpPenalty: 10,
    weaknesses: ['plyometrics', 'cardio'],
    resistances: ['flexibility'],
    imagePath: 'assets/images/enemies/tide_serpent.png',
    emoji: '🐍',
  ),
  // Medium
  EnemyDef(
    key: 'silver_void_wraith',
    name: 'Void Wraith',
    description: 'A spectral horror from the shadow realm. Only raw physical power can hurt it.',
    elementType: Elements.shadow,
    tier: 'silver', difficulty: 'medium',
    hp: 1200,
    lpReward: 25, goldReward: 55, lpPenalty: 15,
    weaknesses: ['strength', 'strongman'],
    resistances: ['stretching', 'flexibility'],
    immunities: ['cardio'],
    requiredStat: 'end', requiredStatValue: 15,
    imagePath: 'assets/images/enemies/void_wraith.png',
    emoji: '👻',
  ),
  // Hard
  EnemyDef(
    key: 'silver_iron_colossus',
    name: 'Iron Colossus',
    description: 'A towering construct of forged metal. Requires mastery of every discipline.',
    elementType: Elements.earth,
    tier: 'silver', difficulty: 'hard',
    hp: 1800,
    lpReward: 35, goldReward: 80, lpPenalty: 22,
    weaknesses: ['cardio'],
    resistances: ['strength', 'powerlifting'],
    requiredStat: 'str', requiredStatValue: 25,
    imagePath: 'assets/images/enemies/iron_colossus.png',
    emoji: '🤖',
  ),

  // ═══════════════════════════════════════════════════════════════════
  // GOLD TIER — Elite threats
  // ═══════════════════════════════════════════════════════════════════

  // Easy
  EnemyDef(
    key: 'gold_inferno_drake',
    name: 'Inferno Drake',
    description: 'A lesser dragon wreathed in cursed flame. Douse it with water-element discipline.',
    elementType: Elements.fire,
    tier: 'gold', difficulty: 'easy',
    hp: 1200,
    lpReward: 20, goldReward: 50, lpPenalty: 12,
    weaknesses: ['flexibility', 'stretching'],
    resistances: ['strength', 'powerlifting'],
    imagePath: 'assets/images/enemies/inferno_drake.png',
    emoji: '🐲',
  ),
  // Medium
  EnemyDef(
    key: 'gold_tempest_wyvern',
    name: 'Tempest Wyvern',
    description: 'A sky predator that strikes with devastating speed. Ground it with brute force.',
    elementType: Elements.wind,
    tier: 'gold', difficulty: 'medium',
    hp: 1800,
    lpReward: 28, goldReward: 70, lpPenalty: 18,
    weaknesses: ['strength', 'strongman'],
    resistances: ['cardio', 'plyometrics'],
    requiredStat: 'end', requiredStatValue: 30,
    imagePath: 'assets/images/enemies/tempest_wyvern.png',
    emoji: '🐉',
  ),
  // Hard
  EnemyDef(
    key: 'gold_abyssal_leviathan',
    name: 'Abyssal Leviathan',
    description: 'An ancient sea beast of impossible scale. Only the most versatile warriors survive.',
    elementType: Elements.water,
    tier: 'gold', difficulty: 'hard',
    hp: 2500,
    lpReward: 40, goldReward: 100, lpPenalty: 25,
    weaknesses: ['plyometrics'],
    resistances: ['flexibility', 'stretching', 'cardio'],
    immunities: ['strength'],
    requiredStat: 'agi', requiredStatValue: 30,
    imagePath: 'assets/images/enemies/abyssal_leviathan.png',
    emoji: '🦑',
  ),
];

/// Tier order for enemy scaling.
const List<String> tierOrder = [
  'iron', 'bronze', 'silver', 'gold', 'platinum',
  'emerald', 'diamond', 'master', 'grandmaster', 'challenger',
];

/// Gets enemies available for a given player tier.
/// Returns enemies from the player's tier and one tier below.
List<EnemyDef> getEnemiesForTier(String playerTier) {
  final tierIdx = tierOrder.indexOf(playerTier.toLowerCase());
  if (tierIdx < 0) return enemyCatalog.where((e) => e.tier == 'iron').toList();

  // Include enemies from current tier and one tier below
  final validTiers = <String>{};
  validTiers.add(tierOrder[tierIdx]);
  if (tierIdx > 0) validTiers.add(tierOrder[tierIdx - 1]);

  final pool = enemyCatalog.where((e) => validTiers.contains(e.tier)).toList();
  return pool.isNotEmpty ? pool : enemyCatalog.where((e) => e.tier == 'iron').toList();
}

/// Generates a draft of 3 enemies (easy/medium/hard) for the player.
List<EnemyDef> generateDraft(String playerTier) {
  final pool = getEnemiesForTier(playerTier);
  final rng = Random();

  final easy = pool.where((e) => e.difficulty == 'easy').toList();
  final medium = pool.where((e) => e.difficulty == 'medium').toList();
  final hard = pool.where((e) => e.difficulty == 'hard').toList();

  // Pick one from each, with fallbacks
  final picks = <EnemyDef>[];
  if (easy.isNotEmpty) picks.add(easy[rng.nextInt(easy.length)]);
  if (medium.isNotEmpty) picks.add(medium[rng.nextInt(medium.length)]);
  if (hard.isNotEmpty) picks.add(hard[rng.nextInt(hard.length)]);

  // If we don't have all 3, fill from whatever's available
  while (picks.length < 3 && pool.isNotEmpty) {
    final remaining = pool.where((e) => !picks.contains(e)).toList();
    if (remaining.isEmpty) break;
    picks.add(remaining[rng.nextInt(remaining.length)]);
  }

  return picks;
}

/// Difficulty display info.
const Map<String, String> difficultyEmoji = {
  'easy': '🟢',
  'medium': '🟡',
  'hard': '🔴',
};

const Map<String, int> difficultyColor = {
  'easy': 0xFF2DD4A8,
  'medium': 0xFFF0C850,
  'hard': 0xFFFF6B35,
};
