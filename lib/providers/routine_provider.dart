import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../db/database.dart';
import 'database_provider.dart';
import 'user_provider.dart';

// ─── Routine Data Models ─────────────────────────────────────────────

class RoutineData {
  final Routine routine;
  final List<RoutineBuilderExerciseData> exercises;

  RoutineData({required this.routine, required this.exercises});
}

class RoutineBuilderExerciseData {
  final RoutineBuilderExercise builderExercise;
  final ExerciseDbData exerciseDef;

  RoutineBuilderExerciseData({required this.builderExercise, required this.exerciseDef});
}

// ─── Providers ───────────────────────────────────────────────────────

/// Watches all saved routines for the current player.
final routinesProvider = StreamProvider<List<RoutineData>>((ref) {
  final db = ref.watch(databaseProvider);
  final playerAsync = ref.watch(playerStreamProvider);

  return playerAsync.when(
    data: (player) {
      // 1. Watch all routines for the player
      final routinesStream = (db.select(db.routines)
            ..where((t) => t.playerId.equals(player.id))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

      // 2. For each emitted list of routines, fetch their exercises
      return routinesStream.asyncMap((routinesList) async {
        final result = <RoutineData>[];
        
        for (final r in routinesList) {
          // Fetch the builder exercises joined with exerciseDb
          final query = db.select(db.routineBuilderExercises).join([
            innerJoin(
                db.exerciseDb,
                db.exerciseDb.id.equalsExp(db.routineBuilderExercises.exerciseDbId))
          ])
            ..where(db.routineBuilderExercises.routineId.equals(r.id))
            ..orderBy([OrderingTerm.asc(db.routineBuilderExercises.sortOrder)]);

          final rows = await query.get();
          final exercises = rows.map((row) {
            return RoutineBuilderExerciseData(
              builderExercise: row.readTable(db.routineBuilderExercises),
              exerciseDef: row.readTable(db.exerciseDb),
            );
          }).toList();

          result.add(RoutineData(routine: r, exercises: exercises));
        }

        return result;
      });
    },
    loading: () => const Stream.empty(),
    error: (_, __) => const Stream.empty(),
  );
});

// ─── Routine Actions ─────────────────────────────────────────────────

final routineActionsProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return RoutineActions(db);
});

class RoutineActions {
  final QuestFitDatabase _db;
  RoutineActions(this._db);

  /// Create a new routine with a list of exercises
  Future<void> createRoutine({
    required int playerId,
    required String name,
    required String description,
    required List<ExerciseDbData> exercises,
  }) async {
    await _db.transaction(() async {
      // 1. Insert Routine
      final routineId = await _db.into(_db.routines).insert(
        RoutinesCompanion.insert(
          playerId: playerId,
          name: name,
          description: Value(description),
        ),
      );

      // 2. Insert Exercises
      for (int i = 0; i < exercises.length; i++) {
        final ex = exercises[i];
        await _db.into(_db.routineBuilderExercises).insert(
          RoutineBuilderExercisesCompanion.insert(
            routineId: routineId,
            exerciseDbId: ex.id,
            sets: const Value(3), // Default 3 sets
            sortOrder: Value(i),
          ),
        );
      }
    });
  }

  /// Delete a routine
  Future<void> deleteRoutine(int routineId) async {
    await _db.transaction(() async {
      // 1. Delete exercises
      await (_db.delete(_db.routineBuilderExercises)
            ..where((t) => t.routineId.equals(routineId)))
          .go();
      
      // 2. Delete routine
      await (_db.delete(_db.routines)
            ..where((t) => t.id.equals(routineId)))
          .go();
    });
  }
}
