import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../db/database.dart';
import '../providers/exercise_library_provider.dart';
import '../data/exercise_catalog.dart';

class ExercisePickerScreen extends ConsumerStatefulWidget {
  final List<ExerciseDbData> initialSelection;
  const ExercisePickerScreen({super.key, required this.initialSelection});

  @override
  ConsumerState<ExercisePickerScreen> createState() => _ExercisePickerScreenState();
}

class _ExercisePickerScreenState extends ConsumerState<ExercisePickerScreen> {
  final _searchController = TextEditingController();
  late Set<int> _selectedIds;
  late Map<int, ExerciseDbData> _selectedMap;

  @override
  void initState() {
    super.initState();
    _selectedIds = widget.initialSelection.map((e) => e.id).toSet();
    _selectedMap = {for (var e in widget.initialSelection) e.id: e};
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggle(ExerciseDbData ex) {
    setState(() {
      if (_selectedIds.contains(ex.id)) {
        _selectedIds.remove(ex.id);
        _selectedMap.remove(ex.id);
      } else {
        _selectedIds.add(ex.id);
        _selectedMap[ex.id] = ex;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(filteredExercisesProvider);

    return Scaffold(
      backgroundColor: QuestFitColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: QuestFitColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'PICK EXERCISES',
          style: GoogleFonts.cinzel(
            fontSize: 18, fontWeight: FontWeight.w900,
            foreground: Paint()..shader = goldGradientShader(const Rect.fromLTWH(0, 0, 200, 30)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(_selectedMap.values.toList());
            },
            child: Text('DONE (${_selectedIds.length})', 
                style: const TextStyle(color: QuestFitColors.emerald, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              decoration: glassCard(borderRadius: 12),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: QuestFitColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: QuestFitColors.textMuted),
                  prefixIcon: const Icon(Icons.search, color: QuestFitColors.textMuted),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onChanged: (v) => ref.read(exerciseSearchProvider.notifier).state = v,
              ),
            ),
          ),
          Expanded(
            child: exercisesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator(color: QuestFitColors.emerald)),
              error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: QuestFitColors.redAccent))),
              data: (exercises) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final ex = exercises[index];
                    final isSelected = _selectedIds.contains(ex.id);
                    return _PickerCard(
                      exercise: ex,
                      isSelected: isSelected,
                      onTap: () => _toggle(ex),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PickerCard extends StatelessWidget {
  final ExerciseDbData exercise;
  final bool isSelected;
  final VoidCallback onTap;

  const _PickerCard({required this.exercise, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final questCat = categoryMapping[exercise.category] ?? exercise.category;
    final catColor = _catColor(questCat);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? QuestFitColors.emerald.withValues(alpha: 0.1) : QuestFitColors.bgDark.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? QuestFitColors.emerald : QuestFitColors.glassBorder,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected ? QuestFitColors.emerald : QuestFitColors.textMuted,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(exercise.name, style: const TextStyle(color: QuestFitColors.textPrimary, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(exercise.primaryMuscles, style: const TextStyle(color: QuestFitColors.textMuted, fontSize: 11)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: catColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(questCat, style: TextStyle(color: catColor, fontSize: 10, fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ),
      ),
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
}
