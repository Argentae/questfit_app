import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../db/database.dart';
import '../engine/rank_engine.dart';
import '../providers/user_provider.dart';
import '../providers/rank_trial_provider.dart';

/// v3.0: Tier Info Screen — shows current rank, LP progress, and the tier ladder.
/// v3.1: Added interactive promotion button when pendingPromotion is true.
class RankTrialScreen extends ConsumerWidget {
  const RankTrialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerAsync = ref.watch(playerStreamProvider);
    final tierAsync = ref.watch(tierInfoProvider);
    final lpAsync = ref.watch(lpProgressProvider);
    final ladderAsync = ref.watch(ladderProgressProvider);
    final historyAsync = ref.watch(rankHistoryProvider);

    return Scaffold(
      backgroundColor: QuestFitColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: QuestFitColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: ShaderMask(
          shaderCallback: goldGradientShader,
          child: Text(
            'TIER LADDER',
            style: GoogleFonts.cinzel(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: playerAsync.when(
        loading: () => const Center(
            child: CircularProgressIndicator(
                color: QuestFitColors.emerald, strokeWidth: 2)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (player) {
          final tier = tierAsync.valueOrNull ?? RankEngine.defaultTierInfo;
          final lp = lpAsync.valueOrNull;
          final ladder = ladderAsync.valueOrNull;
          final history = historyAsync.valueOrNull ?? [];

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                // Current Tier Hero
                _buildCurrentTierHero(context, tier, lp, player),
                const SizedBox(height: 24),
                // Ladder Progress
                if (ladder != null) _buildLadderProgress(context, ladder, tier),
                const SizedBox(height: 24),
                // Tier Ladder
                _buildTierLadder(context, tier),
                const SizedBox(height: 24),
                // Rank History
                if (history.isNotEmpty) _buildHistory(context, history),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrentTierHero(
      BuildContext context, TierInfo tier, dynamic lp, dynamic player) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            tier.color.withValues(alpha: 0.15),
            tier.color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: tier.color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          // Tier emblem
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  tier.color.withValues(alpha: 0.3),
                  tier.color.withValues(alpha: 0.1),
                ],
              ),
              border: Border.all(color: tier.color, width: 2),
              boxShadow: [
                BoxShadow(
                  color: tier.color.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                _tierEmoji(tier.name),
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            tier.fullName.toUpperCase(),
            style: GoogleFonts.cinzel(
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: tier.color,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          // LP display
          Text(
            '${lp?.current ?? 0} / ${lp?.max ?? 100} LP',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: QuestFitColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          // LP bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 12,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: tier.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor:
                        ((lp?.current ?? 0) / (lp?.max ?? 100)).clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [tier.color, tier.color.withValues(alpha: 0.7)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: tier.color.withValues(alpha: 0.4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (player.pendingPromotion) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  QuestFitColors.gold.withValues(alpha: 0.2),
                  QuestFitColors.orangeAccent.withValues(alpha: 0.12),
                ]),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: QuestFitColors.gold.withValues(alpha: 0.4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: QuestFitColors.gold.withValues(alpha: 0.15),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('⚡', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text(
                    'ADVANCING ON NEXT LOGIN!',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      color: QuestFitColors.gold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLadderProgress(
      BuildContext context, ({int current, int total}) ladder, TierInfo tier) {
    final progress = ladder.total > 0 ? ladder.current / ladder.total : 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: glassCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('LADDER PROGRESS',
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 6,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: QuestFitColors.emerald.withValues(alpha: 0.12),
                valueColor: AlwaysStoppedAnimation(tier.color),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Position ${ladder.current + 1} of ${ladder.total}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildTierLadder(BuildContext context, TierInfo currentTier) {
    final allTiers = RankEngine.allTiers;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: glassCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TIER LADDER',
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 12),
          // Show tiers in reverse order (highest first)
          ...allTiers.reversed.map((tier) {
            final isCurrent =
                tier.name.toLowerCase() == currentTier.name.toLowerCase();

            return Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isCurrent
                    ? tier.color.withValues(alpha: 0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: isCurrent
                    ? Border.all(color: tier.color.withValues(alpha: 0.3))
                    : null,
              ),
              child: Row(
                children: [
                  Text(_tierEmoji(tier.name),
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tier.name,
                      style: GoogleFonts.inter(
                        fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w500,
                        fontSize: 14,
                        color: isCurrent
                            ? tier.color
                            : QuestFitColors.textSecondary,
                      ),
                    ),
                  ),
                  Text(
                    tier.divisions > 1 ? 'IV – I' : '—',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: QuestFitColors.textMuted,
                    ),
                  ),
                  if (isCurrent) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: tier.color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'YOU',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: tier.color,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHistory(BuildContext context, List<RankHistoryData> history) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: glassCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('RANK HISTORY',
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 12),
          ...history.take(10).map((entry) {
            final parts = entry.rank.split('_');
            final tierName = parts.isNotEmpty ? parts[0] : 'iron';
            final div = parts.length > 1 ? int.tryParse(parts[1]) ?? 4 : 4;
            final info = RankEngine.getTierInfo(tierName, div);

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: info.color,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      info.fullName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: info.color,
                      ),
                    ),
                  ),
                  Text(
                    _formatDate(entry.achievedAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _tierEmoji(String tierName) {
    switch (tierName.toLowerCase()) {
      case 'iron':
        return '⚙️';
      case 'bronze':
        return '🥉';
      case 'silver':
        return '🥈';
      case 'gold':
        return '🥇';
      case 'platinum':
        return '💎';
      case 'emerald':
        return '🟢';
      case 'diamond':
        return '💠';
      case 'master':
        return '🏆';
      case 'grandmaster':
        return '👑';
      case 'challenger':
        return '⚡';
      default:
        return '⚙️';
    }
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
