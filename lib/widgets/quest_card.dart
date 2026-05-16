import 'package:flutter/material.dart';
import '../app/theme.dart';

/// Quest card widget showing exercise, XP reward, and completion state.
class QuestCard extends StatefulWidget {
  final String emoji;
  final String title;
  final String description;
  final int xpReward;
  final String category; // strength, cardio, flexibility, core
  final bool initialCompleted;

  const QuestCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.description,
    required this.xpReward,
    required this.category,
    this.initialCompleted = false,
  });

  @override
  State<QuestCard> createState() => _QuestCardState();
}

class _QuestCardState extends State<QuestCard> {
  late bool _completed;

  @override
  void initState() {
    super.initState();
    _completed = widget.initialCompleted;
  }

  Color get _iconBg {
    switch (widget.category) {
      case 'strength':
        return QuestFitColors.redAccent;
      case 'cardio':
        return QuestFitColors.blueAccent;
      case 'flexibility':
        return QuestFitColors.purple;
      case 'core':
        return QuestFitColors.orangeAccent;
      default:
        return QuestFitColors.emerald;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _completed = !_completed),
      child: AnimatedOpacity(
        opacity: _completed ? 0.5 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: QuestFitColors.bgCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _completed
                  ? QuestFitColors.emerald.withValues(alpha: 0.15)
                  : QuestFitColors.glassBorder,
            ),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _iconBg.withValues(alpha: 0.15),
                      _iconBg.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _iconBg.withValues(alpha: 0.2)),
                ),
                alignment: Alignment.center,
                child: Text(widget.emoji, style: const TextStyle(fontSize: 20)),
              ),
              const SizedBox(width: 14),
              // Body
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        decoration:
                            _completed ? TextDecoration.lineThrough : null,
                        decorationColor: QuestFitColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Reward + checkbox
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: QuestFitColors.emerald.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '+${widget.xpReward} XP',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: QuestFitColors.emerald,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _completed ? QuestFitColors.emerald : Colors.transparent,
                      border: Border.all(
                        color: _completed
                            ? QuestFitColors.emerald
                            : QuestFitColors.glassBorder,
                        width: 2,
                      ),
                    ),
                    child: _completed
                        ? const Icon(Icons.check, size: 14, color: QuestFitColors.bgDark)
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
