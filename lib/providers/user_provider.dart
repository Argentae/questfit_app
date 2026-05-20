import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import '../engine/lp_engine.dart';
import '../engine/rank_engine.dart';
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

/// v3.0: Current LP progress (bar data, 0–100).
final lpProgressProvider = Provider<AsyncValue<LpProgress>>((ref) {
  final playerAsync = ref.watch(playerStreamProvider);
  return playerAsync.whenData(
    (player) => LpEngine.getProgress(player.lp),
  );
});

/// v3.0: Current tier info derived from player's tier/division.
final tierInfoProvider = Provider<AsyncValue<TierInfo>>((ref) {
  final playerAsync = ref.watch(playerStreamProvider);
  return playerAsync.whenData(
    (player) => RankEngine.getTierInfo(player.tier, player.division),
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

/// v3.0: Whether a promotion is pending (LP reached 100).
final pendingPromotionProvider = Provider<AsyncValue<bool>>((ref) {
  final playerAsync = ref.watch(playerStreamProvider);
  return playerAsync.whenData((player) => player.pendingPromotion);
});

/// v3.0: Total quests completed (vanity stat).
final totalQuestsCompletedProvider = Provider<AsyncValue<int>>((ref) {
  final playerAsync = ref.watch(playerStreamProvider);
  return playerAsync.whenData((player) => player.totalQuestsCompleted);
});

// ─── Legacy Providers (kept for backward compat) ─────────────────────

/// @deprecated Use tierInfoProvider instead.
final rankInfoProvider = Provider<AsyncValue<TierInfo>>((ref) {
  return ref.watch(tierInfoProvider);
});

/// @deprecated Use lpProgressProvider instead.
final xpProgressProvider = Provider<AsyncValue<LpProgress>>((ref) {
  return ref.watch(lpProgressProvider);
});

// ─── Mutations ───────────────────────────────────────────────────────

/// Notifier that handles all player-write operations.
final userNotifierProvider =
    AsyncNotifierProvider<UserNotifier, void>(UserNotifier.new);

class UserNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  QuestFitDatabase get _db => ref.read(databaseProvider);

  /// v3.0: Award LP to the player.
  /// Returns an [LpResult] so callers can react (animations, haptics).
  Future<LpResult> awardLp(int amount) async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();

    final result = LpEngine.addLp(
      currentLp: player.lp,
      amount: amount,
    );

    // Update player row
    final companion = PlayersCompanion(
      lp: Value(result.newLp),
      lastActivityAt: Value(DateTime.now()),
    );

    // If LP hit 100, mark pending promotion
    if (result.isPromotionReady) {
      await (_db.update(_db.players)
            ..where((t) => t.id.equals(player.id)))
          .write(PlayersCompanion(
        lp: Value(result.newLp),
        lastActivityAt: Value(DateTime.now()),
        pendingPromotion: const Value(true),
      ));
    } else {
      await (_db.update(_db.players)
            ..where((t) => t.id.equals(player.id)))
          .write(companion);
    }

    return result;
  }

  /// v3.0: Process a pending promotion — advance to next division/tier.
  /// Called on app launch when pendingPromotion is true.
  Future<bool> processPromotion() async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();

    if (!player.pendingPromotion) return false;

    final next = RankEngine.getNextRank(player.tier, player.division);
    if (next == null) {
      // Already at max rank, clear pending flag
      await (_db.update(_db.players)
            ..where((t) => t.id.equals(player.id)))
          .write(const PlayersCompanion(
        pendingPromotion: Value(false),
      ));
      return false;
    }

    // Promote!
    await (_db.update(_db.players)
          ..where((t) => t.id.equals(player.id)))
        .write(PlayersCompanion(
      tier: Value(next.tier),
      division: Value(next.division),
      lp: const Value(0), // Reset LP in new division
      pendingPromotion: const Value(false),
      rank: Value('${next.tier}_${next.division}'),
    ));

    // Record rank history
    await _db.into(_db.rankHistory).insert(RankHistoryCompanion(
      playerId: Value(player.id),
      rank: Value('${next.tier}_${next.division}'),
      achievedAt: Value(DateTime.now()),
    ));

    return true;
  }

  /// v3.0: Apply LP decay for inactivity (48h without training).
  /// Returns decay result, or null if no decay needed.
  Future<LpDecayResult?> applyInactivityDecay() async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();

    if (!RankEngine.shouldDecay(player.lastActivityAt)) return null;

    final decayAmount = RankEngine.getDecayAmount(player.tier);
    final result = LpEngine.removeLp(
      currentLp: player.lp,
      amount: decayAmount,
    );

    if (result.shouldDemote) {
      // Demotion!
      final prev = RankEngine.getPreviousRank(player.tier, player.division);
      if (prev != null) {
        await (_db.update(_db.players)
              ..where((t) => t.id.equals(player.id)))
            .write(PlayersCompanion(
          tier: Value(prev.tier),
          division: Value(prev.division),
          lp: Value(result.newLp), // Landing LP (75)
          pendingPromotion: const Value(false),
          rank: Value('${prev.tier}_${prev.division}'),
        ));
      } else {
        // Already at Iron IV, just set LP to 0
        await (_db.update(_db.players)
              ..where((t) => t.id.equals(player.id)))
            .write(const PlayersCompanion(
          lp: Value(0),
          pendingPromotion: Value(false),
        ));
      }
    } else {
      await (_db.update(_db.players)
            ..where((t) => t.id.equals(player.id)))
          .write(PlayersCompanion(
        lp: Value(result.newLp),
        pendingPromotion: const Value(false),
      ));
    }

    return result;
  }

  /// v2.3: Apply a direct LP penalty (from bounty defeat).
  /// Similar to inactivity decay but with a fixed amount.
  Future<LpDecayResult> applyLpPenalty(int amount) async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();

    final result = LpEngine.removeLp(
      currentLp: player.lp,
      amount: amount,
    );

    if (result.shouldDemote) {
      final prev = RankEngine.getPreviousRank(player.tier, player.division);
      if (prev != null) {
        await (_db.update(_db.players)
              ..where((t) => t.id.equals(player.id)))
            .write(PlayersCompanion(
          tier: Value(prev.tier),
          division: Value(prev.division),
          lp: Value(result.newLp),
          pendingPromotion: const Value(false),
          rank: Value('${prev.tier}_${prev.division}'),
        ));
      } else {
        await (_db.update(_db.players)
              ..where((t) => t.id.equals(player.id)))
            .write(const PlayersCompanion(
          lp: Value(0),
          pendingPromotion: Value(false),
        ));
      }
    } else {
      await (_db.update(_db.players)
            ..where((t) => t.id.equals(player.id)))
          .write(PlayersCompanion(
        lp: Value(result.newLp),
        pendingPromotion: const Value(false),
      ));
    }

    return result;
  }

  /// v3.0: Increment total quests completed counter.
  Future<void> incrementQuestsCompleted() async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();
    await (_db.update(_db.players)
          ..where((t) => t.id.equals(player.id)))
        .write(PlayersCompanion(
      totalQuestsCompleted: Value(player.totalQuestsCompleted + 1),
    ));
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

  /// Get the mastery points for a given stat key.
  Future<int> getMasteryPoints(String statKey) async {
    final stat =
        await ((_db.select(_db.stats))..limit(1)).getSingle();
    switch (statKey) {
      case 'str':
        return stat.str;
      case 'end':
        return stat.end;
      case 'agi':
        return stat.agi;
      default:
        return 0;
    }
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

  /// v2.2: Update the player's daily step goal.
  Future<void> updateStepGoal(int goal) async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();
    await (_db.update(_db.players)
          ..where((t) => t.id.equals(player.id)))
        .write(PlayersCompanion(dailyStepGoal: Value(goal)));
  }
}
