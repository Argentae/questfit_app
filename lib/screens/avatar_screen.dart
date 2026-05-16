import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../providers/user_provider.dart';
import '../widgets/xp_bar.dart';

class AvatarScreen extends ConsumerWidget {
  const AvatarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerAsync = ref.watch(playerStreamProvider);
    final statsAsync = ref.watch(statsStreamProvider);
    final xpAsync = ref.watch(xpProgressProvider);
    final rankAsync = ref.watch(rankInfoProvider);

    return playerAsync.when(
      loading: () => const Center(
          child: CircularProgressIndicator(
              color: QuestFitColors.emerald, strokeWidth: 2)),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (player) {
        final stats = statsAsync.valueOrNull;
        final xp = xpAsync.valueOrNull;
        final rank = rankAsync.valueOrNull;

        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              // Hero avatar
              Center(
                child: Column(children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 140, height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: rank?.color ?? QuestFitColors.goldDim,
                          width: 3),
                      boxShadow: [
                        BoxShadow(
                            color: (rank?.color ?? QuestFitColors.gold)
                                .withValues(alpha: 0.2),
                            blurRadius: 40)
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(21),
                      child: Image.asset('assets/images/avatar.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(player.name,
                      style: GoogleFonts.cinzel(
                          fontWeight: FontWeight.w900, fontSize: 22)),
                  const SizedBox(height: 4),
                  Text(
                    '${_capitalize(player.classType)} · ${_classPath(player.classType)} · Level ${player.level}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),
                ]),
              ),
              // Rank display
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                decoration: glassCard(borderRadius: 20),
                child: Row(children: [
                  ClipOval(
                      child: Image.asset('assets/images/rank_emblem.png',
                          width: 40, height: 40, fit: BoxFit.cover)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rank?.fullName ?? 'Iron I',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: rank?.color ??
                                    QuestFitColors.emerald),
                          ),
                          Text(
                            'Total XP: ${player.totalXp}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: QuestFitColors.textMuted),
                          ),
                        ]),
                  ),
                ]),
              ),
              const SizedBox(height: 20),
              // XP
              Container(
                padding: const EdgeInsets.all(16),
                decoration: glassCard(),
                child: XpBar(
                    current: xp?.current ?? 0,
                    max: xp?.max ?? 100),
              ),
              const SizedBox(height: 24),
              // Stats
              Text('Stats',
                  style: GoogleFonts.cinzel(
                      fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: glassCard(),
                child: Column(children: [
                  _StatBarRow(
                      label: 'STR',
                      value: stats?.str ?? 0,
                      color: QuestFitColors.redAccent),
                  const SizedBox(height: 14),
                  _StatBarRow(
                      label: 'END',
                      value: stats?.end ?? 0,
                      color: QuestFitColors.blueAccent),
                  const SizedBox(height: 14),
                  _StatBarRow(
                      label: 'AGI',
                      value: stats?.agi ?? 0,
                      color: QuestFitColors.orangeAccent),
                ]),
              ),
              const SizedBox(height: 24),
              // Equipment
              Text('Equipment',
                  style: GoogleFonts.cinzel(
                      fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: glassCard(),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: const [
                    _EquipSlot(emoji: '⚔️', label: 'Weapon'),
                    _EquipSlot(emoji: '🛡️', label: 'Shield'),
                    _EquipSlot(emoji: '👑', label: 'Helm'),
                    _EquipSlot(emoji: '🧥', label: 'Armor'),
                    _EquipSlot(emoji: '🥾', label: 'Boots'),
                    _EquipSlot(emoji: '💍', label: 'Ring'),
                  ],
                ),
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

class _StatBarRow extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  const _StatBarRow(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
          width: 36,
          child: Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                  letterSpacing: 1))),
      const SizedBox(width: 12),
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 8,
            child: Stack(children: [
              Container(
                  color: Colors.white.withValues(alpha: 0.05)),
              FractionallySizedBox(
                widthFactor: (value / 100).clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      color,
                      color.withValues(alpha: 0.6)
                    ]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
      const SizedBox(width: 12),
      SizedBox(
          width: 32,
          child: Text('$value',
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: QuestFitColors.textPrimary))),
    ]);
  }
}

class _EquipSlot extends StatelessWidget {
  final String emoji;
  final String label;
  const _EquipSlot({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: QuestFitColors.glassBorder,
            style: BorderStyle.solid),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white.withValues(alpha: 0.4))),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(
                    fontSize: 9, color: QuestFitColors.textMuted)),
          ]),
    );
  }
}
