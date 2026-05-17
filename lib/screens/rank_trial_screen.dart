import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../db/database.dart';
import '../engine/rank_engine.dart';
import '../providers/rank_trial_provider.dart';
import '../providers/user_provider.dart';
import '../services/haptic_service.dart';

/// v2.0: Rank Trial (Promotion Series) Screen.
/// Displayed when the player is at a promotion boundary and must
/// complete a trial to advance to the next rank tier.
class RankTrialScreen extends ConsumerStatefulWidget {
  const RankTrialScreen({super.key});

  @override
  ConsumerState<RankTrialScreen> createState() => _RankTrialScreenState();
}

class _RankTrialScreenState extends ConsumerState<RankTrialScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerAsync = ref.watch(playerStreamProvider);
    final trialAsync = ref.watch(activeTrialProvider);
    final reqAsync = ref.watch(trialRequirementsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF050810),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: playerAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (player) => trialAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (trial) => trial != null
                  ? _buildActiveTrial(player, trial)
                  : _buildTrialStart(player, reqAsync),
            ),
          ),
        ),
      ),
    );
  }

  /// No active trial — show the "Start Trial" prompt.
  Widget _buildTrialStart(Player player, AsyncValue<TrialRequirement?> reqAsync) {
    return reqAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (req) {
        if (req == null) {
          return Center(
            child: Text(
              'No promotion trial available at this level.',
              style: GoogleFonts.inter(color: QuestFitColors.textSecondary),
            ),
          );
        }

        final currentRank = RankEngine.getRank(player.level);
        final isGatekeeper = req.trialType == 'gatekeeper';

        return Column(
          children: [
            const SizedBox(height: 40),
            _buildTrialTitle(isGatekeeper),
            const SizedBox(height: 8),
            Text(
              req.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: QuestFitColors.textSecondary,
              ),
            ),
            const SizedBox(height: 40),
            _buildRankTransition(currentRank, req),
            const SizedBox(height: 40),
            _buildTrialRequirements(req),
            const SizedBox(height: 16),
            _buildDecayWarning(),
            const Spacer(),
            _buildStartButton(),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  /// Active trial — show progress.
  Widget _buildActiveTrial(Player player, RankTrial trial) {
    final isConsistency = trial.trialType == 'consistency';

    return Column(
      children: [
        const SizedBox(height: 40),
        _buildTrialTitle(!isConsistency),
        const SizedBox(height: 8),
        Text(
          'Trial in progress — ${trial.status.toUpperCase()}',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: QuestFitColors.emerald,
          ),
        ),
        const SizedBox(height: 48),
        if (isConsistency)
          _buildConsistencyProgress(trial)
        else
          _buildGatekeeperProgress(trial),
        const SizedBox(height: 40),
        _buildElapsedTime(trial),
        const Spacer(),
        if (trial.status == 'active') _buildAbandonButton(),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildTrialTitle(bool isGatekeeper) {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        final opacity = 0.6 + (_glowController.value * 0.4);
        return Opacity(
          opacity: opacity,
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: isGatekeeper
                  ? [const Color(0xFFF87171), const Color(0xFFF0C850)]
                  : [QuestFitColors.emerald, QuestFitColors.blueAccent],
            ).createShader(bounds),
            child: Text(
              isGatekeeper ? 'GATEKEEPER BOSS' : 'PROMOTION SERIES',
              style: GoogleFonts.cinzel(
                fontWeight: FontWeight.w900,
                fontSize: 24,
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRankTransition(RankInfo currentRank, TrialRequirement req) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _RankBadge(
          name: currentRank.fullName,
          color: currentRank.color,
          isSource: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.arrow_forward_rounded,
            color: QuestFitColors.gold,
            size: 28,
          ),
        ),
        _RankBadge(
          name: req.targetRankName,
          color: QuestFitColors.gold,
          isSource: false,
        ),
      ],
    );
  }

  Widget _buildTrialRequirements(TrialRequirement req) {
    if (req.trialType == 'consistency') {
      return _RequirementCard(
        icon: Icons.local_fire_department_rounded,
        title: 'Consistency Trial',
        description: 'Maintain a ${req.requiredStreakDays}-day streak without failing.',
        color: QuestFitColors.emerald,
      );
    } else {
      return Column(
        children: [
          _RequirementCard(
            icon: Icons.local_fire_department_rounded,
            title: 'Calorie Goal',
            description: 'Burn ${req.calorieGoal} kcal within 24 hours.',
            color: QuestFitColors.orangeAccent,
          ),
          const SizedBox(height: 10),
          _RequirementCard(
            icon: Icons.directions_walk_rounded,
            title: 'Step Goal',
            description: 'Walk ${req.stepGoal} steps within 24 hours.',
            color: QuestFitColors.blueAccent,
          ),
        ],
      );
    }
  }

  Widget _buildDecayWarning() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: QuestFitColors.redAccent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: QuestFitColors.redAccent.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded,
              size: 18, color: QuestFitColors.redAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Failure costs 15% of your current XP. You must grind back to trigger the trial again.',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: QuestFitColors.redAccent.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsistencyProgress(RankTrial trial) {

    return Column(
      children: [
        // Day indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(trial.requiredStreakDays, (i) {
            final completed = i < trial.streakDaysCompleted;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: completed
                      ? QuestFitColors.emerald.withValues(alpha: 0.2)
                      : QuestFitColors.bgCard,
                  border: Border.all(
                    color: completed
                        ? QuestFitColors.emerald
                        : QuestFitColors.glassBorder,
                    width: completed ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: completed
                      ? const Icon(Icons.check, size: 18, color: QuestFitColors.emerald)
                      : Text(
                          '${i + 1}',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: QuestFitColors.textMuted,
                          ),
                        ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        Text(
          '${trial.streakDaysCompleted} / ${trial.requiredStreakDays} DAYS',
          style: GoogleFonts.cinzel(
            fontWeight: FontWeight.w800,
            fontSize: 20,
            color: QuestFitColors.emerald,
          ),
        ),
      ],
    );
  }

  Widget _buildGatekeeperProgress(RankTrial trial) {
    final calProg = trial.calorieGoal != null && trial.calorieGoal! > 0
        ? (trial.caloriesAchieved / trial.calorieGoal!).clamp(0.0, 1.0)
        : 0.0;
    final stepProg = trial.stepGoal != null && trial.stepGoal! > 0
        ? (trial.stepsAchieved / trial.stepGoal!).clamp(0.0, 1.0)
        : 0.0;

    return Column(
      children: [
        _TrialProgressBar(
          label: 'CALORIES',
          current: trial.caloriesAchieved,
          goal: trial.calorieGoal ?? 0,
          progress: calProg,
          color: QuestFitColors.orangeAccent,
        ),
        const SizedBox(height: 16),
        _TrialProgressBar(
          label: 'STEPS',
          current: trial.stepsAchieved,
          goal: trial.stepGoal ?? 0,
          progress: stepProg,
          color: QuestFitColors.blueAccent,
        ),
      ],
    );
  }

  Widget _buildElapsedTime(RankTrial trial) {
    final elapsed = DateTime.now().difference(trial.startedAt);
    final remaining = const Duration(hours: 24) - elapsed;
    final isExpired = remaining.isNegative;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: QuestFitColors.bgCard,
        border: Border.all(color: QuestFitColors.glassBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_rounded,
            size: 18,
            color: isExpired ? QuestFitColors.redAccent : QuestFitColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Text(
            trial.trialType == 'gatekeeper'
                ? (isExpired
                    ? 'TIME EXPIRED'
                    : '${remaining.inHours}h ${remaining.inMinutes % 60}m remaining')
                : 'No time limit',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: isExpired ? QuestFitColors.redAccent : QuestFitColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _startTrial,
        style: ElevatedButton.styleFrom(
          backgroundColor: QuestFitColors.gold,
          foregroundColor: QuestFitColors.bgDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(
          'BEGIN PROMOTION TRIAL',
          style: GoogleFonts.cinzel(
            fontWeight: FontWeight.w900,
            fontSize: 14,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildAbandonButton() {
    return TextButton(
      onPressed: _abandonTrial,
      child: Text(
        'ABANDON TRIAL',
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: QuestFitColors.redAccent.withValues(alpha: 0.6),
          letterSpacing: 1,
        ),
      ),
    );
  }

  Future<void> _startTrial() async {
    HapticService.onLevelUp();
    final success =
        await ref.read(rankTrialNotifierProvider.notifier).startTrial();
    if (mounted && !success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cannot start trial at this level.'),
        backgroundColor: QuestFitColors.redAccent,
      ));
    }
  }

  Future<void> _abandonTrial() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: QuestFitColors.bgDark,
        title: Text(
          'Abandon Trial?',
          style: GoogleFonts.cinzel(color: QuestFitColors.redAccent),
        ),
        content: Text(
          'You will lose 15% of your current XP and must grind back to retry.',
          style: GoogleFonts.inter(color: QuestFitColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Abandon',
                style: TextStyle(color: QuestFitColors.redAccent)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final decay =
          await ref.read(rankTrialNotifierProvider.notifier).failTrial();
      if (mounted && decay != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Trial failed. Lost ${decay.xpLost} XP.'),
          backgroundColor: QuestFitColors.redAccent,
        ));
      }
    }
  }
}

class _RankBadge extends StatelessWidget {
  final String name;
  final Color color;
  final bool isSource;

  const _RankBadge({
    required this.name,
    required this.color,
    required this.isSource,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: color.withValues(alpha: isSource ? 0.08 : 0.15),
        border: Border.all(
          color: color.withValues(alpha: isSource ? 0.2 : 0.4),
          width: isSource ? 1 : 2,
        ),
      ),
      child: Text(
        name,
        style: GoogleFonts.cinzel(
          fontWeight: FontWeight.w800,
          fontSize: 14,
          color: color,
        ),
      ),
    );
  }
}

class _RequirementCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _RequirementCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: QuestFitColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrialProgressBar extends StatelessWidget {
  final String label;
  final int current;
  final int goal;
  final double progress;
  final Color color;

  const _TrialProgressBar({
    required this.label,
    required this.current,
    required this.goal,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: QuestFitColors.textMuted,
                letterSpacing: 2,
              ),
            ),
            Text(
              '$current / $goal',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: progress >= 1.0 ? color : QuestFitColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: QuestFitColors.glassBorder,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
