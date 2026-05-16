/// QuestFit Streak System.
/// Tracks consecutive active days with XP multiplier bonus (max +30% at 30 days).
class StreakEngine {
  const StreakEngine._();

  static const _dayNames = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  static String _todayStr() => DateTime.now().toIso8601String().split('T')[0];

  /// Check in for today — returns updated streak data.
  static StreakUpdate checkIn({
    required int currentStreak,
    required int longestStreak,
    required String? lastActiveDate,
  }) {
    final today = _todayStr();

    if (lastActiveDate == today) {
      // Already checked in
      return StreakUpdate(
        currentStreak: currentStreak,
        longestStreak: longestStreak,
        lastActiveDate: today,
        didChange: false,
      );
    }

    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final yesterdayStr = yesterday.toIso8601String().split('T')[0];

    int newStreak;
    if (lastActiveDate == yesterdayStr) {
      newStreak = currentStreak + 1; // Consecutive
    } else if (lastActiveDate == null) {
      newStreak = 1; // First ever
    } else {
      newStreak = 1; // Streak broken
    }

    return StreakUpdate(
      currentStreak: newStreak,
      longestStreak: newStreak > longestStreak ? newStreak : longestStreak,
      lastActiveDate: today,
      didChange: true,
    );
  }

  /// Streak XP multiplier: 1.0 + min(streak, 30) × 0.01 → max 1.30.
  static double getMultiplier(int currentStreak) {
    return 1.0 + (currentStreak.clamp(0, 30) * 0.01);
  }

  /// Get 7-day week view for the streak bar.
  static List<StreakDay> getWeekView({
    required int currentStreak,
    required String? lastActiveDate,
  }) {
    final today = DateTime.now();
    final dayOfWeek = today.weekday; // 1=Mon, 7=Sun
    final monday = today.subtract(Duration(days: dayOfWeek - 1));
    final todayStr = _todayStr();

    return List.generate(7, (i) {
      final d = monday.add(Duration(days: i));
      final dateStr = d.toIso8601String().split('T')[0];

      String status;
      if (dateStr == todayStr) {
        status = 'today';
      } else if (dateStr.compareTo(todayStr) < 0 && currentStreak > 0) {
        final daysAgo = today.difference(d).inDays;
        if (daysAgo <= currentStreak &&
            lastActiveDate != null &&
            lastActiveDate.compareTo(dateStr) >= 0) {
          status = 'done';
        } else {
          status = 'upcoming';
        }
      } else {
        status = 'upcoming';
      }

      return StreakDay(
        label: _dayNames[i],
        status: status,
        date: dateStr,
      );
    });
  }
}

class StreakUpdate {
  final int currentStreak;
  final int longestStreak;
  final String lastActiveDate;
  final bool didChange;

  const StreakUpdate({
    required this.currentStreak,
    required this.longestStreak,
    required this.lastActiveDate,
    required this.didChange,
  });
}

class StreakDay {
  final String label;
  final String status; // 'done', 'today', 'upcoming'
  final String date;

  const StreakDay({
    required this.label,
    required this.status,
    required this.date,
  });
}
