import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../db/database.dart';
import '../providers/quest_provider.dart';
import '../services/haptic_service.dart';
import '../widgets/character_card.dart';
import '../widgets/streak_bar.dart';
import '../widgets/quest_card.dart';
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
          _buildTopBar(),
          const SizedBox(height: 20),
          const CharacterCard(),
          const SizedBox(height: 24),
          const StreakBar(),
          const SizedBox(height: 24),
          _buildQuestHeader(completedAsync, totalAsync),
          const SizedBox(height: 8),
          _buildQuestList(context, questsAsync, ref),
          const SizedBox(height: 24),
          _buildBossRaid(context),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
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
          children: [
            _IconButton(icon: Icons.notifications_outlined, badge: true),
            const SizedBox(width: 8),
            _IconButton(icon: Icons.settings_outlined),
          ],
        ),
      ],
    );
  }

  Widget _buildQuestHeader(
      AsyncValue<int> completedAsync, AsyncValue<int> totalAsync) {
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
          onPressed: () {},
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

  /// Handles quest completion with haptics + XP toast.
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
          const Text('+500 XP',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  color: QuestFitColors.gold)),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final bool badge;
  const _IconButton({required this.icon, this.badge = false});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
