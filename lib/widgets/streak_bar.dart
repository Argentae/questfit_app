import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/theme.dart';
import '../engine/streak_engine.dart';
import '../providers/user_provider.dart';

/// Streak tracker bar with weekly day dots — live from DB.
class StreakBar extends ConsumerWidget {
  const StreakBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(streakStreamProvider);

    return streakAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, _) => const SizedBox.shrink(),
      data: (streak) {
        final weekDays = StreakEngine.getWeekView(
          currentStreak: streak.currentStreak,
          lastActiveDate: streak.lastActiveDate,
        );

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: glassCard(borderRadius: 20),
          child: Row(
            children: [
              const Text('🔥', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 6),
              Text('${streak.currentStreak}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: QuestFitColors.orangeAccent)),
              const SizedBox(width: 6),
              Flexible(
                child: Text('day streak',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: weekDays.map((day) {
                  final isDone = day.status == 'done';
                  final isToday = day.status == 'today';
                  return Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone
                            ? QuestFitColors.emerald.withValues(alpha: 0.15)
                            : Colors.transparent,
                        border: Border.all(
                          color: isDone
                              ? QuestFitColors.emerald
                              : isToday
                                  ? QuestFitColors.gold
                                  : QuestFitColors.glassBorder,
                          width: 1.5,
                        ),
                        boxShadow: isToday
                            ? [
                                BoxShadow(
                                  color: QuestFitColors.gold
                                      .withValues(alpha: 0.2),
                                  blurRadius: 8,
                                )
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        day.label,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: isDone
                              ? QuestFitColors.emerald
                              : isToday
                                  ? QuestFitColors.gold
                                  : QuestFitColors.textMuted,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
