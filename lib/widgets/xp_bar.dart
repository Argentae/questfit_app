import 'package:flutter/material.dart';
import '../app/theme.dart';

/// XP progress bar with animated fill and glow shimmer.
class XpBar extends StatelessWidget {
  final int current;
  final int max;

  const XpBar({super.key, required this.current, required this.max});

  double get _percentage => max > 0 ? (current / max).clamp(0.0, 1.0) : 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EXPERIENCE',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Text(
              '${_formatNumber(current)} / ${_formatNumber(max)} XP',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: QuestFitColors.emerald,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 10,
            child: Stack(
              children: [
                // Track
                Container(
                  decoration: BoxDecoration(
                    color: QuestFitColors.emerald.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Fill
                FractionallySizedBox(
                  widthFactor: _percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          QuestFitColors.emerald,
                          Color(0xFF34D8B4),
                          Color(0xFF6EE7C2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: QuestFitColors.emerald.withValues(alpha: 0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}k';
    return n.toString();
  }
}
