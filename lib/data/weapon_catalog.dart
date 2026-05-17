// QuestFit v2.0 — Weapon Catalog
// Maps all 20 weapon assets to exercises and metadata.
// Each weapon dictates workout routines when equipped.

class WeaponDef {
  final String key;
  final String name;
  final String description;
  final String rarity; // common, rare, epic, legendary
  final String imagePath;
  final String category;
  final bool isOwned; // true = starter weapon (free)
  final int price;
  final List<WeaponExerciseDef> exercises;

  const WeaponDef({
    required this.key,
    required this.name,
    required this.description,
    required this.rarity,
    required this.imagePath,
    required this.category,
    required this.isOwned,
    required this.price,
    required this.exercises,
  });
}

class WeaponExerciseDef {
  final String title;
  final String category;
  final String emoji;
  final int? sets;
  final int? reps;
  final int? duration;
  final int baseXp;

  const WeaponExerciseDef({
    required this.title,
    required this.category,
    required this.emoji,
    this.sets,
    this.reps,
    this.duration,
    required this.baseXp,
  });
}

/// All 20 weapons in the game.
/// Rarity distribution: 6 Common (starter) → 6 Rare → 5 Epic → 3 Legendary
const List<WeaponDef> weaponCatalog = [
  // ── COMMON (Starter / Free) ──────────────────────────────────────────

  WeaponDef(
    key: 'dusted_longsword',
    name: 'Dusted Longsword',
    description: 'A forgotten blade, still sharp enough to cut through laziness.',
    rarity: 'common',
    imagePath: 'assets/images/dusted_longsword.webp',
    category: 'strength',
    isOwned: true,
    price: 0,
    exercises: [
      WeaponExerciseDef(title: 'Barbell Squats', category: 'strength', emoji: '🏋️', sets: 3, reps: 10, baseXp: 120),
      WeaponExerciseDef(title: 'Bench Press', category: 'strength', emoji: '🏋️', sets: 4, reps: 8, baseXp: 130),
    ],
  ),

  WeaponDef(
    key: 'splintered_spear',
    name: 'Splintered Spear',
    description: 'Cracked but relentless — built for endurance, not elegance.',
    rarity: 'common',
    imagePath: 'assets/images/splintered_spear.webp',
    category: 'cardio',
    isOwned: true,
    price: 0,
    exercises: [
      WeaponExerciseDef(title: 'Treadmill Sprint', category: 'cardio', emoji: '🏃', duration: 15, baseXp: 90),
      WeaponExerciseDef(title: 'Jump Rope', category: 'cardio', emoji: '🏃', duration: 10, baseXp: 80),
    ],
  ),

  WeaponDef(
    key: 'birch_staff',
    name: 'Birch Staff',
    description: 'A monk\'s companion — the path to flexibility begins here.',
    rarity: 'common',
    imagePath: 'assets/images/birch_staff.webp',
    category: 'flexibility',
    isOwned: true,
    price: 0,
    exercises: [
      WeaponExerciseDef(title: 'Hip Mobility Flow', category: 'flexibility', emoji: '🧘', duration: 10, baseXp: 50),
      WeaponExerciseDef(title: 'Yoga Sun Salutation', category: 'flexibility', emoji: '🧘', duration: 15, baseXp: 65),
    ],
  ),

  WeaponDef(
    key: 'worn_hammer',
    name: 'Worn Hammer',
    description: 'Heavy and reliable — every swing builds raw power.',
    rarity: 'common',
    imagePath: 'assets/images/worn_hammer.webp',
    category: 'strength',
    isOwned: true,
    price: 0,
    exercises: [
      WeaponExerciseDef(title: 'Overhead Press', category: 'strength', emoji: '🏋️', sets: 3, reps: 8, baseXp: 110),
      WeaponExerciseDef(title: 'Barbell Row', category: 'strength', emoji: '🏋️', sets: 4, reps: 8, baseXp: 120),
    ],
  ),

  WeaponDef(
    key: 'sturdy_club',
    name: 'Sturdy Club',
    description: 'Crude but effective — forges an iron core.',
    rarity: 'common',
    imagePath: 'assets/images/sturdy_club.webp',
    category: 'core',
    isOwned: true,
    price: 0,
    exercises: [
      WeaponExerciseDef(title: 'Plank Challenge', category: 'core', emoji: '💪', sets: 3, duration: 1, baseXp: 75),
      WeaponExerciseDef(title: 'Mountain Climbers', category: 'core', emoji: '💪', sets: 3, reps: 20, baseXp: 80),
    ],
  ),

  WeaponDef(
    key: 'recruits_spear',
    name: "Recruit's Spear",
    description: 'The first weapon of every warrior — teaches discipline.',
    rarity: 'common',
    imagePath: 'assets/images/recruits_spear.webp',
    category: 'flexibility',
    isOwned: true,
    price: 0,
    exercises: [
      WeaponExerciseDef(title: 'Dynamic Warm-Up', category: 'flexibility', emoji: '🧘', duration: 10, baseXp: 45),
      WeaponExerciseDef(title: 'Full Body Stretch', category: 'flexibility', emoji: '🧘', duration: 20, baseXp: 70),
    ],
  ),

  // ── RARE (200 Gold) ──────────────────────────────────────────────────

  WeaponDef(
    key: 'crude_mace',
    name: 'Crude Mace',
    description: 'Forged in a blacksmith\'s first fire — devastating in the right hands.',
    rarity: 'rare',
    imagePath: 'assets/images/crude_mace.webp',
    category: 'strength',
    isOwned: false,
    price: 200,
    exercises: [
      WeaponExerciseDef(title: 'Deadlift', category: 'strength', emoji: '🏋️', sets: 3, reps: 5, baseXp: 150),
      WeaponExerciseDef(title: 'Leg Press', category: 'strength', emoji: '🏋️', sets: 4, reps: 10, baseXp: 100),
    ],
  ),

  WeaponDef(
    key: 'polished_dagger',
    name: 'Polished Dagger',
    description: 'Quick and deadly — favors speed over brute strength.',
    rarity: 'rare',
    imagePath: 'assets/images/polished_dagger.webp',
    category: 'cardio',
    isOwned: false,
    price: 200,
    exercises: [
      WeaponExerciseDef(title: 'Battle Ropes', category: 'cardio', emoji: '🏃', duration: 8, baseXp: 85),
      WeaponExerciseDef(title: 'Box Jumps', category: 'cardio', emoji: '🏃', sets: 4, reps: 10, baseXp: 95),
    ],
  ),

  WeaponDef(
    key: 'mercenarys_dagger',
    name: "Mercenary's Dagger",
    description: 'Balanced for both assassination and conditioning.',
    rarity: 'rare',
    imagePath: 'assets/images/mercenarys_dagger.webp',
    category: 'cardio',
    isOwned: false,
    price: 200,
    exercises: [
      WeaponExerciseDef(title: 'Burpees', category: 'cardio', emoji: '🏃', sets: 3, reps: 15, baseXp: 100),
      WeaponExerciseDef(title: 'Rowing Machine', category: 'cardio', emoji: '🚣', duration: 20, baseXp: 100),
    ],
  ),

  WeaponDef(
    key: 'rust_covered_axe',
    name: 'Rust-Covered Axe',
    description: 'The rust hides a blade that still bites deep.',
    rarity: 'rare',
    imagePath: 'assets/images/rust_covered_axe.webp',
    category: 'strength',
    isOwned: false,
    price: 200,
    exercises: [
      WeaponExerciseDef(title: 'Dumbbell Curl', category: 'strength', emoji: '🏋️', sets: 3, reps: 12, baseXp: 70),
      WeaponExerciseDef(title: 'Tricep Dips', category: 'strength', emoji: '🏋️', sets: 3, reps: 10, baseXp: 80),
    ],
  ),

  WeaponDef(
    key: 'iron_greatsword',
    name: 'Iron Greatsword',
    description: 'Massive, unyielding iron — only the strongest can wield it.',
    rarity: 'rare',
    imagePath: 'assets/images/iron_greatsword.webp',
    category: 'strength',
    isOwned: false,
    price: 200,
    exercises: [
      WeaponExerciseDef(title: 'Bench Press', category: 'strength', emoji: '🏋️', sets: 4, reps: 8, baseXp: 130),
      WeaponExerciseDef(title: 'Deadlift', category: 'strength', emoji: '🏋️', sets: 3, reps: 5, baseXp: 150),
    ],
  ),

  WeaponDef(
    key: 'hunters_longbow',
    name: "Hunter's Longbow",
    description: 'Requires stamina, precision, and relentless endurance.',
    rarity: 'rare',
    imagePath: 'assets/images/hunters_longbow.webp',
    category: 'cardio',
    isOwned: false,
    price: 200,
    exercises: [
      WeaponExerciseDef(title: 'Cycling', category: 'cardio', emoji: '🚴', duration: 30, baseXp: 120),
      WeaponExerciseDef(title: 'Stair Climber', category: 'cardio', emoji: '🏃', duration: 15, baseXp: 95),
    ],
  ),

  // ── EPIC (500 Gold) ──────────────────────────────────────────────────

  WeaponDef(
    key: 'bloodmoon_sword',
    name: 'Bloodmoon Sword',
    description: 'Forged under a crimson moon — channels fury into raw power.',
    rarity: 'epic',
    imagePath: 'assets/images/bloodmoon_sword.webp',
    category: 'strength',
    isOwned: false,
    price: 500,
    exercises: [
      WeaponExerciseDef(title: 'Deadlift', category: 'strength', emoji: '🏋️', sets: 3, reps: 5, baseXp: 150),
      WeaponExerciseDef(title: 'Barbell Squats', category: 'strength', emoji: '🏋️', sets: 3, reps: 10, baseXp: 120),
      WeaponExerciseDef(title: 'Overhead Press', category: 'strength', emoji: '🏋️', sets: 3, reps: 8, baseXp: 110),
    ],
  ),

  WeaponDef(
    key: 'dragons_fang',
    name: "Dragon's Fang",
    description: 'Torn from a wyrm\'s jaw — demands absolute core control.',
    rarity: 'epic',
    imagePath: 'assets/images/dragons_fang.webp',
    category: 'core',
    isOwned: false,
    price: 500,
    exercises: [
      WeaponExerciseDef(title: 'Dragon Flag', category: 'core', emoji: '💪', sets: 3, reps: 5, baseXp: 100),
      WeaponExerciseDef(title: 'Hanging Leg Raise', category: 'core', emoji: '💪', sets: 3, reps: 10, baseXp: 90),
      WeaponExerciseDef(title: 'Ab Wheel Rollout', category: 'core', emoji: '💪', sets: 3, reps: 12, baseXp: 85),
    ],
  ),

  WeaponDef(
    key: 'aura_breaker',
    name: 'Aura Breaker',
    description: 'Shatters defenses — builds upper body dominance.',
    rarity: 'epic',
    imagePath: 'assets/images/aura_breaker.webp',
    category: 'strength',
    isOwned: false,
    price: 500,
    exercises: [
      WeaponExerciseDef(title: 'Bench Press', category: 'strength', emoji: '🏋️', sets: 4, reps: 8, baseXp: 130),
      WeaponExerciseDef(title: 'Lat Pulldown', category: 'strength', emoji: '🏋️', sets: 3, reps: 10, baseXp: 90),
      WeaponExerciseDef(title: 'Shoulder Shrugs', category: 'strength', emoji: '🏋️', sets: 4, reps: 12, baseXp: 60),
    ],
  ),

  WeaponDef(
    key: 'venomstrike_bow',
    name: 'Venomstrike Bow',
    description: 'Poison-tipped precision — lethal cardio conditioning.',
    rarity: 'epic',
    imagePath: 'assets/images/venomstrike_bow.webp',
    category: 'cardio',
    isOwned: false,
    price: 500,
    exercises: [
      WeaponExerciseDef(title: 'Swimming Laps', category: 'cardio', emoji: '🏊', duration: 20, baseXp: 110),
      WeaponExerciseDef(title: 'Elliptical Trainer', category: 'cardio', emoji: '🏃', duration: 25, baseXp: 90),
      WeaponExerciseDef(title: 'Jump Rope', category: 'cardio', emoji: '🏃', duration: 10, baseXp: 80),
    ],
  ),

  WeaponDef(
    key: 'voidreavers_dagger',
    name: "Voidreaver's Dagger",
    description: 'Carved from the void — twists and shreds the core.',
    rarity: 'epic',
    imagePath: 'assets/images/voidreavers_dagger.webp',
    category: 'core',
    isOwned: false,
    price: 500,
    exercises: [
      WeaponExerciseDef(title: 'Russian Twists', category: 'core', emoji: '💪', sets: 3, reps: 20, baseXp: 70),
      WeaponExerciseDef(title: 'Cable Woodchop', category: 'core', emoji: '💪', sets: 3, reps: 12, baseXp: 75),
      WeaponExerciseDef(title: 'Pallof Press', category: 'core', emoji: '💪', sets: 3, reps: 10, baseXp: 65),
    ],
  ),

  // ── LEGENDARY (1000 Gold) ────────────────────────────────────────────

  WeaponDef(
    key: 'glacial_axe',
    name: 'Glacial Axe',
    description: 'Frozen in eternal ice — only a titan can lift it.',
    rarity: 'legendary',
    imagePath: 'assets/images/glacial_axe.webp',
    category: 'strength',
    isOwned: false,
    price: 1000,
    exercises: [
      WeaponExerciseDef(title: 'Barbell Squats', category: 'strength', emoji: '🏋️', sets: 3, reps: 10, baseXp: 120),
      WeaponExerciseDef(title: 'Leg Press', category: 'strength', emoji: '🏋️', sets: 4, reps: 10, baseXp: 100),
      WeaponExerciseDef(title: 'Barbell Row', category: 'strength', emoji: '🏋️', sets: 4, reps: 8, baseXp: 120),
    ],
  ),

  WeaponDef(
    key: 'cataclysms_breath',
    name: "Cataclysm's Breath",
    description: 'The storm incarnate — unleashes relentless cardio fury.',
    rarity: 'legendary',
    imagePath: 'assets/images/cataclysms_breath.webp',
    category: 'cardio',
    isOwned: false,
    price: 1000,
    exercises: [
      WeaponExerciseDef(title: 'Treadmill Sprint', category: 'cardio', emoji: '🏃', duration: 15, baseXp: 90),
      WeaponExerciseDef(title: 'Rowing Machine', category: 'cardio', emoji: '🚣', duration: 20, baseXp: 100),
      WeaponExerciseDef(title: 'Stair Climber', category: 'cardio', emoji: '🏃', duration: 15, baseXp: 95),
    ],
  ),

  WeaponDef(
    key: 'the_world_sunderer',
    name: 'The World Sunderer',
    description: 'Legend says it split a continent — demands total-body mastery.',
    rarity: 'legendary',
    imagePath: 'assets/images/the_world_sunderer.webp',
    category: 'strength',
    isOwned: false,
    price: 1000,
    exercises: [
      WeaponExerciseDef(title: 'Deadlift', category: 'strength', emoji: '🏋️', sets: 3, reps: 5, baseXp: 150),
      WeaponExerciseDef(title: 'Bench Press', category: 'strength', emoji: '🏋️', sets: 4, reps: 8, baseXp: 130),
      WeaponExerciseDef(title: 'Overhead Press', category: 'strength', emoji: '🏋️', sets: 3, reps: 8, baseXp: 110),
      WeaponExerciseDef(title: 'Barbell Row', category: 'strength', emoji: '🏋️', sets: 4, reps: 8, baseXp: 120),
    ],
  ),
];

/// Rarity color map for UI rendering.
const Map<String, int> rarityColors = {
  'common': 0xFF8B8B8B,
  'rare': 0xFF60A5FA,
  'epic': 0xFFA78BFA,
  'legendary': 0xFFF0C850,
};

/// Rarity display names.
const Map<String, String> rarityNames = {
  'common': 'Common',
  'rare': 'Rare',
  'epic': 'Epic',
  'legendary': 'Legendary',
};
