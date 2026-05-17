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

/// v2.0: Player's current gold balance.
final goldProvider = Provider<AsyncValue<int>>((ref) {
  final playerAsync = ref.watch(playerStreamProvider);
  return playerAsync.whenData((player) => player.gold);
});

/// v2.0: Whether the player has completed the Awakening.
final awakeningCompleteProvider = Provider<AsyncValue<bool>>((ref) {
  final playerAsync = ref.watch(playerStreamProvider);
  return playerAsync.whenData((player) => player.awakeningComplete);
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
  /// v2.0: Supports XP capping at promotion boundaries.
  /// Returns the [XpResult] so callers can react (animations, haptics).
  Future<XpResult> awardXp(int amount) async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();

    // Check if there's a passed trial allowing promotion
    final passedTrial = await (_db.select(_db.rankTrials)
          ..where((t) =>
              t.playerId.equals(player.id) & t.status.equals('passed')))
        .getSingleOrNull();

    final result = XpEngine.addXp(
      currentLevel: player.level,
      currentXp: player.xp,
      totalXp: player.totalXp,
      amount: amount,
      hasActiveTrialOrPassed: passedTrial != null,
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

  /// v2.0: Award gold to the player.
  Future<void> awardGold(int amount) async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();
    await (_db.update(_db.players)
          ..where((t) => t.id.equals(player.id)))
        .write(PlayersCompanion(gold: Value(player.gold + amount)));
  }

  /// v2.0: Spend gold. Returns true if successful.
  Future<bool> spendGold(int amount) async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();
    if (player.gold < amount) return false;
    await (_db.update(_db.players)
          ..where((t) => t.id.equals(player.id)))
        .write(PlayersCompanion(gold: Value(player.gold - amount)));
    return true;
  }

  /// v2.0: Mark the Awakening as complete.
  Future<void> completeAwakening() async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();
    await (_db.update(_db.players)
          ..where((t) => t.id.equals(player.id)))
        .write(const PlayersCompanion(awakeningComplete: Value(true)));
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
