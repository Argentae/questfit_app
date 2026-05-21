import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../engine/rhythm_engine.dart';
import '../providers/health_provider.dart';
import '../providers/user_provider.dart';
import '../services/health_sync_service.dart';

/// v2.4: Rhythm Dashboard Screen.
///
/// Displays Samsung Health integration data:
/// - Sleep quality & rest buff status
/// - Aether currency from active calories
/// - Heart rate zone overview
/// - Permission setup flow
class RhythmScreen extends ConsumerStatefulWidget {
  const RhythmScreen({super.key});

  @override
  ConsumerState<RhythmScreen> createState() => _RhythmScreenState();
}

class _RhythmScreenState extends ConsumerState<RhythmScreen>
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
    final isAvailable = ref.watch(healthAvailableProvider);
    final isAuthorized = ref.watch(healthAuthorizedProvider);

    return SafeArea(
      child: isAvailable.when(
        data: (available) {
          if (!available) return _buildUnavailable();
          return isAuthorized.when(
            data: (authorized) {
              if (!authorized) return _buildPermissionRequest();
              return _buildDashboard();
            },
            loading: () => _buildLoading(),
            error: (_, __) => _buildPermissionRequest(),
          );
        },
        loading: () => _buildLoading(),
        error: (_, __) => _buildUnavailable(),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(color: QuestFitColors.purple),
    );
  }

  // ─── No Health Connect ─────────────────────────────────────────────

  Widget _buildUnavailable() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('📱', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(
            'Health Connect Required',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: QuestFitColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Install Health Connect from the Play Store and '
            'enable Samsung Health sync to use the Rhythm dashboard.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: QuestFitColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Permission Request ────────────────────────────────────────────

  Widget _buildPermissionRequest() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_pulseController.value * 0.1),
                child: child,
              );
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    QuestFitColors.purple.withOpacity(0.3),
                    QuestFitColors.purple.withOpacity(0.05),
                  ],
                ),
              ),
              child: const Center(
                child: Text('⌚', style: TextStyle(fontSize: 48)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Connect Your Watch',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: QuestFitColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Grant QuestFit access to your Samsung Health data '
            'to unlock sleep buffs, Aether currency, and heart rate bonuses.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: QuestFitColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          _buildPermissionList(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () async {
                await ref
                    .read(healthSyncNotifierProvider.notifier)
                    .requestPermissions();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: QuestFitColors.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'GRANT ACCESS',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionList() {
    const items = [
      ('💤', 'Sleep Data', 'Track your rest quality'),
      ('🫀', 'Heart Rate', 'Analyze workout intensity'),
      ('🔥', 'Calories', 'Earn Aether currency'),
      ('🏃', 'Workouts', 'Auto-import sessions'),
    ];
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Text(item.$1, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.$2,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: QuestFitColors.textPrimary,
                    ),
                  ),
                  Text(
                    item.$3,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: QuestFitColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ─── Main Dashboard ────────────────────────────────────────────────

  Widget _buildDashboard() {
    final syncState = ref.watch(healthSyncNotifierProvider);
    final restBuff = ref.watch(restBuffProvider);
    final sleepData = ref.watch(sleepSummaryProvider);
    final aether = ref.watch(todayAetherProvider);
    final playerAether = ref.watch(aetherProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(healthSyncNotifierProvider.notifier).syncRhythm();
      },
      color: QuestFitColors.purple,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildRestBuffCard(restBuff),
          const SizedBox(height: 12),
          _buildSleepCard(sleepData),
          const SizedBox(height: 12),
          _buildAetherCard(aether, playerAether),
          const SizedBox(height: 12),
          _buildSyncButton(syncState),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [QuestFitColors.purple, Color(0xFFD4BBFF)],
          ).createShader(bounds),
          child: Text(
            'RHYTHM',
            style: GoogleFonts.cinzel(
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '⌚',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  // ─── Rest Buff Card ────────────────────────────────────────────────

  Widget _buildRestBuffCard(RestBuff buff) {
    final Color accentColor;
    final Color bgColor;
    switch (buff.tier) {
      case 'well_rested':
        accentColor = QuestFitColors.emerald;
        bgColor = QuestFitColors.emerald.withOpacity(0.08);
        break;
      case 'rested':
        accentColor = QuestFitColors.blueAccent;
        bgColor = QuestFitColors.blueAccent.withOpacity(0.08);
        break;
      case 'light':
        accentColor = QuestFitColors.gold;
        bgColor = QuestFitColors.gold.withOpacity(0.08);
        break;
      default:
        accentColor = QuestFitColors.textMuted;
        bgColor = QuestFitColors.bgCard;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          // Buff icon with glow
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  accentColor.withOpacity(0.25),
                  accentColor.withOpacity(0.05),
                ],
              ),
            ),
            child: Center(
              child: Text(buff.emoji, style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      buff.label,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: accentColor,
                      ),
                    ),
                    if (buff.isActive) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'ACTIVE',
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: accentColor,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  buff.description,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: QuestFitColors.textSecondary,
                  ),
                ),
                if (buff.isActive)
                  Text(
                    'x${buff.multiplier.toStringAsFixed(2)} multiplier',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: accentColor.withOpacity(0.7),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Sleep Breakdown Card ──────────────────────────────────────────

  Widget _buildSleepCard(SleepSummary? sleep) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: glassCard(borderRadius: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('💤', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                'LAST NIGHT\'S SLEEP',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: QuestFitColors.textMuted,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (sleep == null || !sleep.hasData)
            Text(
              'No sleep data found. Make sure your Samsung Watch tracked last night\'s sleep.',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: QuestFitColors.textSecondary,
              ),
            )
          else ...[
            // Total sleep duration
            Text(
              sleep.totalFormatted,
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: QuestFitColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            // Sleep stage breakdown bar
            _buildSleepStageBar(sleep),
            const SizedBox(height: 8),
            // Stage labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sleepStageLabel('Deep', sleep.deepMinutes,
                    const Color(0xFF6366F1)),
                _sleepStageLabel(
                    'REM', sleep.remMinutes, const Color(0xFF8B5CF6)),
                _sleepStageLabel('Light', sleep.lightMinutes,
                    const Color(0xFFA78BFA)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSleepStageBar(SleepSummary sleep) {
    final total = sleep.totalMinutes.clamp(1, 999);
    final deepPct = sleep.deepMinutes / total;
    final remPct = sleep.remMinutes / total;
    final lightPct = sleep.lightMinutes / total;

    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        height: 10,
        child: Row(
          children: [
            Expanded(
              flex: (deepPct * 100).round().clamp(1, 100),
              child: Container(color: const Color(0xFF6366F1)),
            ),
            Expanded(
              flex: (remPct * 100).round().clamp(1, 100),
              child: Container(color: const Color(0xFF8B5CF6)),
            ),
            Expanded(
              flex: (lightPct * 100).round().clamp(1, 100),
              child: Container(color: const Color(0xFFA78BFA)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sleepStageLabel(String name, int minutes, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '$name ${minutes}m',
          style: GoogleFonts.inter(
            fontSize: 11,
            color: QuestFitColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // ─── Aether Card ───────────────────────────────────────────────────

  Widget _buildAetherCard(AetherResult aether, AsyncValue<int> playerAether) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1A0A2E).withOpacity(0.8),
            const Color(0xFF0D1B2A).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: QuestFitColors.purple.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('🔮', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(
                    'AETHER',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: QuestFitColors.purple,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              // Total Aether balance
              playerAether.when(
                data: (total) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: QuestFitColors.purple.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '🔮 $total',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: QuestFitColors.purple,
                    ),
                  ),
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Today's earnings
          Row(
            children: [
              Text(
                '+${aether.earned}',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: QuestFitColors.purple,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'earned today',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: QuestFitColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            aether.description,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: QuestFitColors.textMuted,
            ),
          ),
          const SizedBox(height: 8),
          // Progress bar to max daily Aether
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (aether.earned / RhythmEngine.maxDailyAether)
                  .clamp(0.0, 1.0),
              minHeight: 4,
              backgroundColor: QuestFitColors.purple.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation(QuestFitColors.purple),
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${aether.earned}/${RhythmEngine.maxDailyAether} daily cap',
              style: GoogleFonts.inter(
                fontSize: 10,
                color: QuestFitColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Sync Button ───────────────────────────────────────────────────

  Widget _buildSyncButton(HealthSyncState syncState) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: syncState.isSyncing
            ? null
            : () async {
                await ref
                    .read(healthSyncNotifierProvider.notifier)
                    .sync();
              },
        icon: syncState.isSyncing
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.sync_rounded, size: 18),
        label: Text(
          syncState.isSyncing ? 'SYNCING…' : 'SYNC WITH WATCH',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            fontSize: 13,
            letterSpacing: 0.8,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: QuestFitColors.purple.withOpacity(0.2),
          foregroundColor: QuestFitColors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: QuestFitColors.purple.withOpacity(0.3),
            ),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
