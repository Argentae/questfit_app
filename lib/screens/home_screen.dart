import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../widgets/character_card.dart';
import '../widgets/streak_bar.dart';
import '../widgets/quest_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          // Top bar
          Row(
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
          ),
          const SizedBox(height: 20),
          // Character dashboard
          const CharacterCard(),
          const SizedBox(height: 24),
          // Streak
          const StreakBar(),
          const SizedBox(height: 24),
          // Daily Quests header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Daily Quests',
                  style: GoogleFonts.cinzel(
                      fontWeight: FontWeight.w700, fontSize: 16)),
              TextButton(
                onPressed: () {},
                child: const Text('View All',
                    style: TextStyle(
                        color: QuestFitColors.emerald,
                        fontWeight: FontWeight.w600,
                        fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Quest cards
          const QuestCard(
            emoji: '🏋️',
            title: 'Barbell Squats',
            description: '3 sets × 10 reps · 80 kg',
            xpReward: 120,
            category: 'strength',
            initialCompleted: true,
          ),
          const SizedBox(height: 10),
          const QuestCard(
            emoji: '🏃',
            title: 'Treadmill Sprint',
            description: '15 min HIIT · Level 8 intensity',
            xpReward: 90,
            category: 'cardio',
          ),
          const SizedBox(height: 10),
          const QuestCard(
            emoji: '🧘',
            title: 'Hip Mobility Flow',
            description: '10 min stretching routine',
            xpReward: 50,
            category: 'flexibility',
          ),
          const SizedBox(height: 10),
          const QuestCard(
            emoji: '💪',
            title: 'Plank Challenge',
            description: '3 × 60 sec holds · Core',
            xpReward: 75,
            category: 'core',
          ),
          const SizedBox(height: 24),
          // Boss Raid banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  QuestFitColors.purple.withValues(alpha: 0.12),
                  QuestFitColors.blueAccent.withValues(alpha: 0.08),
                ],
              ),
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
          ),
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
