import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import '../engine/rank_engine.dart';
import '../engine/xp_engine.dart';
import 'database_provider.dart';

// ─── Reactive Streams ────────────────────────────────────────────────

/// Watches the first (and only) player row.
final playerStreamProvider = StreamProvider<Player>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.players)..limit(1))
      .watchSingle();
});

/// Watches the player's stats row.
final statsStreamProvider = StreamProvider<Stat>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.stats)..limit(1))
      .watchSingle();
});

/// Watches the player's streak row.
final streakStreamProvider = StreamProvider<Streak>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.streaks)..limit(1))
      .watchSingle();
});

// ─── Derived / Computed Providers ────────────────────────────────────

/// Current XP progress (bar data).
final xpProgressProvider = Provider<AsyncValue<XpProgress>>((ref) {
  final playerAsync = ref.watch(playerStreamProvider);
  return playerAsync.whenData(
    (player) => XpEngine.getProgress(player.level, player.xp),
  );
});

/// Current rank info derived from player level.
final rankInfoProvider = Provider<AsyncValue<RankInfo>>((ref) {
  final playerAsync = ref.watch(playerStreamProvider);
  return playerAsync.whenData(
    (player) => RankEngine.getRank(player.level),
  );
});

// ─── Mutations ───────────────────────────────────────────────────────

/// Notifier that handles all player-write operations.
final userNotifierProvider =
    AsyncNotifierProvider<UserNotifier, void>(UserNotifier.new);

class UserNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  QuestFitDatabase get _db => ref.read(databaseProvider);

  /// Award XP to the player, handling level-ups and rank changes.
  /// Returns the [XpResult] so callers can react (animations, haptics).
  Future<XpResult> awardXp(int amount) async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();

    final result = XpEngine.addXp(
      currentLevel: player.level,
      currentXp: player.xp,
      totalXp: player.totalXp,
      amount: amount,
    );

    // Update player row
    await (_db.update(_db.players)
          ..where((t) => t.id.equals(player.id)))
        .write(PlayersCompanion(
      level: Value(result.newLevel),
      xp: Value(result.newXp),
      totalXp: Value(result.totalXp),
      rank: Value(RankEngine.getRankKey(result.newLevel)),
    ));

    // Record rank-up if applicable
    if (RankEngine.didRankUp(player.level, result.newLevel)) {
      await _db.into(_db.rankHistory).insert(RankHistoryCompanion(
        playerId: Value(player.id),
        rank: Value(RankEngine.getRankKey(result.newLevel)),
        achievedAt: Value(DateTime.now()),
      ));
    }

    return result;
  }

  /// Increment a specific stat (str, end, agi) by [amount].
  Future<void> addStat(String statName, int amount) async {
    final stat =
        await ((_db.select(_db.stats))..limit(1)).getSingle();

    StatsCompanion companion;
    switch (statName) {
      case 'str':
        companion = StatsCompanion(
          str: Value(stat.str + amount),
          updatedAt: Value(DateTime.now()),
        );
        break;
      case 'end':
        companion = StatsCompanion(
          end: Value(stat.end + amount),
          updatedAt: Value(DateTime.now()),
        );
        break;
      case 'agi':
        companion = StatsCompanion(
          agi: Value(stat.agi + amount),
          updatedAt: Value(DateTime.now()),
        );
        break;
      default:
        return;
    }

    await (_db.update(_db.stats)
          ..where((t) => t.id.equals(stat.id)))
        .write(companion);
  }

  /// Update the player's name.
  Future<void> updateName(String name) async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();
    await (_db.update(_db.players)
          ..where((t) => t.id.equals(player.id)))
        .write(PlayersCompanion(name: Value(name)));
  }

  /// Update the player's class type.
  Future<void> updateClassType(String classType) async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();
    await (_db.update(_db.players)
          ..where((t) => t.id.equals(player.id)))
        .write(PlayersCompanion(classType: Value(classType)));
  }

  /// Check if a player profile exists.
  Future<bool> hasProfile() async {
    final rows = await _db.select(_db.players).get();
    return rows.isNotEmpty;
  }
}
