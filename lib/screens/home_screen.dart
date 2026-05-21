import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../db/database.dart';
import '../providers/bounty_provider.dart';
import '../providers/health_provider.dart';
import '../providers/step_provider.dart';
import '../providers/user_provider.dart';
import '../providers/rank_trial_provider.dart';
import '../engine/rank_engine.dart';
import '../services/haptic_service.dart';
import '../widgets/character_card.dart';
import '../widgets/streak_bar.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _buildTopBar(context, ref),
          const SizedBox(height: 20),
          const CharacterCard(),
          const SizedBox(height: 12),
          // v2.2: Momentum Buff banner + Step progress
          _buildMomentumBanner(ref),
          // v2.4: Rest Buff banner (from sleep quality)
          _buildRestBuffBanner(ref),
          _buildStepProgress(context, ref),
          const SizedBox(height: 12),
          // v2.0: Promotion Series banner
          _buildPromotionBanner(context, ref),
          const SizedBox(height: 16),
          const StreakBar(),
          const SizedBox(height: 24),
          // v2.3: Active Bounty Card (replaces quest list)
          _buildBountyCard(context, ref),
          const SizedBox(height: 24),
          _buildBossRaid(context),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, WidgetRef ref) {
    final goldAsync = ref.watch(goldProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShaderMask(
          shaderCallback: goldGradientShader,
          child: Text(
            'QUESTFIT',
            style: GoogleFonts.cinzel(
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // v2.0: Gold display
                goldAsync.when(
                  data: (gold) => GestureDetector(
                    onTap: () => context.go('/shop'),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: QuestFitColors.gold.withValues(alpha: 0.1),
                    border: Border.all(
                      color: QuestFitColors.gold.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🪙', style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 4),
                      Text(
                        '$gold',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: QuestFitColors.gold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (err, _) => const Icon(Icons.error_outline, size: 16, color: Colors.redAccent),
            ),
            const SizedBox(width: 6),
            // v2.4: Aether display
            ref.watch(aetherProvider).when(
              data: (aether) => GestureDetector(
                onTap: () => context.go('/rhythm'),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: QuestFitColors.purple.withValues(alpha: 0.1),
                    border: Border.all(
                      color: QuestFitColors.purple.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🔮', style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 4),
                      Text(
                        '$aether',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: QuestFitColors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (err, _) => const Icon(Icons.error_outline, size: 16, color: Colors.redAccent),
            ),
            const SizedBox(width: 8),
            _IconButton(
              icon: Icons.notifications_outlined,
              badge: true,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No new notifications')),
                );
              },
            ),
            const SizedBox(width: 8),
            _IconButton(
              icon: Icons.settings_outlined,
              onTap: () {
                context.go('/settings');
              },
            ),
            const SizedBox(width: 8),
            // v2.2: Grimoire button
            _IconButton(
              icon: Icons.auto_stories_outlined,
              onTap: () => context.go('/grimoire'),
            ),
          ],
        ),
      ),
    ),
  ],
    );
  }

  /// v2.2: Momentum Buff banner (shown when active).
  Widget _buildMomentumBanner(WidgetRef ref) {
    final hasMomentum = ref.watch(momentumBuffProvider);
    if (!hasMomentum) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            QuestFitColors.emerald.withValues(alpha: 0.15),
            QuestFitColors.emerald.withValues(alpha: 0.05),
          ]),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: QuestFitColors.emerald.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Text('🔥', style: TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Text(
              'MOMENTUM BUFF — +10% LP & Gold today!',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: QuestFitColors.emerald),
            ),
          ],
        ),
      ),
    );
  }

  /// v2.4: Rest Buff banner (shown when sleep buff is active).
  Widget _buildRestBuffBanner(WidgetRef ref) {
    final restBuff = ref.watch(restBuffProvider);
    if (!restBuff.isActive) return const SizedBox.shrink();

    final Color accentColor;
    switch (restBuff.tier) {
      case 'well_rested':
        accentColor = QuestFitColors.purple;
        break;
      case 'rested':
        accentColor = QuestFitColors.blueAccent;
        break;
      default:
        accentColor = QuestFitColors.gold;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            accentColor.withValues(alpha: 0.15),
            accentColor.withValues(alpha: 0.05),
          ]),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accentColor.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Text(restBuff.emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Text(
              '${restBuff.label.toUpperCase()} — ${restBuff.description}',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: accentColor),
            ),
          ],
        ),
      ),
    );
  }

  /// v2.2: Compact step progress bar with expedition link.
  Widget _buildStepProgress(BuildContext context, WidgetRef ref) {
    final steps = ref.watch(todayStepsProvider);
    final goal = ref.watch(dailyStepGoalProvider);
    final progress = goal > 0 ? (steps / goal).clamp(0.0, 1.0) : 0.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: GestureDetector(
        onTap: () => context.go('/expedition'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: glassCard(borderRadius: 12),
          child: Row(
            children: [
              const Text('👟', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$steps / $goal steps',
                          style: const TextStyle(
                              color: QuestFitColors.textSecondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${(progress * 100).toInt()}%',
                          style: const TextStyle(
                              color: QuestFitColors.emerald,
                              fontSize: 11,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 4,
                        backgroundColor: QuestFitColors.glassBorder,
                        color: QuestFitColors.emerald,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right_rounded,
                  color: QuestFitColors.textMuted, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  /// v3.0: Shows a promotion banner when LP reaches 100.
  /// Tapping navigates to the Rank Trial screen to view tier progress.
  /// Promotion is processed automatically on next app launch (anti-addiction).
  Widget _buildPromotionBanner(BuildContext context, WidgetRef ref) {
    final isPending = ref.watch(isPromotionPendingProvider);
    final nextRank = ref.watch(nextRankProvider);

    return isPending.when(
      data: (pending) {
        if (!pending) return const SizedBox.shrink();

        final next = nextRank.valueOrNull;
        final nextTierInfo = next != null
            ? RankEngine.getTierInfo(next.tier, next.division)
            : null;
        final nextName = nextTierInfo?.fullName ?? 'Next Division';

        return GestureDetector(
          onTap: () {
            HapticService.onQuestComplete();
            context.push('/rank-trial');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                QuestFitColors.gold.withValues(alpha: 0.18),
                QuestFitColors.orangeAccent.withValues(alpha: 0.12),
              ]),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: QuestFitColors.gold.withValues(alpha: 0.4),
              ),
              boxShadow: [
                BoxShadow(
                  color: QuestFitColors.gold.withValues(alpha: 0.15),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      QuestFitColors.gold.withValues(alpha: 0.3),
                      QuestFitColors.orangeAccent.withValues(alpha: 0.2),
                    ]),
                  ),
                  child: const Icon(Icons.military_tech_rounded,
                      size: 22, color: QuestFitColors.gold),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '⚡ PROMOTION READY',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: QuestFitColors.gold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'You\'ll advance to $nextName on next login!',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: QuestFitColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    size: 22, color: QuestFitColors.gold),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (err, _) => const Center(child: Icon(Icons.error_outline, color: Colors.redAccent)),
    );
  }

  /// v2.3: Bounty card on home screen — shows today's active bounty status.
  Widget _buildBountyCard(BuildContext context, WidgetRef ref) {
    final bountyAsync = ref.watch(activeBountyProvider);

    return bountyAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (err, _) => const Center(child: Icon(Icons.error_outline, color: Colors.redAccent)),
      data: (bounty) {
        if (bounty == null) {
          return _buildNoBountyCard(context);
        }

        switch (bounty.status) {
          case 'drafting':
            return _buildDraftingCard(context);
          case 'combat':
          case 'preparing':
            return _buildCombatCard(context, ref, bounty);
          case 'victory':
            return _buildResultCard(context, '⚔️ VICTORY!', QuestFitColors.gold,
                'Your bounty has been slain. Well fought, warrior.');
          case 'defeat':
            return _buildResultCard(context, '💀 DEFEAT', const Color(0xFFFF4444),
                'Your enemy survived. Train harder tomorrow.');
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildNoBountyCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/bounty'),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            QuestFitColors.emerald.withValues(alpha: 0.1),
            QuestFitColors.gold.withValues(alpha: 0.05),
          ]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: QuestFitColors.emerald.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            const Text('🎯', style: TextStyle(fontSize: 32)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Draft Your Bounty!',
                      style: GoogleFonts.cinzel(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: QuestFitColors.textPrimary)),
                  const SizedBox(height: 2),
                  Text('Choose an enemy to hunt today',
                      style: GoogleFonts.inter(
                          fontSize: 12, color: QuestFitColors.textSecondary)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: QuestFitColors.emerald),
          ],
        ),
      ),
    );
  }

  Widget _buildDraftingCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/bounty'),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xFFF0C850).withValues(alpha: 0.1),
            QuestFitColors.bgCard,
          ]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF0C850).withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            const Text('⚔️', style: TextStyle(fontSize: 32)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bounty Draft Active',
                      style: GoogleFonts.cinzel(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: QuestFitColors.gold)),
                  const SizedBox(height: 2),
                  Text('3 enemies await your choice',
                      style: GoogleFonts.inter(
                          fontSize: 12, color: QuestFitColors.textSecondary)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: QuestFitColors.gold),
          ],
        ),
      ),
    );
  }

  Widget _buildCombatCard(BuildContext context, WidgetRef ref, Bounty bounty) {
    final hpPercent = ref.watch(enemyHpPercentProvider);
    final enemyAsync = ref.watch(activeEnemyProvider);

    return GestureDetector(
      onTap: () => context.go('/bounty'),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xFFFF6B35).withValues(alpha: 0.08),
            QuestFitColors.bgCard,
          ]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFFF6B35).withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🎯', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Active Hunt',
                          style: GoogleFonts.cinzel(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: QuestFitColors.textPrimary)),
                      enemyAsync.when(
                        data: (enemy) => Text(
                          enemy?.name ?? 'Unknown',
                          style: GoogleFonts.inter(
                              fontSize: 12, color: QuestFitColors.textSecondary),
                        ),
                        loading: () => const SizedBox.shrink(),
                        error: (err, _) => const Center(child: Icon(Icons.error_outline, color: Colors.redAccent)),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${(hpPercent * 100).round()}%',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: hpPercent > 0.35 ? QuestFitColors.emerald : const Color(0xFFFF4444)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: hpPercent,
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                  hpPercent > 0.6
                      ? QuestFitColors.emerald
                      : hpPercent > 0.35
                          ? const Color(0xFFF0C850)
                          : const Color(0xFFFF4444),
                ),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, String title, Color color, String subtitle) {
    return GestureDetector(
      onTap: () => context.go('/bounty'),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.cinzel(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: color)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: GoogleFonts.inter(
                          fontSize: 12, color: QuestFitColors.textSecondary)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: QuestFitColors.textMuted),
          ],
        ),
      ),
    );
  }

  Widget _buildBossRaid(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          QuestFitColors.purple.withValues(alpha: 0.12),
          QuestFitColors.blueAccent.withValues(alpha: 0.08),
        ]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: QuestFitColors.purple.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Text('⚔️', style: TextStyle(fontSize: 26)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Boss Raid: Leg Day Annihilation',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: QuestFitColors.purple)),
                const SizedBox(height: 2),
                Text('Complete all leg exercises for 3× bonus LP',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('+24 LP',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      color: QuestFitColors.gold)),
              const SizedBox(height: 2),
              Text('+🪙 250',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      color: QuestFitColors.gold.withValues(alpha: 0.7))),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final bool badge;
  final VoidCallback? onTap;
  const _IconButton({required this.icon, this.badge = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: QuestFitColors.bgCard,
          border: Border.all(color: QuestFitColors.glassBorder),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, size: 20, color: QuestFitColors.textSecondary),
            if (badge)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: QuestFitColors.redAccent,
                    boxShadow: [
                      BoxShadow(
                          color: QuestFitColors.redAccent, blurRadius: 6),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
