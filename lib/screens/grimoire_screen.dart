import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../db/database.dart';
import '../data/exercise_catalog.dart';
import '../providers/exercise_library_provider.dart';
import '../widgets/exercise_detail_sheet.dart';

/// v2.2: The Grimoire — browse 800+ exercises with search and filters.
class GrimoireScreen extends ConsumerStatefulWidget {
  const GrimoireScreen({super.key});

  @override
  ConsumerState<GrimoireScreen> createState() => _GrimoireScreenState();
}

class _GrimoireScreenState extends ConsumerState<GrimoireScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(filteredExercisesProvider);
    final filter = ref.watch(exerciseFilterProvider);
    final totalCount = ref.watch(exerciseCountProvider);

    return Scaffold(
      backgroundColor: QuestFitColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: QuestFitColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Builder(
          builder: (context) {
            return Text(
              'GRIMOIRE',
              style: GoogleFonts.cinzel(
                fontSize: 22, fontWeight: FontWeight.w900,
                foreground: Paint()..shader = goldGradientShader(
                  const Rect.fromLTWH(0, 0, 200, 30)),
              ),
            );
          },
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text('$totalCount exercises',
                  style: const TextStyle(
                      color: QuestFitColors.textMuted, fontSize: 12)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              decoration: glassCard(borderRadius: 12),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: QuestFitColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search exercises...',
                  hintStyle: const TextStyle(color: QuestFitColors.textMuted),
                  prefixIcon: const Icon(Icons.search, color: QuestFitColors.textMuted),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: QuestFitColors.textMuted, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            ref.read(exerciseSearchProvider.notifier).state = '';
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onChanged: (v) =>
                    ref.read(exerciseSearchProvider.notifier).state = v,
              ),
            ),
          ),

          // Favorites toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _FilterChip(
                  label: '❤️ Favorites Only',
                  isSelected: filter.favoritesOnly,
                  color: QuestFitColors.redAccent,
                  onTap: () => ref.read(exerciseFilterProvider.notifier).toggleFavoritesOnly(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Filter chips
          _buildFilterRow('Category', filter.category,
              ['strength', 'cardio', 'stretching', 'plyometrics', 'powerlifting', 'olympic weightlifting', 'strongman'],
              (v) => ref.read(exerciseFilterProvider.notifier).setCategory(v)),
          const SizedBox(height: 4),
          _buildFilterRow('Level', filter.level,
              ['beginner', 'intermediate', 'expert'],
              (v) => ref.read(exerciseFilterProvider.notifier).setLevel(v)),
          const SizedBox(height: 4),
          _buildFilterRow('Equipment', filter.equipment,
              ['body only', 'barbell', 'dumbbell', 'cable', 'machine', 'kettlebells', 'bands'],
              (v) => ref.read(exerciseFilterProvider.notifier).setEquipment(v)),

          const SizedBox(height: 8),

          // Exercise list
          Expanded(
            child: exercisesAsync.when(
              loading: () => const Center(
                  child: CircularProgressIndicator(color: QuestFitColors.emerald)),
              error: (e, _) => Center(
                  child: Text('Error: $e',
                      style: const TextStyle(color: QuestFitColors.redAccent))),
              data: (exercises) {
                if (exercises.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('📖', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text('No exercises found',
                            style: TextStyle(
                                color: QuestFitColors.textSecondary,
                                fontSize: 16)),
                        const SizedBox(height: 4),
                        TextButton(
                          onPressed: () {
                            _searchController.clear();
                            ref.read(exerciseSearchProvider.notifier).state = '';
                            ref.read(exerciseFilterProvider.notifier).clearAll();
                          },
                          child: const Text('Clear filters',
                              style: TextStyle(color: QuestFitColors.emerald)),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) =>
                      _ExerciseCard(exercise: exercises[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow(String label, String? selected, List<String> options,
      void Function(String?) onSelect) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _FilterChip(
            label: 'All',
            isSelected: selected == null,
            onTap: () => onSelect(null),
          ),
          ...options.map((o) => _FilterChip(
                label: _capitalize(o),
                isSelected: selected == o,
                color: _categoryColor(o),
                onTap: () => onSelect(selected == o ? null : o),
              )),
        ],
      ),
    );
  }

  static Color _categoryColor(String category) {
    switch (category) {
      case 'strength':
      case 'powerlifting':
      case 'strongman':
        return QuestFitColors.redAccent;
      case 'cardio':
      case 'plyometrics':
        return QuestFitColors.blueAccent;
      case 'stretching':
        return QuestFitColors.purple;
      case 'olympic weightlifting':
        return QuestFitColors.orangeAccent;
      case 'expert':
        return QuestFitColors.redAccent;
      case 'intermediate':
        return QuestFitColors.orangeAccent;
      case 'beginner':
        return QuestFitColors.emerald;
      default:
        return QuestFitColors.emerald;
    }
  }

  static String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    this.color = QuestFitColors.emerald,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? color.withValues(alpha: 0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? color : QuestFitColors.glassBorder,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? color : QuestFitColors.textSecondary,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final ExerciseDbData exercise;

  const _ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    final questCat = categoryMapping[exercise.category] ?? exercise.category;
    final catEmoji = categoryEmojis[exercise.category] ?? '⚔️';
    final levelStars = exercise.level == 'expert'
        ? '⭐⭐⭐'
        : exercise.level == 'intermediate'
            ? '⭐⭐'
            : '⭐';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => _showDetail(context),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: glassCard(borderRadius: 12),
          child: Row(
            children: [
              // Category emoji
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: _catColor(questCat).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text(catEmoji, style: const TextStyle(fontSize: 18))),
              ),
              const SizedBox(width: 12),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(exercise.name,
                        style: const TextStyle(
                            color: QuestFitColors.textPrimary,
                            fontWeight: FontWeight.w600, fontSize: 14),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _badge(exercise.category, _catColor(questCat)),
                        const SizedBox(width: 6),
                        if (exercise.equipment != null)
                          _badge(exercise.equipment!, QuestFitColors.textMuted),
                        const Spacer(),
                        Text(levelStars, style: const TextStyle(fontSize: 10)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      exercise.primaryMuscles.replaceAll(',', ', '),
                      style: const TextStyle(
                          color: QuestFitColors.textMuted, fontSize: 11),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: QuestFitColors.textMuted, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text,
          style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600)),
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

  void _showDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ExerciseDetailSheet(exercise: exercise),
    );
  }
}
