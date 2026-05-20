import 'dart:convert';
import 'package:flutter/material.dart';
import '../app/theme.dart';
import '../db/database.dart';
import '../data/exercise_catalog.dart';

/// Modal bottom sheet showing full exercise details from the Grimoire.
class ExerciseDetailSheet extends StatelessWidget {
  final ExerciseDbData exercise;

  const ExerciseDetailSheet({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final questCat = categoryMapping[exercise.category] ?? exercise.category;
    final catColor = _catColor(questCat);
    final instructions = _parseInstructions(exercise.instructions);
    final primaryMuscles = exercise.primaryMuscles.split(',').where((s) => s.trim().isNotEmpty).toList();
    final secondaryMuscles = exercise.secondaryMuscles.split(',').where((s) => s.trim().isNotEmpty).toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.85,
      minChildSize: 0.4,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: QuestFitColors.bgDark,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: const Border(
            top: BorderSide(color: QuestFitColors.glassBorder, width: 1),
            left: BorderSide(color: QuestFitColors.glassBorder, width: 1),
            right: BorderSide(color: QuestFitColors.glassBorder, width: 1),
          ),
        ),
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: QuestFitColors.textMuted,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Exercise name
            Text(
              exercise.name,
              style: TextStyle(
                color: catColor,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),

            // Tags row
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                _tag(exercise.category, catColor),
                _tag(exercise.level, _levelColor(exercise.level)),
                if (exercise.equipment != null) _tag(exercise.equipment!, QuestFitColors.textSecondary),
                if (exercise.force != null) _tag(exercise.force!, QuestFitColors.textMuted),
                if (exercise.mechanic != null) _tag(exercise.mechanic!, QuestFitColors.textMuted),
              ],
            ),
            const SizedBox(height: 20),

            // Primary muscles
            _sectionTitle('Primary Muscles'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: primaryMuscles.map((m) => _muscleChip(m.trim(), catColor)).toList(),
            ),

            // Secondary muscles
            if (secondaryMuscles.isNotEmpty) ...[
              const SizedBox(height: 16),
              _sectionTitle('Secondary Muscles'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: secondaryMuscles.map((m) => _muscleChip(m.trim(), QuestFitColors.textMuted)).toList(),
              ),
            ],

            // Instructions
            if (instructions.isNotEmpty) ...[
              const SizedBox(height: 20),
              _sectionTitle('Instructions'),
              const SizedBox(height: 10),
              ...instructions.asMap().entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24, height: 24,
                          decoration: BoxDecoration(
                            color: catColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text('${entry.key + 1}',
                                style: TextStyle(
                                    color: catColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: const TextStyle(
                                color: QuestFitColors.textSecondary,
                                fontSize: 13,
                                height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(text,
        style: const TextStyle(
            color: QuestFitColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 1));
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Text(text,
          style: TextStyle(
              color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget _muscleChip(String muscle, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(muscle,
          style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500)),
    );
  }

  Color _catColor(String cat) {
    switch (cat) {
      case 'strength': return QuestFitColors.redAccent;
      case 'cardio': return QuestFitColors.blueAccent;
      case 'flexibility': return QuestFitColors.purple;
      default: return QuestFitColors.emerald;
    }
  }

  Color _levelColor(String level) {
    switch (level) {
      case 'expert': return QuestFitColors.redAccent;
      case 'intermediate': return QuestFitColors.orangeAccent;
      default: return QuestFitColors.emerald;
    }
  }

  List<String> _parseInstructions(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) return decoded.cast<String>();
    } catch (_) {}
    return raw.isNotEmpty ? [raw] : [];
  }
}
