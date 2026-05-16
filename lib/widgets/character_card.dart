import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/theme.dart';
import '../providers/user_provider.dart';
import 'xp_bar.dart';

/// Character dashboard card showing avatar, rank, XP bar, and stat chips.
class CharacterCard extends ConsumerWidget {
  const CharacterCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerAsync = ref.watch(playerStreamProvider);
    final statsAsync = ref.watch(statsStreamProvider);
    final xpAsync = ref.watch(xpProgressProvider);
    final rankAsync = ref.watch(rankInfoProvider);

    return playerAsync.when(
      loading: () => const _CardShimmer(),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (player) {
        final stats = statsAsync.valueOrNull;
        final xp = xpAsync.valueOrNull;
        final rank = rankAsync.valueOrNull;

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
                      border: Border.all(
                        color: rank?.color ?? QuestFitColors.goldDim,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (rank?.color ?? QuestFitColors.gold)
                              .withValues(alpha: 0.15),
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
                                colors: [
                                  QuestFitColors.gold,
                                  Color(0xFFD4A830),
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                            ),
                            child: Text(
                              'LV ${player.level}',
                              style: const TextStyle(
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
                        Text(player.name,
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 2),
                        Text(
                          '${_capitalize(player.classType)} · ${_classPath(player.classType)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 10),
                        // Rank badge
                        Container(
                          padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                (rank?.color ?? QuestFitColors.emerald)
                                    .withValues(alpha: 0.12),
                                (rank?.color ?? QuestFitColors.emerald)
                                    .withValues(alpha: 0.04),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: (rank?.color ?? QuestFitColors.emerald)
                                  .withValues(alpha: 0.2),
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
                              Text(
                                rank?.fullName.toUpperCase() ?? 'IRON I',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      rank?.color ?? QuestFitColors.emerald,
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
              XpBar(
                current: xp?.current ?? 0,
                max: xp?.max ?? 100,
              ),
              const SizedBox(height: 14),
              // Stat chips
              Row(
                children: [
                  Expanded(
                    child: _StatChip(
                      value: '${stats?.str ?? 0}',
                      label: 'STR',
                      color: QuestFitColors.redAccent,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _StatChip(
                      value: '${stats?.end ?? 0}',
                      label: 'END',
                      color: QuestFitColors.blueAccent,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _StatChip(
                      value: '${stats?.agi ?? 0}',
                      label: 'AGI',
                      color: QuestFitColors.orangeAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static String _capitalize(String s) =>
      s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

  static String _classPath(String classType) {
    switch (classType) {
      case 'berserker':
        return 'Strength Path';
      case 'ranger':
        return 'Cardio Path';
      case 'monk':
        return 'Flexibility Path';
      default:
        return 'Strength Path';
    }
  }
}

/// Loading shimmer placeholder for the card.
class _CardShimmer extends StatelessWidget {
  const _CardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: glassCard(),
      child: const Center(
        child: CircularProgressIndicator(
          color: QuestFitColors.emerald,
          strokeWidth: 2,
        ),
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
