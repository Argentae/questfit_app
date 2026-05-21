// QuestFit v2.3 — Bounty Board Screen
// The daily bounty combat lifecycle: Draft → Combat → Victory/Defeat.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../db/database.dart';
import '../data/enemy_catalog.dart';
import '../engine/combat_engine.dart';
import '../providers/bounty_provider.dart';
import '../providers/database_provider.dart';
import '../providers/routine_provider.dart';
import '../services/haptic_service.dart';

class BountyBoardScreen extends ConsumerStatefulWidget {
  const BountyBoardScreen({super.key});

  @override
  ConsumerState<BountyBoardScreen> createState() => _BountyBoardScreenState();
}

class _BountyBoardScreenState extends ConsumerState<BountyBoardScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bountyAsync = ref.watch(activeBountyProvider);

    return Scaffold(
      backgroundColor: QuestFitColors.bgDark,
      body: SafeArea(
        child: bountyAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: QuestFitColors.emerald),
          ),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (bounty) {
            if (bounty == null) {
              return _buildNoBounty();
            }
            switch (bounty.status) {
              case 'drafting':
                return _buildDraftState(bounty);
              case 'combat':
              case 'preparing':
                return _buildCombatState(bounty);
              case 'victory':
                return _buildVictoryState(bounty);
              case 'defeat':
                return _buildDefeatState(bounty);
              default:
                return _buildDraftState(bounty);
            }
          },
        ),
      ),
    );
  }

  // ─── NO BOUNTY ─────────────────────────────────────────────────────

  Widget _buildNoBounty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('⚔️', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(
            'No bounty for today',
            style: GoogleFonts.cinzel(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: QuestFitColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Generating draft...',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: QuestFitColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  // ─── DRAFT STATE ───────────────────────────────────────────────────

  Widget _buildDraftState(Bounty bounty) {
    final draftAsync = ref.watch(draftedEnemiesProvider);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: goldGradientShader,
                  child: Text(
                    'BOUNTY BOARD',
                    style: GoogleFonts.cinzel(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Choose your target wisely, warrior.',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: QuestFitColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        draftAsync.when(
          loading: () => const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => SliverToBoxAdapter(child: Text('Error: $e')),
          data: (enemies) => SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _EnemyDraftCard(
                    enemy: enemies[index],
                    pulseController: _pulseController,
                    onLockIn: () => _lockInEnemy(enemies[index]),
                  ),
                ),
                childCount: enemies.length,
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Future<void> _lockInEnemy(Enemy enemy) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: QuestFitColors.bgCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Lock In ${enemy.name}?',
          style: GoogleFonts.cinzel(
            color: QuestFitColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'This choice is final for today. Failing to defeat this enemy will cost you ${enemy.lpPenalty} LP.',
          style: GoogleFonts.inter(color: QuestFitColors.textSecondary, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel', style: TextStyle(color: QuestFitColors.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: QuestFitColors.emerald,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('LOCK IN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      HapticService.onQuestComplete();
      await ref.read(bountyNotifierProvider.notifier).lockInEnemy(enemy.id);
    }
  }

  // ─── COMBAT STATE ──────────────────────────────────────────────────

  Widget _buildCombatState(Bounty bounty) {
    final enemyAsync = ref.watch(activeEnemyProvider);
    final routineAsync = ref.watch(routineExercisesProvider);
    final hpPercent = ref.watch(enemyHpPercentProvider);

    return enemyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (enemy) {
        if (enemy == null) return _buildNoBounty();

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    ShaderMask(
                      shaderCallback: goldGradientShader,
                      child: Text(
                        'ACTIVE HUNT',
                        style: GoogleFonts.cinzel(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Enemy card
                    _buildEnemyCombatCard(enemy, bounty, hpPercent),
                    const SizedBox(height: 20),

                    // Damage preview
                    _buildDamagePreview(bounty, enemy),
                    const SizedBox(height: 20),

                    // Routine header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'YOUR ROUTINE',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                                color: QuestFitColors.textMuted,
                                letterSpacing: 3,
                              ),
                            ),
                            const SizedBox(width: 8),
                            routineAsync.when(
                              data: (exercises) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: QuestFitColors.emerald.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${exercises.where((e) => e.isCompleted).length}/${exercises.length}',
                                  style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w700,
                                    color: QuestFitColors.emerald,
                                  ),
                                ),
                              ),
                              loading: () => const SizedBox.shrink(),
                              error: (_, __) => const SizedBox.shrink(),
                            ),
                          ],
                        ),
                        TextButton.icon(
                          onPressed: () => _importRoutine(bounty.id),
                          icon: const Icon(Icons.download_rounded, color: QuestFitColors.emerald, size: 16),
                          label: const Text('IMPORT DECK', style: TextStyle(color: QuestFitColors.emerald, fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // Routine exercise list
            routineAsync.when(
              loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SliverToBoxAdapter(child: Text('Error: $e')),
              data: (exercises) {
                if (exercises.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: QuestFitColors.bgCard,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: QuestFitColors.glassBorder),
                        ),
                        child: Column(
                          children: [
                            const Text('📋', style: TextStyle(fontSize: 40)),
                            const SizedBox(height: 12),
                            Text(
                              'Build your routine to defeat the enemy!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: QuestFitColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildAddExerciseButton(bounty),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == exercises.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 100),
                            child: _buildAddExerciseButton(bounty),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _RoutineExerciseCard(
                            routineExercise: exercises[index],
                            enemy: enemy,
                            onToggle: () => _toggleExercise(exercises[index]),
                          ),
                        );
                      },
                      childCount: exercises.length + 1,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildEnemyCombatCard(Enemy enemy, Bounty bounty, double hpPercent) {
    final elemColor = Color(Elements.color[enemy.elementType] ?? 0xFF8B8B8B);
    final elemEmoji = Elements.emoji[enemy.elementType] ?? '❓';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: QuestFitColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: bounty.currentHp <= 0
              ? QuestFitColors.gold.withValues(alpha: 0.5)
              : elemColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: bounty.currentHp <= 0
            ? [BoxShadow(color: QuestFitColors.gold.withValues(alpha: 0.15), blurRadius: 20)]
            : null,
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Enemy image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    enemy.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: elemColor.withValues(alpha: 0.1),
                      child: Center(
                        child: Text(enemy.emoji, style: const TextStyle(fontSize: 48)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      enemy.name,
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: QuestFitColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildBadge(elemEmoji, enemy.elementType.toUpperCase(), elemColor),
                        const SizedBox(width: 6),
                        _buildBadge(
                          difficultyEmoji[enemy.difficulty] ?? '⚪',
                          enemy.difficulty.toUpperCase(),
                          Color(difficultyColor[enemy.difficulty] ?? 0xFF8B8B8B),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // HP text
                    Text(
                      bounty.currentHp <= 0
                          ? '💀 DEFEATED!'
                          : '${bounty.currentHp} / ${enemy.hp} HP',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: bounty.currentHp <= 0
                            ? QuestFitColors.gold
                            : QuestFitColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // HP Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 12,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                child: LinearProgressIndicator(
                  value: hpPercent,
                  backgroundColor: Colors.grey.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _hpBarColor(hpPercent),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _hpBarColor(double percent) {
    if (percent > 0.6) return const Color(0xFF2DD4A8);
    if (percent > 0.35) return const Color(0xFFF0C850);
    if (percent > 0.15) return const Color(0xFFFF6B35);
    return const Color(0xFFFF4444);
  }

  Widget _buildDamagePreview(Bounty bounty, Enemy enemy) {
    final totalDamage = ref.watch(totalDamageDealtProvider);
    final damageProgress = (totalDamage / enemy.hp).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: QuestFitColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: QuestFitColors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DAMAGE DEALT',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  color: QuestFitColors.textMuted,
                  letterSpacing: 2,
                ),
              ),
              Text(
                '$totalDamage / ${enemy.hp}',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: damageProgress >= 1.0
                      ? QuestFitColors.gold
                      : QuestFitColors.emerald,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: damageProgress,
              backgroundColor: Colors.grey.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                damageProgress >= 1.0 ? QuestFitColors.gold : QuestFitColors.emerald,
              ),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddExerciseButton(Bounty bounty) {
    return GestureDetector(
      onTap: () => _showExercisePicker(bounty),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: QuestFitColors.emerald.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: QuestFitColors.emerald.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_rounded, color: QuestFitColors.emerald, size: 20),
            const SizedBox(width: 8),
            Text(
              'ADD EXERCISE',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: QuestFitColors.emerald,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleExercise(RoutineExercise routineEx) async {
    HapticService.onQuestComplete();
    if (routineEx.isCompleted) {
      await ref.read(bountyNotifierProvider.notifier).uncompleteExercise(routineEx.id);
    } else {
      final damage = await ref.read(bountyNotifierProvider.notifier).completeExercise(routineEx.id);
      if (mounted && damage > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('⚔️ Dealt $damage damage!'),
            backgroundColor: QuestFitColors.emerald,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _showExercisePicker(Bounty bounty) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => _ExercisePickerPage(bountyId: bounty.id),
      ),
    );
  }

  // ─── VICTORY STATE ─────────────────────────────────────────────────

  Widget _buildVictoryState(Bounty bounty) {
    final enemyAsync = ref.watch(activeEnemyProvider);

    return enemyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (enemy) {
        if (enemy == null) return _buildNoBounty();
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: goldGradientShader,
                  child: Text(
                    '⚔️ VICTORY! ⚔️',
                    style: GoogleFonts.cinzel(
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: 140, height: 140,
                    child: Image.asset(
                      enemy.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Text(enemy.emoji, style: const TextStyle(fontSize: 72)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  enemy.name,
                  style: GoogleFonts.cinzel(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: QuestFitColors.textMuted,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(height: 24),
                _rewardRow('⚡', '+${enemy.lpReward} LP', QuestFitColors.emerald),
                const SizedBox(height: 8),
                _rewardRow('🪙', '+${enemy.goldReward} Gold', QuestFitColors.gold),
                const SizedBox(height: 8),
                _rewardRow('🔥', 'Streak preserved!', QuestFitColors.textSecondary),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _rewardRow(String emoji, String text, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    );
  }

  // ─── DEFEAT STATE ──────────────────────────────────────────────────

  Widget _buildDefeatState(Bounty bounty) {
    final enemyAsync = ref.watch(activeEnemyProvider);

    return enemyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (enemy) {
        if (enemy == null) return _buildNoBounty();
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '💀 DEFEAT 💀',
                  style: GoogleFonts.cinzel(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: const Color(0xFFFF4444),
                  ),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: 140, height: 140,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Color(0x80FF0000),
                        BlendMode.overlay,
                      ),
                      child: Image.asset(
                        enemy.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Text(enemy.emoji, style: const TextStyle(fontSize: 72)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  enemy.name,
                  style: GoogleFonts.cinzel(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: QuestFitColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 24),
                _rewardRow('💔', '-${enemy.lpPenalty} LP', const Color(0xFFFF4444)),
                const SizedBox(height: 8),
                _rewardRow('💥', 'Streak broken', const Color(0xFFFF6B35)),
                const SizedBox(height: 32),
                Text(
                  'Train harder tomorrow, warrior.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: QuestFitColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── Helpers ───────────────────────────────────────────────────────

  Widget _buildBadge(String emoji, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 10)),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Enemy Draft Card ────────────────────────────────────────────────

class _EnemyDraftCard extends StatelessWidget {
  final Enemy enemy;
  final AnimationController pulseController;
  final VoidCallback onLockIn;

  const _EnemyDraftCard({
    required this.enemy,
    required this.pulseController,
    required this.onLockIn,
  });

  @override
  Widget build(BuildContext context) {
    final elemColor = Color(Elements.color[enemy.elementType] ?? 0xFF8B8B8B);
    final elemEmoji = Elements.emoji[enemy.elementType] ?? '❓';
    final diffColor = Color(difficultyColor[enemy.difficulty] ?? 0xFF8B8B8B);
    final diffEmoji = difficultyEmoji[enemy.difficulty] ?? '⚪';

    final weaknesses = (jsonDecode(enemy.weaknesses) as List).cast<String>();
    final resistances = (jsonDecode(enemy.resistances) as List).cast<String>();
    final immunities = (jsonDecode(enemy.immunities) as List).cast<String>();

    return Container(
      decoration: BoxDecoration(
        color: QuestFitColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: elemColor.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: image + info
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    width: 80, height: 80,
                    child: Image.asset(
                      enemy.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: elemColor.withValues(alpha: 0.1),
                        child: Center(
                          child: Text(enemy.emoji, style: const TextStyle(fontSize: 36)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        enemy.name,
                        style: GoogleFonts.cinzel(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: QuestFitColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        enemy.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: QuestFitColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: elemColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$elemEmoji ${enemy.elementType.toUpperCase()}',
                              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: elemColor),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: diffColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$diffEmoji ${enemy.difficulty.toUpperCase()}',
                              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: diffColor),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '❤️ ${enemy.hp} HP',
                            style: GoogleFonts.inter(
                              fontSize: 11, fontWeight: FontWeight.w700,
                              color: QuestFitColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Weaknesses & Resistances
            if (weaknesses.isNotEmpty) ...[
              _chipRow('WEAK TO', weaknesses, const Color(0xFF2DD4A8)),
              const SizedBox(height: 6),
            ],
            if (resistances.isNotEmpty) ...[
              _chipRow('RESISTS', resistances, const Color(0xFFFF6B35)),
              const SizedBox(height: 6),
            ],
            if (immunities.isNotEmpty) ...[
              _chipRow('IMMUNE', immunities, const Color(0xFF8B8B8B)),
              const SizedBox(height: 6),
            ],

            // Stat prerequisite
            if (enemy.requiredStat != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0C850).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '⚠️ Requires ${enemy.requiredStatValue} ${enemy.requiredStat!.toUpperCase()}',
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFFF0C850)),
                ),
              ),
              const SizedBox(height: 10),
            ],

            // Rewards & Risk
            const Divider(color: QuestFitColors.glassBorder, height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '⚡ +${enemy.lpReward} LP  🪙 +${enemy.goldReward} Gold',
                  style: GoogleFonts.inter(
                    fontSize: 12, fontWeight: FontWeight.w700,
                    color: QuestFitColors.emerald,
                  ),
                ),
                Text(
                  '💀 -${enemy.lpPenalty} LP',
                  style: GoogleFonts.inter(
                    fontSize: 12, fontWeight: FontWeight.w700,
                    color: const Color(0xFFFF4444),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // LOCK IN button
            AnimatedBuilder(
              animation: pulseController,
              builder: (context, child) {
                final scale = 1.0 + (pulseController.value * 0.02);
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onLockIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: diffColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 4,
                  ),
                  child: Text(
                    '⚔️  LOCK IN',
                    style: GoogleFonts.cinzel(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chipRow(String label, List<String> items, Color color) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: color, letterSpacing: 1),
        ),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              item,
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: color),
            ),
          ),
        )),
      ],
    );
  }
}

// ─── Routine Exercise Card ───────────────────────────────────────────

class _RoutineExerciseCard extends ConsumerWidget {
  final RoutineExercise routineExercise;
  final Enemy enemy;
  final VoidCallback onToggle;

  const _RoutineExerciseCard({
    required this.routineExercise,
    required this.enemy,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.read(databaseProvider);

    return FutureBuilder<ExerciseDbData>(
      future: (db.select(db.exerciseDb)
            ..where((t) => t.id.equals(routineExercise.exerciseDbId)))
          .getSingle(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(height: 60);
        }
        final exercise = snapshot.data!;

        // Calculate potential damage
        final weaknesses = (jsonDecode(enemy.weaknesses) as List).cast<String>();
        final resistances = (jsonDecode(enemy.resistances) as List).cast<String>();
        final immunities = (jsonDecode(enemy.immunities) as List).cast<String>();

        final dmg = CombatEngine.calculateExerciseDamage(
          sets: routineExercise.sets,
          reps: routineExercise.reps,
          duration: routineExercise.duration,
          exerciseLevel: exercise.level,
          exerciseCategory: exercise.category,
          weaknesses: weaknesses,
          resistances: resistances,
          immunities: immunities,
        );

        String effectivenessEmoji;
        switch (dmg.effectiveness) {
          case 'super_effective':
            effectivenessEmoji = '🟢';
            break;
          case 'not_effective':
            effectivenessEmoji = '🔴';
            break;
          case 'immune':
            effectivenessEmoji = '⛔';
            break;
          default:
            effectivenessEmoji = '⚪';
        }

        String desc;
        if (routineExercise.reps != null) {
          desc = '${routineExercise.sets} × ${routineExercise.reps} reps';
        } else if (routineExercise.duration != null) {
          desc = '${routineExercise.duration} min';
        } else {
          desc = '${routineExercise.sets} sets';
        }

        return GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: routineExercise.isCompleted
                  ? QuestFitColors.emerald.withValues(alpha: 0.08)
                  : QuestFitColors.bgCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: routineExercise.isCompleted
                    ? QuestFitColors.emerald.withValues(alpha: 0.3)
                    : QuestFitColors.glassBorder,
              ),
            ),
            child: Row(
              children: [
                // Checkbox
                Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: routineExercise.isCompleted
                        ? QuestFitColors.emerald
                        : Colors.transparent,
                    border: Border.all(
                      color: routineExercise.isCompleted
                          ? QuestFitColors.emerald
                          : QuestFitColors.textMuted,
                      width: 2,
                    ),
                  ),
                  child: routineExercise.isCompleted
                      ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: routineExercise.isCompleted
                              ? QuestFitColors.textMuted
                              : QuestFitColors.textPrimary,
                          decoration: routineExercise.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      Text(
                        desc,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: QuestFitColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      routineExercise.isCompleted
                          ? '${routineExercise.damageDealt}'
                          : '${dmg.totalDamage}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: routineExercise.isCompleted
                            ? QuestFitColors.emerald
                            : QuestFitColors.textPrimary,
                      ),
                    ),
                    Text(
                      '$effectivenessEmoji DMG',
                      style: const TextStyle(fontSize: 10, color: QuestFitColors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─── Exercise Picker Bottom Sheet ────────────────────────────────────

class _ExercisePickerPage extends ConsumerStatefulWidget {
  final int bountyId;
  const _ExercisePickerPage({required this.bountyId});

  @override
  ConsumerState<_ExercisePickerPage> createState() => _ExercisePickerPageState();
}

class _ExercisePickerPageState extends ConsumerState<_ExercisePickerPage> {
  String _search = '';
  String? _categoryFilter;
  List<ExerciseDbData>? _exercises;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadExercises());
  }

  Future<void> _loadExercises() async {
    try {
      final db = ref.read(databaseProvider);
      final results = await _queryExercises(db);
      debugPrint('QF_PICKER: Loaded ${results.length} exercises');
      if (mounted) {
        setState(() {
          _exercises = results;
          _loading = false;
        });
      }
    } catch (e, s) {
      debugPrint('QF_PICKER: Error loading exercises: $e');
      debugPrint('QF_PICKER: Stack: $s');
      if (mounted) {
        setState(() {
          _exercises = [];
          _loading = false;
        });
      }
    }
  }

  void _applyFilter(String? category) {
    setState(() {
      _categoryFilter = category;
      _loading = true;
    });
    _loadExercises();
  }

  void _applySearch(String query) {
    setState(() {
      _search = query.toLowerCase();
      _loading = true;
    });
    _loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QuestFitColors.bgDark,
      appBar: AppBar(
        backgroundColor: QuestFitColors.bgDark,
        foregroundColor: QuestFitColors.textPrimary,
        elevation: 0,
        title: Text(
          'ADD EXERCISE',
          style: GoogleFonts.cinzel(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: QuestFitColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: QuestFitColors.bgCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: QuestFitColors.glassBorder),
              ),
              child: TextField(
                style: const TextStyle(color: QuestFitColors.textPrimary, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Search exercises...',
                  hintStyle: TextStyle(color: QuestFitColors.textMuted, fontSize: 14),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: QuestFitColors.textMuted, size: 20),
                ),
                onChanged: _applySearch,
              ),
            ),
          ),
          // Category filter
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _filterChip('All', null),
                _filterChip('Strength', 'strength'),
                _filterChip('Cardio', 'cardio'),
                _filterChip('Flexibility', 'stretching'),
                _filterChip('Plyometrics', 'plyometrics'),
                _filterChip('Powerlifting', 'powerlifting'),
                _filterChip('Strongman', 'strongman'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Exercise list
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator(color: QuestFitColors.emerald))
                : (_exercises == null || _exercises!.isEmpty)
                    ? Center(
                        child: Text(
                          'No exercises found',
                          style: GoogleFonts.inter(color: QuestFitColors.textMuted),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _exercises!.length,
                        itemBuilder: (context, index) {
                          final ex = _exercises![index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: QuestFitColors.bgCard,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: QuestFitColors.glassBorder),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                              title: Text(
                                ex.name,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: QuestFitColors.textPrimary,
                                ),
                              ),
                              subtitle: Text(
                                '${ex.category} · ${ex.level} · ${ex.equipment ?? "body only"}',
                                style: GoogleFonts.inter(fontSize: 11, color: QuestFitColors.textSecondary),
                              ),
                              trailing: const Icon(Icons.add_circle_outline, color: QuestFitColors.emerald),
                              onTap: () => _showSetRepDialog(ex),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, String? value) {
    final selected = _categoryFilter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: GestureDetector(
        onTap: () => _applyFilter(value),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? QuestFitColors.emerald.withValues(alpha: 0.15) : QuestFitColors.bgCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? QuestFitColors.emerald.withValues(alpha: 0.4) : QuestFitColors.glassBorder,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w600,
              color: selected ? QuestFitColors.emerald : QuestFitColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }

  Future<List<ExerciseDbData>> _queryExercises(QuestFitDatabase db) async {
    var query = db.select(db.exerciseDb);
    if (_categoryFilter != null) {
      query = query..where((t) => t.category.equals(_categoryFilter!));
    }
    final all = await (query..limit(100)).get();

    if (_search.isEmpty) return all;
    return all.where((e) => e.name.toLowerCase().contains(_search)).toList();
  }

  void _showSetRepDialog(ExerciseDbData exercise) {
    final setsController = TextEditingController(text: '3');
    final repsController = TextEditingController(text: '10');
    final durationController = TextEditingController(text: '15');
    final isCardio = exercise.category == 'cardio' || exercise.category == 'stretching';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: QuestFitColors.bgCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          exercise.name,
          style: GoogleFonts.cinzel(
            color: QuestFitColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isCardio) ...[
              _inputField('Sets', setsController),
              const SizedBox(height: 10),
              _inputField('Reps', repsController),
            ] else ...[
              _inputField('Duration (min)', durationController),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: QuestFitColors.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: QuestFitColors.emerald,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () async {
              final sets = int.tryParse(setsController.text) ?? 3;
              final reps = isCardio ? null : (int.tryParse(repsController.text) ?? 10);
              final duration = isCardio ? (int.tryParse(durationController.text) ?? 15) : null;

              await ref.read(bountyNotifierProvider.notifier).addExerciseToRoutine(
                bountyId: widget.bountyId,
                exerciseDbId: exercise.id,
                sets: sets,
                reps: reps,
                duration: duration,
              );

              if (context.mounted) Navigator.pop(context);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('ADD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: QuestFitColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: QuestFitColors.textMuted),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: QuestFitColors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: QuestFitColors.emerald),
        ),
      ),
    );
  }
}
