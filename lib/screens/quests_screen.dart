import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../db/database.dart';
import '../providers/quest_provider.dart';
import '../services/haptic_service.dart';
import '../widgets/quest_card.dart';
import '../widgets/xp_toast.dart';

class QuestsScreen extends ConsumerStatefulWidget {
  const QuestsScreen({super.key});

  @override
  ConsumerState<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends ConsumerState<QuestsScreen> {
  String _filter = 'all';

  static const _filters = ['all', 'strength', 'cardio', 'flexibility', 'core'];
  static const _filterLabels = {
    'all': 'All',
    'strength': '🏋️ Strength',
    'cardio': '🏃 Cardio',
    'flexibility': '🧘 Flexibility',
    'core': '💪 Core',
  };

  @override
  Widget build(BuildContext context) {
    final questsAsync = ref.watch(dailyQuestsStreamProvider);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Quest Board',
                  style: GoogleFonts.cinzel(
                      fontWeight: FontWeight.w700, fontSize: 16)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // v2.2: Grimoire shortcut
                  TextButton(
                    onPressed: () => context.go('/grimoire'),
                    child: const Text('📖 Grimoire',
                        style: TextStyle(
                            color: QuestFitColors.purple,
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(questNotifierProvider.notifier).regenerateDaily();
                    },
                    child: const Text('🔄 Refresh',
                        style: TextStyle(
                            color: QuestFitColors.emerald,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Filter pills
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _filters.map((f) {
                final active = _filter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      HapticService.onUiTap();
                      setState(() => _filter = f);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: active
                            ? QuestFitColors.emerald.withValues(alpha: 0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: active
                                ? QuestFitColors.emerald
                                : QuestFitColors.glassBorder),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _filterLabels[f]!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: active
                              ? QuestFitColors.emerald
                              : QuestFitColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          // Quest list — live from DB
          questsAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: CircularProgressIndicator(
                    color: QuestFitColors.emerald, strokeWidth: 2),
              ),
            ),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (quests) {
              final filtered = _filter == 'all'
                  ? quests
                  : quests.where((q) => q.category == _filter).toList();

              if (filtered.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text('No quests in this category',
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                );
              }

              return Column(
                children: filtered
                    .map((quest) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: QuestCard(
                            quest: quest,
                            onComplete: () =>
                                _onQuestComplete(context, quest),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onQuestComplete(BuildContext context, Quest quest) async {
    if (quest.isCompleted) return;
    HapticService.onQuestComplete();
    final result = await ref
        .read(questNotifierProvider.notifier)
        .completeQuest(quest);
    if (!context.mounted) return;
    if (result.isPromotionReady) {
      HapticService.onLevelUp();
      LpToast.show(context, result.lpAwarded, promoted: true);
    } else {
      LpToast.show(context, result.lpAwarded);
    }
  }
}
