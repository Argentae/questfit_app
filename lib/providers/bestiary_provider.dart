import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../db/database.dart';
import 'database_provider.dart';
import 'user_provider.dart';

class BestiaryEntry {
  final Enemy enemy;
  final BestiaryData? stats;

  BestiaryEntry({required this.enemy, this.stats});
}

/// Watches all Bestiary entries for the current player.
final bestiaryProvider = StreamProvider<List<BestiaryEntry>>((ref) {
  final db = ref.watch(databaseProvider);
  final playerAsync = ref.watch(playerStreamProvider);

  return playerAsync.when(
    data: (player) {
      // Stream all enemies, left joining their bestiary stats
      final query = db.select(db.enemies).join([
        leftOuterJoin(
            db.bestiary,
            db.bestiary.enemyId.equalsExp(db.enemies.id) &
                db.bestiary.playerId.equals(player.id))
      ])..orderBy([OrderingTerm.asc(db.enemies.id)]);

      return query.watch().map((rows) {
        return rows.map((row) {
          return BestiaryEntry(
            enemy: row.readTable(db.enemies),
            stats: row.readTableOrNull(db.bestiary),
          );
        }).toList();
      });
    },
    loading: () => const Stream.empty(),
    error: (_, __) => const Stream.empty(),
  );
});
