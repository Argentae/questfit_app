import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../widgets/quest_card.dart';

class QuestsScreen extends StatefulWidget {
  const QuestsScreen({super.key});

  @override
  State<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
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
              TextButton(
                onPressed: () {},
                child: const Text('+ New Quest',
                    style: TextStyle(
                        color: QuestFitColors.emerald,
                        fontWeight: FontWeight.w600)),
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
                    onTap: () => setState(() => _filter = f),
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
          // Quest list
          ..._buildQuestList(),
        ],
      ),
    );
  }

  List<Widget> _buildQuestList() {
    const quests = [
      {'emoji': '🏋️', 'title': 'Bench Press', 'desc': '4 sets × 8 reps · 70 kg', 'xp': 130, 'cat': 'strength'},
      {'emoji': '🏋️', 'title': 'Deadlift', 'desc': '3 sets × 5 reps · 120 kg', 'xp': 150, 'cat': 'strength'},
      {'emoji': '🚣', 'title': 'Rowing Machine', 'desc': '20 min · steady state', 'xp': 100, 'cat': 'cardio'},
      {'emoji': '🧘', 'title': 'Yoga Sun Salutation', 'desc': '15 min flow routine', 'xp': 65, 'cat': 'flexibility'},
      {'emoji': '💪', 'title': 'Ab Wheel Rollout', 'desc': '3 sets × 12 reps', 'xp': 85, 'cat': 'core'},
    ];

    return quests
        .where((q) => _filter == 'all' || q['cat'] == _filter)
        .map((q) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: QuestCard(
                emoji: q['emoji'] as String,
                title: q['title'] as String,
                description: q['desc'] as String,
                xpReward: q['xp'] as int,
                category: q['cat'] as String,
              ),
            ))
        .toList();
  }
}
