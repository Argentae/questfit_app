import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../providers/routine_provider.dart';
import 'routine_builder_screen.dart';

/// v2.5: Custom Loadouts (Battle Decks) screen.
class RoutinesScreen extends ConsumerWidget {
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(routinesProvider);

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
          'BATTLE DECKS',
          style: GoogleFonts.cinzel(
            fontSize: 22, fontWeight: FontWeight.w900,
            foreground: Paint()..shader = goldGradientShader(
              const Rect.fromLTWH(0, 0, 200, 30)),
          ),
        ),
      ),
      body: routinesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: QuestFitColors.emerald)),
        error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: QuestFitColors.redAccent))),
        data: (routines) {
          if (routines.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🎴', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 12),
                  const Text('No decks created yet',
                      style: TextStyle(color: QuestFitColors.textSecondary, fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text('Build a custom deck of exercises for quick combat.',
                      style: TextStyle(color: QuestFitColors.textMuted, fontSize: 13),
                      textAlign: TextAlign.center),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: routines.length,
            itemBuilder: (context, index) {
              final r = routines[index];
              return _RoutineCard(routineData: r);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: QuestFitColors.emerald,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const RoutineBuilderScreen()),
          );
        },
        icon: const Icon(Icons.add, color: QuestFitColors.bgDark),
        label: const Text('CREATE DECK', style: TextStyle(color: QuestFitColors.bgDark, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _RoutineCard extends ConsumerWidget {
  final RoutineData routineData;

  const _RoutineCard({required this.routineData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: glassCard(borderRadius: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(routineData.routine.name,
                  style: const TextStyle(color: QuestFitColors.gold, fontSize: 18, fontWeight: FontWeight.w800)),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: QuestFitColors.redAccent, size: 20),
                onPressed: () {
                  ref.read(routineActionsProvider).deleteRoutine(routineData.routine.id);
                },
              ),
            ],
          ),
          if (routineData.routine.description.isNotEmpty) ...[
            Text(routineData.routine.description,
                style: const TextStyle(color: QuestFitColors.textMuted, fontSize: 13)),
            const SizedBox(height: 12),
          ],
          const Divider(color: QuestFitColors.glassBorder),
          const SizedBox(height: 8),
          Text('${routineData.exercises.length} Exercises',
              style: const TextStyle(color: QuestFitColors.emerald, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: routineData.exercises.take(5).map((e) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: QuestFitColors.bgDark.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(e.exerciseDef.name, style: const TextStyle(color: QuestFitColors.textSecondary, fontSize: 11)),
              );
            }).toList(),
          ),
          if (routineData.exercises.length > 5) ...[
            const SizedBox(height: 8),
            Text('+ ${routineData.exercises.length - 5} more',
                style: const TextStyle(color: QuestFitColors.textMuted, fontSize: 11)),
          ]
        ],
      ),
    );
  }
}
