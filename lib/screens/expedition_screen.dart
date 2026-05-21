import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../data/exercise_catalog.dart';
import '../engine/step_engine.dart';
import '../providers/companion_provider.dart';
import '../providers/step_provider.dart';
import '../widgets/egg_card.dart';

/// v2.2: Expedition screen — step counter dashboard, milestones, eggs, companions.
class ExpeditionScreen extends ConsumerStatefulWidget {
  const ExpeditionScreen({super.key});

  @override
  ConsumerState<ExpeditionScreen> createState() => _ExpeditionScreenState();
}

class _ExpeditionScreenState extends ConsumerState<ExpeditionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final steps = ref.watch(todayStepsProvider);
    final dailyGoal = ref.watch(dailyStepGoalProvider);
    final hasMomentum = ref.watch(momentumBuffProvider);
    final eggsAsync = ref.watch(activeEggsProvider);
    final companionsAsync = ref.watch(companionsProvider);
    final milestoneAsync = ref.watch(stepMilestoneProvider);

    final progress = dailyGoal > 0 ? (steps / dailyGoal).clamp(0.0, 1.0) : 0.0;
    final remaining = (dailyGoal - steps).clamp(0, dailyGoal);

    return Scaffold(
      backgroundColor: QuestFitColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: QuestFitColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'EXPEDITION',
          style: GoogleFonts.cinzel(
            fontSize: 22, fontWeight: FontWeight.w900,
            foreground: Paint()..shader = goldGradientShader(
              const Rect.fromLTWH(0, 0, 220, 30)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Step Counter Hero ───────────────────────────────
            Center(
              child: SizedBox(
                width: 180, height: 180,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background ring
                    SizedBox(
                      width: 180, height: 180,
                      child: CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 10,
                        color: QuestFitColors.glassBorder,
                      ),
                    ),
                    // Progress ring
                    SizedBox(
                      width: 180, height: 180,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: progress),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        builder: (_, value, __) => CircularProgressIndicator(
                          value: value,
                          strokeWidth: 10,
                          strokeCap: StrokeCap.round,
                          color: hasMomentum
                              ? QuestFitColors.gold
                              : QuestFitColors.emerald,
                        ),
                      ),
                    ),
                    // Center text
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('👟', style: TextStyle(fontSize: 24)),
                        const SizedBox(height: 4),
                        Text(
                          _formatSteps(steps),
                          style: const TextStyle(
                              color: QuestFitColors.textPrimary,
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          '/ ${_formatSteps(dailyGoal)}',
                          style: const TextStyle(
                              color: QuestFitColors.textMuted, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Momentum Buff Banner ─────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: hasMomentum
                    ? QuestFitColors.emerald.withValues(alpha: 0.1)
                    : QuestFitColors.bgCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: hasMomentum
                      ? QuestFitColors.emerald.withValues(alpha: 0.4)
                      : QuestFitColors.glassBorder,
                ),
              ),
              child: Row(
                children: [
                  Text(hasMomentum ? '🔥' : '🚶', style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasMomentum ? 'MOMENTUM ACTIVE' : 'MOMENTUM BUFF',
                          style: TextStyle(
                            color: hasMomentum
                                ? QuestFitColors.emerald
                                : QuestFitColors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          hasMomentum
                              ? '+10% LP & Gold today!'
                              : 'Walk $remaining more steps to unlock tomorrow\'s buff',
                          style: TextStyle(
                            color: hasMomentum
                                ? QuestFitColors.textPrimary
                                : QuestFitColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Milestone Trail ──────────────────────────────────
            _sectionHeader('MILESTONE TRAIL', '🗺️'),
            const SizedBox(height: 10),
            SizedBox(
              height: 70,
              child: milestoneAsync.when(
                loading: () => const SizedBox(),
                error: (_, __) => const SizedBox(),
                data: (milestone) {
                  final claimed = milestone?.milestonesClaimed ?? 0;
                  final earned = StepEngine.milestonesEarned(steps);
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: StepEngine.maxDailyMilestones,
                    itemBuilder: (context, index) {
                      final num = index + 1;
                      final isClaimed = num <= claimed;
                      final isEarned = num <= earned;
                      final isCurrent = !isClaimed && isEarned;

                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Column(
                          children: [
                            AnimatedBuilder(
                              animation: _pulseController,
                              builder: (_, child) {
                                final scale = isCurrent
                                    ? 1.0 + _pulseController.value * 0.1
                                    : 1.0;
                                return Transform.scale(scale: scale, child: child);
                              },
                              child: Container(
                                width: 42, height: 42,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isClaimed
                                      ? QuestFitColors.gold.withValues(alpha: 0.2)
                                      : isCurrent
                                          ? QuestFitColors.emerald.withValues(alpha: 0.2)
                                          : Colors.transparent,
                                  border: Border.all(
                                    color: isClaimed
                                        ? QuestFitColors.gold
                                        : isCurrent
                                            ? QuestFitColors.emerald
                                            : QuestFitColors.glassBorder,
                                    width: 2,
                                  ),
                                  boxShadow: isCurrent
                                      ? [BoxShadow(
                                          color: QuestFitColors.emerald.withValues(alpha: 0.4),
                                          blurRadius: 8)]
                                      : null,
                                ),
                                child: Center(
                                  child: isClaimed
                                      ? const Icon(Icons.check, color: QuestFitColors.gold, size: 18)
                                      : Text(
                                          '${num * 2}k',
                                          style: TextStyle(
                                            color: isCurrent
                                                ? QuestFitColors.emerald
                                                : QuestFitColors.textMuted,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('#$num',
                                style: const TextStyle(
                                    color: QuestFitColors.textMuted, fontSize: 10)),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // ── Egg Hatchery ─────────────────────────────────────
            _sectionHeader('EGG HATCHERY', '🥚'),
            const SizedBox(height: 10),
            eggsAsync.when(
              loading: () => const SizedBox(height: 100),
              error: (_, __) => const SizedBox(),
              data: (eggs) {
                if (eggs.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: glassCard(borderRadius: 12),
                    child: const Column(
                      children: [
                        Text('🥚', style: TextStyle(fontSize: 36)),
                        SizedBox(height: 8),
                        Text('No eggs yet',
                            style: TextStyle(color: QuestFitColors.textSecondary)),
                        Text('Keep walking to discover one!',
                            style: TextStyle(
                                color: QuestFitColors.textMuted, fontSize: 12)),
                      ],
                    ),
                  );
                }

                return SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: eggs.length,
                    itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                        width: 120,
                        child: EggCard(
                          stepsAccumulated: eggs[i].stepsAccumulated,
                          stepsRequired: eggs[i].stepsRequired,
                          rarity: eggs[i].rarity,
                          companionType: eggs[i].companionType,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // ── Companions ───────────────────────────────────────
            _sectionHeader('COMPANIONS', '🐾'),
            const SizedBox(height: 10),
            companionsAsync.when(
              loading: () => const SizedBox(height: 100),
              error: (_, __) => const SizedBox(),
              data: (companions) {
                if (companions.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: glassCard(borderRadius: 12),
                    child: const Column(
                      children: [
                        Text('🐾', style: TextStyle(fontSize: 36)),
                        SizedBox(height: 8),
                        Text('No companions yet',
                            style: TextStyle(color: QuestFitColors.textSecondary)),
                        Text('Hatch eggs to build your collection!',
                            style: TextStyle(
                                color: QuestFitColors.textMuted, fontSize: 12)),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: companions.length,
                  itemBuilder: (_, i) {
                    final c = companions[i];
                    final def = getCompanionByType(c.type);
                    final rarityColor = Color(companionRarityColors[c.rarity] ?? 0xFF8B8B8B);

                    return GestureDetector(
                      onTap: () => ref
                          .read(companionNotifierProvider.notifier)
                          .setActiveCompanion(c.id),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: QuestFitColors.bgCard,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: c.isActive
                                ? rarityColor
                                : QuestFitColors.glassBorder,
                            width: c.isActive ? 2 : 1,
                          ),
                          boxShadow: c.isActive
                              ? [BoxShadow(
                                  color: rarityColor.withValues(alpha: 0.3),
                                  blurRadius: 12)]
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                def?.imagePath ?? 'assets/images/companions/fire_drake.png',
                                width: 48, height: 48,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    Text(def?.emoji ?? '🐾', style: const TextStyle(fontSize: 32)),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(c.name,
                                style: const TextStyle(
                                    color: QuestFitColors.textPrimary,
                                    fontSize: 12, fontWeight: FontWeight.w600),
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                            Text(def?.buffDescription ?? '',
                                style: TextStyle(
                                    color: rarityColor, fontSize: 10),
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                            if (c.isActive)
                              const Text('⭐ ACTIVE',
                                  style: TextStyle(
                                      color: QuestFitColors.gold,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String text, String emoji) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(
                color: QuestFitColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 1)),
      ],
    );
  }

  String _formatSteps(int steps) {
    if (steps >= 1000) {
      return '${(steps / 1000).toStringAsFixed(1)}k';
    }
    return steps.toString();
  }
}
