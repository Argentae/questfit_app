import 'package:flutter/material.dart';
import '../app/theme.dart';
import 'xp_bar.dart';

/// Character dashboard card showing avatar, rank, XP bar, and stat chips.
class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: glassCard(),
      child: Column(
        children: [
          // Top row: avatar + info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar frame
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: QuestFitColors.goldDim, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: QuestFitColors.gold.withValues(alpha: 0.15),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    // Level badge
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [QuestFitColors.gold, Color(0xFFD4A830)],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'LV 27',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1200),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Character info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('IronLift_Agus',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 2),
                    Text('Berserker · Strength Path',
                        style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 10),
                    // Rank badge
                    Container(
                      padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            QuestFitColors.emerald.withValues(alpha: 0.12),
                            QuestFitColors.emerald.withValues(alpha: 0.04),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: QuestFitColors.emerald.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/rank_emblem.png',
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'ESMERALDA IV',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: QuestFitColors.emerald,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // XP Bar
          const XpBar(current: 6820, max: 10000),
          const SizedBox(height: 14),
          // Stat chips
          const Row(
            children: [
              Expanded(child: _StatChip(value: '74', label: 'STR', color: QuestFitColors.redAccent)),
              SizedBox(width: 8),
              Expanded(child: _StatChip(value: '58', label: 'END', color: QuestFitColors.blueAccent)),
              SizedBox(width: 8),
              Expanded(child: _StatChip(value: '41', label: 'AGI', color: QuestFitColors.orangeAccent)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatChip({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: QuestFitColors.glassBorder),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 2),
          Text(label,
              style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}
