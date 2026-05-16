import 'package:flutter/material.dart';
import '../app/theme.dart';

/// Streak tracker bar with weekly day dots.
class StreakBar extends StatelessWidget {
  const StreakBar({super.key});

  @override
  Widget build(BuildContext context) {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final statuses = ['done', 'done', 'done', 'today', '', '', ''];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: glassCard(borderRadius: 20),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 6),
          const Text('12',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: QuestFitColors.orangeAccent)),
          const SizedBox(width: 6),
          Text('day streak',
              style: Theme.of(context).textTheme.bodySmall),
          const Spacer(),
          Row(
            children: List.generate(7, (i) {
              final status = statuses[i];
              final isDone = status == 'done';
              final isToday = status == 'today';
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
                              color: QuestFitColors.gold.withValues(alpha: 0.2),
                              blurRadius: 8,
                            )
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    days[i],
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
            }),
          ),
        ],
      ),
    );
  }
}
