import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import 'database_provider.dart';

// ─── Exercise Library Providers ──────────────────────────────────────

/// All exercises from the expanded database.
final allExercisesProvider = StreamProvider<List<ExerciseDbData>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.exerciseDb)
        ..orderBy([(t) => OrderingTerm.asc(t.name)]))
      .watch();
});

/// Total exercise count.
final exerciseCountProvider = Provider<int>((ref) {
  return ref.watch(allExercisesProvider).valueOrNull?.length ?? 0;
});

// ─── Filter State ────────────────────────────────────────────────────

/// Filter state for the Grimoire screen.
class ExerciseFilter {
  final String? category;
  final String? equipment;
  final String? level;
  final String? muscle;

  const ExerciseFilter({this.category, this.equipment, this.level, this.muscle});

  ExerciseFilter copyWith({
    String? category,
    String? equipment,
    String? level,
    String? muscle,
    bool clearCategory = false,
    bool clearEquipment = false,
    bool clearLevel = false,
    bool clearMuscle = false,
  }) {
    return ExerciseFilter(
      category: clearCategory ? null : (category ?? this.category),
      equipment: clearEquipment ? null : (equipment ?? this.equipment),
      level: clearLevel ? null : (level ?? this.level),
      muscle: clearMuscle ? null : (muscle ?? this.muscle),
    );
  }
}

/// Notifier for exercise filter state.
class ExerciseFilterNotifier extends Notifier<ExerciseFilter> {
  @override
  ExerciseFilter build() => const ExerciseFilter();

  void setCategory(String? category) {
    state = state.copyWith(
      category: category,
      clearCategory: category == null,
    );
  }

  void setEquipment(String? equipment) {
    state = state.copyWith(
      equipment: equipment,
      clearEquipment: equipment == null,
    );
  }

  void setLevel(String? level) {
    state = state.copyWith(
      level: level,
      clearLevel: level == null,
    );
  }

  void setMuscle(String? muscle) {
    state = state.copyWith(
      muscle: muscle,
      clearMuscle: muscle == null,
    );
  }

  void clearAll() {
    state = const ExerciseFilter();
  }
}

final exerciseFilterProvider =
    NotifierProvider<ExerciseFilterNotifier, ExerciseFilter>(
        ExerciseFilterNotifier.new);

/// Search query for exercises.
final exerciseSearchProvider = StateProvider<String>((ref) => '');

// ─── Filtered Exercises ──────────────────────────────────────────────

/// Filtered + searched exercise list (reactive).
final filteredExercisesProvider =
    Provider<AsyncValue<List<ExerciseDbData>>>((ref) {
  final allExercises = ref.watch(allExercisesProvider);
  final filter = ref.watch(exerciseFilterProvider);
  final search = ref.watch(exerciseSearchProvider).toLowerCase().trim();

  return allExercises.whenData((exercises) {
    var filtered = exercises;

    // Category filter
    if (filter.category != null) {
      filtered =
          filtered.where((e) => e.category == filter.category).toList();
    }

    // Equipment filter
    if (filter.equipment != null) {
      filtered =
          filtered.where((e) => e.equipment == filter.equipment).toList();
    }

    // Level filter
    if (filter.level != null) {
      filtered = filtered.where((e) => e.level == filter.level).toList();
    }

    // Muscle filter
    if (filter.muscle != null) {
      filtered = filtered
          .where((e) => e.primaryMuscles
              .toLowerCase()
              .contains(filter.muscle!.toLowerCase()))
          .toList();
    }

    // Search filter
    if (search.isNotEmpty) {
      filtered = filtered
          .where((e) =>
              e.name.toLowerCase().contains(search) ||
              e.primaryMuscles.toLowerCase().contains(search) ||
              (e.equipment?.toLowerCase().contains(search) ?? false))
          .toList();
    }

    return filtered;
  });
});

// ─── Unique Values for Filter Chips ──────────────────────────────────

/// Unique category values from the exercise database.
final availableCategoriesProvider = Provider<List<String>>((ref) {
  final exercises = ref.watch(allExercisesProvider).valueOrNull ?? [];
  final categories = exercises.map((e) => e.category).toSet().toList();
  categories.sort();
  return categories;
});

/// Unique equipment values from the exercise database.
final availableEquipmentProvider = Provider<List<String>>((ref) {
  final exercises = ref.watch(allExercisesProvider).valueOrNull ?? [];
  final equipment = exercises
      .where((e) => e.equipment != null)
      .map((e) => e.equipment!)
      .toSet()
      .toList();
  equipment.sort();
  return equipment;
});

/// Unique primary muscle values from the exercise database.
final availableMusclesProvider = Provider<List<String>>((ref) {
  final exercises = ref.watch(allExercisesProvider).valueOrNull ?? [];
  final muscles = <String>{};
  for (final e in exercises) {
    for (final m in e.primaryMuscles.split(',')) {
      final trimmed = m.trim();
      if (trimmed.isNotEmpty) muscles.add(trimmed);
    }
  }
  final sorted = muscles.toList()..sort();
  return sorted;
});
