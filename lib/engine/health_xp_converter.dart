/// QuestFit Health Connect → XP Converter.
/// Converts raw Health Connect workout data into QuestFit XP and quest records.
class HealthXpConverter {
  const HealthXpConverter._();

  /// Convert a Health Connect workout into a QuestFit XP award.
  ///
  /// [workoutType] should be a string like 'WEIGHT_TRAINING', 'RUNNING', etc.
  /// [durationMinutes] is the workout duration in minutes.
  /// [caloriesBurned] is optional active calories from the session.
  /// [playerLevel] is the current player level for XP scaling.
  static HealthXpResult convert({
    required String workoutType,
    required int durationMinutes,
    required int playerLevel,
    int? caloriesBurned,
  }) {
    final levelScale = 1.0 + (playerLevel * 0.02);
    final mapping = _typeMapping(workoutType);

    // Base XP from duration × rate × level scale
    var xp = (durationMinutes * mapping.xpPerMinute * levelScale).round();

    // Calorie bonus: +1 XP per 10 kcal
    if (caloriesBurned != null && caloriesBurned > 0) {
      xp += (caloriesBurned / 10).floor();
    }

    return HealthXpResult(
      xpAwarded: xp,
      category: mapping.category,
      questTitle: '${mapping.label} (Watch)',
      questDescription: '$durationMinutes min · Auto-imported',
      emoji: mapping.emoji,
    );
  }

  /// Convert daily steps into bonus XP (threshold: ≥ 8,000 steps).
  static HealthXpResult? convertSteps({
    required int totalSteps,
    required int playerLevel,
  }) {
    if (totalSteps < 8000) return null;

    final levelScale = 1.0 + (playerLevel * 0.02);
    final xp = (50 * levelScale).round();

    return HealthXpResult(
      xpAwarded: xp,
      category: 'cardio',
      questTitle: 'Daily Walk Quest',
      questDescription: '${_formatSteps(totalSteps)} steps · Auto-imported',
      emoji: '🚶',
    );
  }

  static _WorkoutMapping _typeMapping(String type) {
    final t = type.toUpperCase();

    // Strength types
    if (t.contains('WEIGHT') || t.contains('STRENGTH') ||
        t.contains('CALISTHENICS') || t.contains('FUNCTIONAL')) {
      return const _WorkoutMapping('strength', 8, 'Weight Training', '🏋️');
    }

    // Cardio types
    if (t.contains('RUNNING') || t.contains('CYCLING') ||
        t.contains('SWIMMING') || t.contains('ROWING') ||
        t.contains('ELLIPTICAL') || t.contains('STAIR') ||
        t.contains('HIIT') || t.contains('AEROBIC')) {
      return const _WorkoutMapping('cardio', 6, 'Cardio Session', '🏃');
    }

    // Flexibility types
    if (t.contains('YOGA') || t.contains('STRETCHING') ||
        t.contains('PILATES') || t.contains('FLEXIBILITY')) {
      return const _WorkoutMapping('flexibility', 5, 'Flexibility Session', '🧘');
    }

    // Default: general exercise → cardio
    return const _WorkoutMapping('cardio', 5, 'Exercise Session', '🏃');
  }

  static String _formatSteps(int steps) {
    if (steps >= 1000) return '${(steps / 1000).toStringAsFixed(1)}k';
    return steps.toString();
  }
}

class HealthXpResult {
  final int xpAwarded;
  final String category;
  final String questTitle;
  final String questDescription;
  final String emoji;

  const HealthXpResult({
    required this.xpAwarded,
    required this.category,
    required this.questTitle,
    required this.questDescription,
    required this.emoji,
  });
}

class _WorkoutMapping {
  final String category;
  final int xpPerMinute;
  final String label;
  final String emoji;

  const _WorkoutMapping(this.category, this.xpPerMinute, this.label, this.emoji);
}
