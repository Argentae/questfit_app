import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/theme.dart';
import '../providers/app_init_provider.dart';
import '../providers/health_provider.dart';
import '../providers/user_provider.dart';


/// v2.0: The Awakening — Proving Grounds (Levels 1-5).
/// A dark, minimalist screen that locks the player out of the main UI
/// until they reach Level 5 by hitting step and calorie goals via Health Connect.
///
/// This screen uses a READ-ONLY health sync (no XP awarded, no workouts imported).
/// Progress is persisted in SharedPreferences so it survives app restarts.
class AwakeningScreen extends ConsumerStatefulWidget {
  const AwakeningScreen({super.key});

  @override
  ConsumerState<AwakeningScreen> createState() => _AwakeningScreenState();
}

class _AwakeningScreenState extends ConsumerState<AwakeningScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _breatheController;

  static const int _stepGoal = 5000;
  static const int _calorieGoal = 300;

  // Persisted keys
  static const _prefsStepsKey = 'awakening_steps';
  static const _prefsCaloriesKey = 'awakening_calories';
  static const _prefsSyncTimeKey = 'awakening_last_sync';

  int _currentSteps = 0;
  int _currentCalories = 0;
  DateTime? _lastSyncTime;
  bool _isSyncing = false;
  List<String> _debugLines = [];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    // Restore persisted progress
    _restoreProgress();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _breatheController.dispose();
    super.dispose();
  }

  /// Restore saved progress from SharedPreferences.
  Future<void> _restoreProgress() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _currentSteps = prefs.getInt(_prefsStepsKey) ?? 0;
        _currentCalories = prefs.getInt(_prefsCaloriesKey) ?? 0;
        final syncMs = prefs.getInt(_prefsSyncTimeKey);
        _lastSyncTime = syncMs != null
            ? DateTime.fromMillisecondsSinceEpoch(syncMs)
            : null;
      });
    }
  }

  /// Save current progress to SharedPreferences.
  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefsStepsKey, _currentSteps);
    await prefs.setInt(_prefsCaloriesKey, _currentCalories);
    if (_lastSyncTime != null) {
      await prefs.setInt(
          _prefsSyncTimeKey, _lastSyncTime!.millisecondsSinceEpoch);
    }
  }

  @override
  Widget build(BuildContext context) {
    final playerAsync = ref.watch(playerStreamProvider);
    final healthAuthorized = ref.watch(healthAuthorizedProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF050810),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    _buildTitle(),
                    const SizedBox(height: 12),
                    _buildSubtitle(),
                    const SizedBox(height: 48),
                    _buildRuneCircle(),
                    const SizedBox(height: 48),
                    _buildProgressCards(),
                    const Spacer(),
                    // Last sync time
                    if (_lastSyncTime != null) _buildLastSyncLabel(),
                    const SizedBox(height: 8),
                    // Level display
                    playerAsync.when(
                      data: (player) => _buildLevelDisplay(player.level),
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 16),
                    // Action button
                    healthAuthorized.when(
                      data: (authorized) => authorized
                          ? _buildSyncButton()
                          : _buildPermissionButton(),
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => _buildPermissionButton(),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return AnimatedBuilder(
      animation: _breatheController,
      builder: (context, child) {
        final opacity = 0.6 + (_breatheController.value * 0.4);
        return Opacity(
          opacity: opacity,
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFFA78BFA), Color(0xFF2DD4A8)],
            ).createShader(bounds),
            child: Text(
              'THE AWAKENING',
              style: GoogleFonts.cinzel(
                fontWeight: FontWeight.w900,
                fontSize: 28,
                color: Colors.white,
                letterSpacing: 4,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'PROVING GROUNDS',
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: QuestFitColors.textMuted,
        letterSpacing: 6,
      ),
    );
  }

  Widget _buildRuneCircle() {
    final stepProgress = _stepGoal > 0
        ? (_currentSteps / _stepGoal).clamp(0.0, 1.0)
        : 0.0;
    final calProgress = _calorieGoal > 0
        ? (_currentCalories / _calorieGoal).clamp(0.0, 1.0)
        : 0.0;
    // Average of both — intuitive combined progress
    final clampedProgress = (stepProgress + calProgress) / 2;

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final scale = 1.0 + (_pulseController.value * 0.04);
        final glowOpacity = 0.2 + (_pulseController.value * 0.3);

        return Transform.scale(
          scale: scale,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: QuestFitColors.purple.withValues(alpha: glowOpacity),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Progress ring
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: clampedProgress,
                    strokeWidth: 3,
                    backgroundColor: QuestFitColors.glassBorder,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        QuestFitColors.emerald),
                  ),
                ),
                // Inner circle
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF0A0E1A),
                    border: Border.all(
                      color: QuestFitColors.purple.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${(clampedProgress * 100).round()}%',
                        style: GoogleFonts.cinzel(
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                          color: QuestFitColors.emerald,
                        ),
                      ),
                      Text(
                        'AWAKENING',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                          color: QuestFitColors.textMuted,
                          letterSpacing: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressCards() {
    return Column(
      children: [
        _AwakeningProgressCard(
          icon: Icons.directions_walk_rounded,
          label: 'STEPS',
          current: _currentSteps,
          goal: _stepGoal,
          color: QuestFitColors.emerald,
        ),
        const SizedBox(height: 12),
        _AwakeningProgressCard(
          icon: Icons.local_fire_department_rounded,
          label: 'CALORIES',
          current: _currentCalories,
          goal: _calorieGoal,
          color: QuestFitColors.orangeAccent,
        ),
      ],
    );
  }

  Widget _buildLastSyncLabel() {
    final diff = DateTime.now().difference(_lastSyncTime!);
    String timeAgo;
    if (diff.inMinutes < 1) {
      timeAgo = 'just now';
    } else if (diff.inMinutes < 60) {
      timeAgo = '${diff.inMinutes}m ago';
    } else {
      timeAgo = '${diff.inHours}h ${diff.inMinutes % 60}m ago';
    }

    return Text(
      'Last synced: $timeAgo',
      style: GoogleFonts.inter(
        fontSize: 11,
        color: QuestFitColors.textMuted,
      ),
    );
  }

  Widget _buildLevelDisplay(int level) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: QuestFitColors.glassBorder),
        color: QuestFitColors.bgCard,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shield_outlined,
              size: 16, color: QuestFitColors.purple),
          const SizedBox(width: 8),
          Text(
            'LEVEL $level / 5',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: QuestFitColors.textSecondary,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _requestPermissions,
        style: ElevatedButton.styleFrom(
          backgroundColor: QuestFitColors.purple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(
          'CONNECT HEALTH DATA',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildSyncButton() {
    final stepsMet = _currentSteps >= _stepGoal;
    final caloriesMet = _currentCalories >= _calorieGoal;
    final goalsMet = stepsMet && caloriesMet;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: _isSyncing ? null : _syncHealthData,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isSyncing
                  ? QuestFitColors.bgCard
                  : QuestFitColors.emerald.withValues(alpha: 0.2),
              foregroundColor: QuestFitColors.emerald,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: QuestFitColors.emerald.withValues(alpha: 0.3),
                ),
              ),
              elevation: 0,
            ),
            child: _isSyncing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: QuestFitColors.emerald),
                  )
                : Text(
                    'SYNC HEALTH DATA',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      letterSpacing: 2,
                    ),
                  ),
          ),
        ),
        if (goalsMet) ...[
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _completeAwakening,
              style: ElevatedButton.styleFrom(
                backgroundColor: QuestFitColors.emerald,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                'COMPLETE AWAKENING',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _requestPermissions() async {
    final granted = await ref
        .read(healthSyncNotifierProvider.notifier)
        .requestPermissions();
    if (mounted && granted) {
      _syncHealthData();
    }
  }

  /// READ-ONLY sync: fetches today's steps and calories from Health Connect
  /// without importing workouts or awarding XP.
  Future<void> _syncHealthData() async {
    setState(() => _isSyncing = true);

    try {
      // Re-request permissions to ensure new types (e.g. ACTIVE_ENERGY_BURNED)
      // are granted — the user can't access Settings from the Awakening screen.
      final service = ref.read(healthSyncServiceProvider);
      await service.requestPermissions();

      final summary = await service.getTodayHealthSummary();

      if (mounted) {
        setState(() {
          _currentSteps = summary.steps;
          _currentCalories = summary.calories;
          _lastSyncTime = summary.syncedAt;
          _debugLines = summary.debugInfo;
          _isSyncing = false;
        });

        // Persist progress
        await _saveProgress();
      }
    } catch (e) {
      if (mounted) setState(() => _isSyncing = false);
    }
  }

  Future<void> _completeAwakening() async {
    await ref.read(appInitProvider.notifier).completeAwakening();
  }
}

class _AwakeningProgressCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int current;
  final int goal;
  final Color color;

  const _AwakeningProgressCard({
    required this.icon,
    required this.label,
    required this.current,
    required this.goal,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final progress = goal > 0 ? (current / goal).clamp(0.0, 1.0) : 0.0;
    final met = current >= goal;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: met
            ? color.withValues(alpha: 0.08)
            : QuestFitColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: met
              ? color.withValues(alpha: 0.3)
              : QuestFitColors.glassBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: QuestFitColors.glassBorder,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Text(
            '$current / $goal',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: met ? color : QuestFitColors.textSecondary,
            ),
          ),
          if (met) ...[
            const SizedBox(width: 6),
            Icon(Icons.check_circle, color: color, size: 18),
          ],
        ],
      ),
    );
  }
}
