import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../db/database.dart';
import '../providers/quest_provider.dart';
import '../providers/user_provider.dart';
import '../providers/rank_trial_provider.dart';
import '../services/haptic_service.dart';
import '../widgets/character_card.dart';
import '../widgets/streak_bar.dart';
import '../widgets/quest_card.dart';
import 'package:go_router/go_router.dart';
import '../widgets/xp_toast.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questsAsync = ref.watch(dailyQuestsStreamProvider);
    final completedAsync = ref.watch(completedQuestCountProvider);
    final totalAsync = ref.watch(totalQuestCountProvider);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _buildTopBar(context, ref),
          const SizedBox(height: 20),
          const CharacterCard(),
          const SizedBox(height: 16),
          // v2.0: Promotion Series banner
          _buildPromotionBanner(context, ref),
          const SizedBox(height: 16),
          const StreakBar(),
          const SizedBox(height: 24),
          _buildQuestHeader(context, ref, completedAsync, totalAsync),
          const SizedBox(height: 8),
          _buildQuestList(context, questsAsync, ref),
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
        Row(
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
              error: (_, __) => const SizedBox.shrink(),
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
          ],
        ),
      ],
    );
  }

  /// v2.0: Shows a promotion banner when XP is capped at a boundary.
  Widget _buildPromotionBanner(BuildContext context, WidgetRef ref) {
    final isAtBoundary = ref.watch(isAtPromotionBoundaryProvider);

    return isAtBoundary.when(
      data: (atBoundary) {
        if (!atBoundary) return const SizedBox.shrink();

        return GestureDetector(
          onTap: () => context.go('/rank-trial'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                QuestFitColors.gold.withValues(alpha: 0.12),
                QuestFitColors.orangeAccent.withValues(alpha: 0.08),
              ]),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: QuestFitColors.gold.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: QuestFitColors.gold.withValues(alpha: 0.2),
                  ),
                  child: const Icon(Icons.military_tech_rounded,
                      size: 20, color: QuestFitColors.gold),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PROMOTION AVAILABLE',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          color: QuestFitColors.gold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'XP is capped — pass a Rank Trial to advance!',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: QuestFitColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 14, color: QuestFitColors.gold),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildQuestHeader(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<int> completedAsync,
    AsyncValue<int> totalAsync,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text('Daily Quests',
                style: GoogleFonts.cinzel(
                    fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(width: 8),
            completedAsync.when(
              data: (done) => totalAsync.when(
                data: (total) => Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: QuestFitColors.emerald.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('$done/$total',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: QuestFitColors.emerald)),
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
        TextButton(
          onPressed: () => context.go('/quests'),
          child: const Text('View All',
              style: TextStyle(
                  color: QuestFitColors.emerald,
                  fontWeight: FontWeight.w600,
                  fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildQuestList(
      BuildContext context, AsyncValue questsAsync, WidgetRef ref) {
    return questsAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: CircularProgressIndicator(
              color: QuestFitColors.emerald, strokeWidth: 2),
        ),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (quests) => Column(
        children: (quests as List<Quest>)
            .map((quest) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: QuestCard(
                    quest: quest,
                    onComplete: () =>
                        _onQuestComplete(context, ref, quest),
                  ),
                ))
            .toList(),
      ),
    );
  }

  /// Handles quest completion with haptics + XP/Gold toast.
  Future<void> _onQuestComplete(
      BuildContext context, WidgetRef ref, Quest quest) async {
    if (quest.isCompleted) return;

    // Haptic feedback immediately
    HapticService.onQuestComplete();

    // Complete quest and get result
    final result = await ref
        .read(questNotifierProvider.notifier)
        .completeQuest(quest);

    if (!context.mounted) return;

    // Level-up haptic + toast
    if (result.didLevelUp) {
      HapticService.onLevelUp();
      XpToast.show(context, result.xpAwarded, levelUp: true);
    } else if (result.isXpCapped) {
      // v2.0: XP capped — show promotion notification
      XpToast.show(context, result.xpAwarded);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('⚔️ XP CAPPED — Promotion Trial required!'),
        backgroundColor: QuestFitColors.gold,
        duration: Duration(seconds: 3),
      ));
    } else {
      XpToast.show(context, result.xpAwarded);
    }
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
                Text('Complete all leg exercises for 3× bonus XP',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('+500 XP',
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
