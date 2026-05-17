import 'package:flutter/material.dart';
import '../app/theme.dart';
import '../db/database.dart';

/// Emoji lookup based on quest category.
String questEmoji(String category) {
  switch (category) {
    case 'strength':
      return '🏋️';
    case 'cardio':
      return '🏃';
    case 'flexibility':
      return '🧘';
    case 'core':
      return '💪';
    case 'boss':
      return '⚔️';
    default:
      return '🏋️';
  }
}

/// Quest card with completion animation, haptic-ready callback.
class QuestCard extends StatefulWidget {
  final Quest quest;
  final VoidCallback? onComplete;

  const QuestCard({
    super.key,
    required this.quest,
    this.onComplete,
  });

  @override
  State<QuestCard> createState() => _QuestCardState();
}

class _QuestCardState extends State<QuestCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceCtrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.95), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.04), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.04, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _bounceCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.quest.isCompleted) return;
    _bounceCtrl.forward(from: 0);
    widget.onComplete?.call();
  }

  Color get _iconBg {
    switch (widget.quest.category) {
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
    final completed = widget.quest.isCompleted;
    final emoji = questEmoji(widget.quest.category);

    return ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedOpacity(
          opacity: completed ? 0.5 : 1.0,
          duration: const Duration(milliseconds: 250),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: completed
                  ? QuestFitColors.emerald.withValues(alpha: 0.04)
                  : QuestFitColors.bgCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: completed
                    ? QuestFitColors.emerald.withValues(alpha: 0.2)
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
                    border:
                        Border.all(color: _iconBg.withValues(alpha: 0.2)),
                  ),
                  alignment: Alignment.center,
                  child:
                      Text(emoji, style: const TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 14),
                // Body
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.quest.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          decoration: completed
                              ? TextDecoration.lineThrough
                              : null,
                          decorationColor: QuestFitColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.quest.description,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color:
                            QuestFitColors.emerald.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '+${widget.quest.lpReward} LP',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: QuestFitColors.emerald,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: completed
                            ? QuestFitColors.emerald
                            : Colors.transparent,
                        border: Border.all(
                          color: completed
                              ? QuestFitColors.emerald
                              : QuestFitColors.glassBorder,
                          width: 2,
                        ),
                      ),
                      child: completed
                          ? const Icon(Icons.check,
                              size: 14, color: QuestFitColors.bgDark)
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
