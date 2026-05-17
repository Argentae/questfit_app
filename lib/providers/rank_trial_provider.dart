import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import '../engine/rank_engine.dart';
import 'database_provider.dart';
import 'user_provider.dart';

// ─── v3.0: Simplified Rank Provider ──────────────────────────────────
// Promotion series have been removed (LoL removed promos too).
// Reaching 100 LP auto-promotes on next app launch.
// This provider now only handles rank display and progression info.

/// Derived: Whether the player has a pending promotion (LP = 100).
final isPromotionPendingProvider = Provider<AsyncValue<bool>>((ref) {
  final playerAsync = ref.watch(playerStreamProvider);
  return playerAsync.whenData((player) => player.pendingPromotion);
});

/// Derived: The next rank the player will promote into.
final nextRankProvider = Provider<AsyncValue<({String tier, int division})?>>((ref) {
  final playerAsync = ref.watch(playerStreamProvider);
  return playerAsync.whenData(
    (player) => RankEngine.getNextRank(player.tier, player.division),
  );
});

/// Derived: Overall ladder progress (0–totalPositions).
final ladderProgressProvider = Provider<AsyncValue<({int current, int total})>>((ref) {
  final playerAsync = ref.watch(playerStreamProvider);
  return playerAsync.whenData((player) {
    final current = RankEngine.getRankPosition(player.tier, player.division);
    return (current: current, total: RankEngine.totalPositions);
  });
});

/// Derived: Rank history stream.
final rankHistoryProvider = StreamProvider<List<RankHistoryData>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.rankHistory)
        ..orderBy([(t) => OrderingTerm.desc(t.achievedAt)])
        ..limit(20))
      .watch();
});
