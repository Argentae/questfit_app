import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../db/database.dart';
import '../providers/routine_provider.dart';
import '../providers/user_provider.dart';
import 'exercise_picker_screen.dart';

class RoutineBuilderScreen extends ConsumerStatefulWidget {
  const RoutineBuilderScreen({super.key});

  @override
  ConsumerState<RoutineBuilderScreen> createState() => _RoutineBuilderScreenState();
}

class _RoutineBuilderScreenState extends ConsumerState<RoutineBuilderScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  List<ExerciseDbData> _selectedExercises = [];

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _save() async {
    if (_nameController.text.trim().isEmpty) return;
    if (_selectedExercises.isEmpty) return;

    final playerAsync = ref.read(playerStreamProvider).valueOrNull;
    if (playerAsync == null) return;

    await ref.read(routineActionsProvider).createRoutine(
          playerId: playerAsync.id,
          name: _nameController.text.trim(),
          description: _descController.text.trim(),
          exercises: _selectedExercises,
        );

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
          'FORGE DECK',
          style: GoogleFonts.cinzel(
            fontSize: 20, fontWeight: FontWeight.w900,
            foreground: Paint()..shader = goldGradientShader(const Rect.fromLTWH(0, 0, 200, 30)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _nameController.text.isNotEmpty && _selectedExercises.isNotEmpty ? _save : null,
            child: const Text('SAVE', style: TextStyle(color: QuestFitColors.emerald, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _nameController,
            style: const TextStyle(color: QuestFitColors.textPrimary, fontSize: 18),
            decoration: InputDecoration(
              labelText: 'Deck Name',
              labelStyle: const TextStyle(color: QuestFitColors.textMuted),
              filled: true,
              fillColor: QuestFitColors.bgDark.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descController,
            style: const TextStyle(color: QuestFitColors.textPrimary),
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Description (Optional)',
              labelStyle: const TextStyle(color: QuestFitColors.textMuted),
              filled: true,
              fillColor: QuestFitColors.bgDark.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('EXERCISES (${_selectedExercises.length})', 
                  style: GoogleFonts.cinzel(color: QuestFitColors.gold, fontWeight: FontWeight.bold)),
              TextButton.icon(
                icon: const Icon(Icons.add, color: QuestFitColors.emerald),
                label: const Text('ADD', style: TextStyle(color: QuestFitColors.emerald)),
                onPressed: () async {
                  final result = await Navigator.of(context).push<List<ExerciseDbData>>(
                    MaterialPageRoute(builder: (_) => ExercisePickerScreen(initialSelection: _selectedExercises)),
                  );
                  if (result != null) {
                    setState(() {
                      _selectedExercises = result;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_selectedExercises.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: glassCard(borderRadius: 12),
              child: const Center(
                child: Text('Tap ADD to select exercises from the Grimoire.', 
                    style: TextStyle(color: QuestFitColors.textMuted), textAlign: TextAlign.center),
              ),
            )
          else
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _selectedExercises.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final item = _selectedExercises.removeAt(oldIndex);
                  _selectedExercises.insert(newIndex, item);
                });
              },
              itemBuilder: (context, index) {
                final ex = _selectedExercises[index];
                return Container(
                  key: ValueKey(ex.id),
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: glassCard(borderRadius: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.drag_handle, color: QuestFitColors.textMuted),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(ex.name, style: const TextStyle(color: QuestFitColors.textPrimary)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: QuestFitColors.redAccent),
                        onPressed: () {
                          setState(() {
                            _selectedExercises.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
