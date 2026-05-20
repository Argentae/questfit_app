// QuestFit v2.2 — Exercise Catalog Mappings & Companion Definitions
// Maps Free Exercise DB categories → QuestFit quest categories,
// defines companion creatures for the Egg Hatchery, and
// provides difficulty-based reward calculations.

/// Maps Free Exercise DB categories to QuestFit's 4 quest categories.
const Map<String, String> categoryMapping = {
  'strength': 'strength',
  'powerlifting': 'strength',
  'olympic weightlifting': 'strength',
  'strongman': 'strength',
  'stretching': 'flexibility',
  'plyometrics': 'cardio',
  'cardio': 'cardio',
};

/// Maps Free Exercise DB difficulty levels to reward multipliers.
const Map<String, double> difficultyMultipliers = {
  'beginner': 1.0,
  'intermediate': 1.5,
  'expert': 2.0,
};

/// Maps category → emoji for quest display.
const Map<String, String> categoryEmojis = {
  'strength': '🏋️',
  'cardio': '🏃',
  'flexibility': '🧘',
  'core': '💪',
  'plyometrics': '🏃',
  'stretching': '🧘',
  'powerlifting': '🏋️',
  'olympic weightlifting': '🏋️',
  'strongman': '🏋️',
};

/// Maps primary muscle → simplified body region for filtering.
const Map<String, String> muscleRegionMapping = {
  'abdominals': 'Core',
  'abductors': 'Legs',
  'adductors': 'Legs',
  'biceps': 'Arms',
  'calves': 'Legs',
  'chest': 'Chest',
  'forearms': 'Arms',
  'glutes': 'Legs',
  'hamstrings': 'Legs',
  'lats': 'Back',
  'lower back': 'Back',
  'middle back': 'Back',
  'neck': 'Shoulders',
  'quadriceps': 'Legs',
  'shoulders': 'Shoulders',
  'traps': 'Shoulders',
  'triceps': 'Arms',
};

/// Unique body regions for UI filter chips.
const List<String> bodyRegions = [
  'Arms', 'Back', 'Chest', 'Core', 'Legs', 'Shoulders',
];

/// Equipment display names for UI filter chips.
const List<String> equipmentTypes = [
  'body only', 'barbell', 'dumbbell', 'cable', 'machine',
  'kettlebells', 'bands', 'exercise ball', 'medicine ball',
  'foam roll', 'e-z curl bar', 'other',
];

/// Calculates base XP from exercise attributes for LP/Gold reward scaling.
int calculateBaseXp({
  required String level,
  required String category,
  String? mechanic,
}) {
  // Base values by category
  int base;
  switch (categoryMapping[category] ?? category) {
    case 'strength':
      base = 100;
      break;
    case 'cardio':
      base = 80;
      break;
    case 'flexibility':
      base = 50;
      break;
    default:
      base = 70;
  }

  // Compound exercises are harder
  if (mechanic == 'compound') base += 20;

  // Scale by difficulty
  final multiplier = difficultyMultipliers[level] ?? 1.0;
  return (base * multiplier).round();
}

// ─── Companion System ─────────────────────────────────────────────────

/// Defines a companion creature that can hatch from an egg.
class CompanionDef {
  final String type;
  final String name;
  final String rarity;
  final String emoji;
  final String imagePath;
  final String buffType;
  final int buffValue;
  final String buffDescription;

  const CompanionDef({
    required this.type,
    required this.name,
    required this.rarity,
    required this.emoji,
    required this.imagePath,
    required this.buffType,
    required this.buffValue,
    required this.buffDescription,
  });
}

/// All 10 companion creatures in the game.
const List<CompanionDef> companionCatalog = [
  // ── COMMON (3,000 steps to hatch) ────────────────────────────────
  CompanionDef(
    type: 'fire_drake',
    name: 'Fire Drake',
    rarity: 'common',
    emoji: '🔥',
    imagePath: 'assets/images/companions/fire_drake.png',
    buffType: 'gold_bonus',
    buffValue: 3,
    buffDescription: '+3% Gold from quests',
  ),
  CompanionDef(
    type: 'shadow_wolf',
    name: 'Shadow Wolf',
    rarity: 'common',
    emoji: '🐺',
    imagePath: 'assets/images/companions/shadow_wolf.png',
    buffType: 'lp_bonus',
    buffValue: 3,
    buffDescription: '+3% LP from quests',
  ),
  CompanionDef(
    type: 'stone_golem',
    name: 'Stone Golem',
    rarity: 'common',
    emoji: '🪨',
    imagePath: 'assets/images/companions/stone_golem.png',
    buffType: 'str_bonus',
    buffValue: 5,
    buffDescription: '+5% STR stat gain',
  ),
  CompanionDef(
    type: 'wind_hawk',
    name: 'Wind Hawk',
    rarity: 'common',
    emoji: '🦅',
    imagePath: 'assets/images/companions/wind_hawk.png',
    buffType: 'step_bonus',
    buffValue: 10,
    buffDescription: '+10% Step milestone progress',
  ),

  // ── RARE (6,000 steps to hatch) ──────────────────────────────────
  CompanionDef(
    type: 'frost_fox',
    name: 'Frost Fox',
    rarity: 'rare',
    emoji: '🦊',
    imagePath: 'assets/images/companions/frost_fox.png',
    buffType: 'gold_bonus',
    buffValue: 6,
    buffDescription: '+6% Gold from quests',
  ),
  CompanionDef(
    type: 'thunder_bear',
    name: 'Thunder Bear',
    rarity: 'rare',
    emoji: '🐻',
    imagePath: 'assets/images/companions/thunder_bear.png',
    buffType: 'lp_bonus',
    buffValue: 6,
    buffDescription: '+6% LP from quests',
  ),
  CompanionDef(
    type: 'crystal_stag',
    name: 'Crystal Stag',
    rarity: 'rare',
    emoji: '🦌',
    imagePath: 'assets/images/companions/crystal_stag.png',
    buffType: 'streak_shield',
    buffValue: 1,
    buffDescription: 'Protects 1 streak day on miss',
  ),

  // ── EPIC (10,000 steps to hatch) ─────────────────────────────────
  CompanionDef(
    type: 'ember_phoenix',
    name: 'Ember Phoenix',
    rarity: 'epic',
    emoji: '🔥',
    imagePath: 'assets/images/companions/ember_phoenix.png',
    buffType: 'gold_bonus',
    buffValue: 10,
    buffDescription: '+10% Gold from quests',
  ),
  CompanionDef(
    type: 'void_serpent',
    name: 'Void Serpent',
    rarity: 'epic',
    emoji: '🐍',
    imagePath: 'assets/images/companions/void_serpent.png',
    buffType: 'lp_bonus',
    buffValue: 10,
    buffDescription: '+10% LP from quests',
  ),

  // ── LEGENDARY (20,000 steps to hatch) ────────────────────────────
  CompanionDef(
    type: 'celestial_dragon',
    name: 'Celestial Dragon',
    rarity: 'legendary',
    emoji: '🐉',
    imagePath: 'assets/images/companions/celestial_dragon.png',
    buffType: 'all_bonus',
    buffValue: 8,
    buffDescription: '+8% to ALL rewards',
  ),
];

/// Steps required to hatch an egg by rarity.
const Map<String, int> eggStepRequirements = {
  'common': 3000,
  'rare': 6000,
  'epic': 10000,
  'legendary': 20000,
};

/// Companion rarity colors (matching weapon rarity system).
const Map<String, int> companionRarityColors = {
  'common': 0xFF8B8B8B,
  'rare': 0xFF60A5FA,
  'epic': 0xFFA78BFA,
  'legendary': 0xFFF0C850,
};

/// Gets a random companion of the given rarity from the catalog.
CompanionDef getRandomCompanion(String rarity) {
  final pool = companionCatalog.where((c) => c.rarity == rarity).toList();
  pool.shuffle();
  return pool.first;
}

/// Gets a companion definition by type key.
CompanionDef? getCompanionByType(String type) {
  try {
    return companionCatalog.firstWhere((c) => c.type == type);
  } catch (_) {
    return null;
  }
}
