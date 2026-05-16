/// QuestFit curated exercise library — 40 exercises across 4 categories.
class ExerciseDef {
  final String title;
  final String emoji;
  final int? sets;
  final int? reps;
  final int? duration; // minutes
  final int baseXp;

  const ExerciseDef({
    required this.title,
    required this.emoji,
    this.sets,
    this.reps,
    this.duration,
    required this.baseXp,
  });
}

const Map<String, List<ExerciseDef>> exerciseLibrary = {
  'strength': [
    ExerciseDef(title: 'Barbell Squats',    emoji: '🏋️', sets: 3, reps: 10, baseXp: 120),
    ExerciseDef(title: 'Bench Press',       emoji: '🏋️', sets: 4, reps: 8,  baseXp: 130),
    ExerciseDef(title: 'Deadlift',          emoji: '🏋️', sets: 3, reps: 5,  baseXp: 150),
    ExerciseDef(title: 'Overhead Press',    emoji: '🏋️', sets: 3, reps: 8,  baseXp: 110),
    ExerciseDef(title: 'Barbell Row',       emoji: '🏋️', sets: 4, reps: 8,  baseXp: 120),
    ExerciseDef(title: 'Dumbbell Curl',     emoji: '🏋️', sets: 3, reps: 12, baseXp: 70),
    ExerciseDef(title: 'Tricep Dips',       emoji: '🏋️', sets: 3, reps: 10, baseXp: 80),
    ExerciseDef(title: 'Leg Press',         emoji: '🏋️', sets: 4, reps: 10, baseXp: 100),
    ExerciseDef(title: 'Lat Pulldown',      emoji: '🏋️', sets: 3, reps: 10, baseXp: 90),
    ExerciseDef(title: 'Shoulder Shrugs',   emoji: '🏋️', sets: 4, reps: 12, baseXp: 60),
  ],
  'cardio': [
    ExerciseDef(title: 'Treadmill Sprint',    emoji: '🏃', duration: 15, baseXp: 90),
    ExerciseDef(title: 'Rowing Machine',      emoji: '🚣', duration: 20, baseXp: 100),
    ExerciseDef(title: 'Jump Rope',           emoji: '🏃', duration: 10, baseXp: 80),
    ExerciseDef(title: 'Cycling',             emoji: '🚴', duration: 30, baseXp: 120),
    ExerciseDef(title: 'Stair Climber',       emoji: '🏃', duration: 15, baseXp: 95),
    ExerciseDef(title: 'Swimming Laps',       emoji: '🏊', duration: 20, baseXp: 110),
    ExerciseDef(title: 'Battle Ropes',        emoji: '🏃', duration: 8,  baseXp: 85),
    ExerciseDef(title: 'Elliptical Trainer',  emoji: '🏃', duration: 25, baseXp: 90),
    ExerciseDef(title: 'Box Jumps',           emoji: '🏃', sets: 4, reps: 10, baseXp: 95),
    ExerciseDef(title: 'Burpees',             emoji: '🏃', sets: 3, reps: 15, baseXp: 100),
  ],
  'flexibility': [
    ExerciseDef(title: 'Hip Mobility Flow',    emoji: '🧘', duration: 10, baseXp: 50),
    ExerciseDef(title: 'Yoga Sun Salutation',  emoji: '🧘', duration: 15, baseXp: 65),
    ExerciseDef(title: 'Hamstring Stretch',    emoji: '🧘', duration: 8,  baseXp: 40),
    ExerciseDef(title: 'Shoulder Mobility',    emoji: '🧘', duration: 10, baseXp: 45),
    ExerciseDef(title: 'Foam Rolling',         emoji: '🧘', duration: 15, baseXp: 55),
    ExerciseDef(title: 'Dynamic Warm-Up',      emoji: '🧘', duration: 10, baseXp: 45),
    ExerciseDef(title: 'Pigeon Pose Hold',     emoji: '🧘', duration: 5,  baseXp: 35),
    ExerciseDef(title: 'Cat-Cow Stretch',      emoji: '🧘', duration: 5,  baseXp: 30),
    ExerciseDef(title: 'Full Body Stretch',    emoji: '🧘', duration: 20, baseXp: 70),
    ExerciseDef(title: 'Ankle Mobility',       emoji: '🧘', duration: 5,  baseXp: 30),
  ],
  'core': [
    ExerciseDef(title: 'Plank Challenge',      emoji: '💪', sets: 3, duration: 1, baseXp: 75),
    ExerciseDef(title: 'Ab Wheel Rollout',     emoji: '💪', sets: 3, reps: 12,   baseXp: 85),
    ExerciseDef(title: 'Russian Twists',       emoji: '💪', sets: 3, reps: 20,   baseXp: 70),
    ExerciseDef(title: 'Hanging Leg Raise',    emoji: '💪', sets: 3, reps: 10,   baseXp: 90),
    ExerciseDef(title: 'Dead Bug',             emoji: '💪', sets: 3, reps: 12,   baseXp: 60),
    ExerciseDef(title: 'Cable Woodchop',       emoji: '💪', sets: 3, reps: 12,   baseXp: 75),
    ExerciseDef(title: 'Mountain Climbers',    emoji: '💪', sets: 3, reps: 20,   baseXp: 80),
    ExerciseDef(title: 'Dragon Flag',          emoji: '💪', sets: 3, reps: 5,    baseXp: 100),
    ExerciseDef(title: 'Pallof Press',         emoji: '💪', sets: 3, reps: 10,   baseXp: 65),
    ExerciseDef(title: 'Side Plank',           emoji: '💪', sets: 2, duration: 1, baseXp: 55),
  ],
};
