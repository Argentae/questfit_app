/// QuestFit Health Connect → LP Converter.
/// Converts raw Health Connect workout data into QuestFit LP and quest records.
///
/// v3.0: Awards LP instead of XP. Health workouts give 3–8 base LP.
class HealthLpConverter {
  const HealthLpConverter._();

  /// Convert a Health Connect workout into a QuestFit LP award.
  ///
  /// [workoutType] should be a string like 'WEIGHT_TRAINING', 'RUNNING', etc.
  /// [durationMinutes] is the workout duration in minutes.
  /// [caloriesBurned] is optional active calories from the session.
  /// [tierIndex] is the current tier index for LP scaling.
  static HealthLpResult convert({
    required String workoutType,
    required int durationMinutes,
    required int tierIndex,
    int? caloriesBurned,
  }) {
    final mapping = _typeMapping(workoutType);

    // Base LP from duration: longer workouts = more LP, capped
    var lp = (durationMinutes * mapping.lpPerMinute / 10).round().clamp(3, 12);

    // Calorie bonus: +1 LP per 100 kcal
    if (caloriesBurned != null && caloriesBurned > 0) {
      lp += (caloriesBurned / 100).floor().clamp(0, 5);
    }

    // Slight tier bonus
    lp += (tierIndex ~/ 3);

    return HealthLpResult(
      lpAwarded: lp.clamp(3, 15),
      category: mapping.category,
      questTitle: '${mapping.label} (Watch)',
      questDescription: '$durationMinutes min · Auto-imported',
      emoji: mapping.emoji,
    );
  }

  /// Convert daily steps into bonus LP (threshold: ≥ 8,000 steps).
  static HealthLpResult? convertSteps({
    required int totalSteps,
    required int tierIndex,
  }) {
    if (totalSteps < 8000) return null;

    // Steps give a flat 5 LP base
    final lp = 5 + (tierIndex ~/ 3);

    return HealthLpResult(
      lpAwarded: lp.clamp(5, 10),
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
      return const _WorkoutMapping('strength', 3, 'Weight Training', '🏋️');
    }

    // Cardio types
    if (t.contains('RUNNING') || t.contains('CYCLING') ||
        t.contains('SWIMMING') || t.contains('ROWING') ||
        t.contains('ELLIPTICAL') || t.contains('STAIR') ||
        t.contains('HIIT') || t.contains('AEROBIC')) {
      return const _WorkoutMapping('cardio', 2, 'Cardio Session', '🏃');
    }

    // Flexibility types
    if (t.contains('YOGA') || t.contains('STRETCHING') ||
        t.contains('PILATES') || t.contains('FLEXIBILITY')) {
      return const _WorkoutMapping('flexibility', 2, 'Flexibility Session', '🧘');
    }

    // Default: general exercise → cardio
    return const _WorkoutMapping('cardio', 2, 'Exercise Session', '🏃');
  }

  static String _formatSteps(int steps) {
    if (steps >= 1000) return '${(steps / 1000).toStringAsFixed(1)}k';
    return steps.toString();
  }
}

class HealthLpResult {
  final int lpAwarded;
  final String category;
  final String questTitle;
  final String questDescription;
  final String emoji;

  const HealthLpResult({
    required this.lpAwarded,
    required this.category,
    required this.questTitle,
    required this.questDescription,
    required this.emoji,
  });
}

class _WorkoutMapping {
  final String category;
  final int lpPerMinute; // Scaled down from XP: used as lp per 10 min
  final String label;
  final String emoji;

  const _WorkoutMapping(this.category, this.lpPerMinute, this.label, this.emoji);
}
