import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import '../engine/gold_engine.dart';
import '../engine/lp_engine.dart';
import '../engine/quest_engine.dart';
import '../engine/rank_engine.dart';
import '../engine/streak_engine.dart';
import 'database_provider.dart';
import 'equipment_provider.dart';
import 'user_provider.dart';

// ─── Result type ─────────────────────────────────────────────────────

/// Result from completing a quest — carries data the UI needs for feedback.
class QuestCompletionResult {
  final int lpAwarded;
  final int goldAwarded;
  final bool isPromotionReady;
  final String tierName;
  final int division;

  const QuestCompletionResult({
    required this.lpAwarded,
    required this.goldAwarded,
    required this.isPromotionReady,
    required this.tierName,
    required this.division,
  });
}

// ─── Reactive Streams ────────────────────────────────────────────────

/// Watches all daily quests (today's rotation).
final dailyQuestsStreamProvider = StreamProvider<List<Quest>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.quests)
        ..where((t) => t.isDaily.equals(true))
        ..orderBy([(t) => OrderingTerm.asc(t.id)]))
      .watch();
});

/// Count of completed quests today.
final completedQuestCountProvider = Provider<AsyncValue<int>>((ref) {
  final questsAsync = ref.watch(dailyQuestsStreamProvider);
  return questsAsync.whenData(
    (quests) => quests.where((q) => q.isCompleted).length,
  );
});

/// Total quest count.
final totalQuestCountProvider = Provider<AsyncValue<int>>((ref) {
  final questsAsync = ref.watch(dailyQuestsStreamProvider);
  return questsAsync.whenData((quests) => quests.length);
});

// ─── Mutations ───────────────────────────────────────────────────────

/// Notifier that handles quest-related write operations.
final questNotifierProvider =
    AsyncNotifierProvider<QuestNotifier, void>(QuestNotifier.new);

class QuestNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  QuestFitDatabase get _db => ref.read(databaseProvider);

  /// Mark a quest as completed and award LP + gold + stat points.
  /// Returns a [QuestCompletionResult] with LP, gold, and promotion info.
  Future<QuestCompletionResult> completeQuest(Quest quest) async {
    if (quest.isCompleted) {
      return const QuestCompletionResult(
          lpAwarded: 0, goldAwarded: 0, isPromotionReady: false,
          tierName: 'iron', division: 4);
    }

    // Get player and streak for bonus calculations
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();
    final streak =
        await ((_db.select(_db.streaks))..limit(1)).getSingle();

    // Get mastery points for this quest's category
    final statKey = QuestEngine.categoryToStat(quest.category);
    final masteryPoints = await ref
        .read(userNotifierProvider.notifier)
        .getMasteryPoints(statKey);

    // Calculate LP reward with mastery and streak bonuses
    final baseLp = quest.lpReward > 0 ? quest.lpReward : LpEngine.baseQuestLp;
    final totalLp = LpEngine.calculateQuestLp(
      baseLp: baseLp,
      masteryPoints: masteryPoints,
      currentStreak: streak.currentStreak,
    );

    // v2.0: Calculate gold reward with streak multiplier
    final goldReward = GoldEngine.calculateReward(
      baseGold: quest.goldReward > 0 ? quest.goldReward : GoldEngine.baseQuestGold,
      currentStreak: streak.currentStreak,
    );

    // Mark quest completed
    await (_db.update(_db.quests)
          ..where((t) => t.id.equals(quest.id)))
        .write(QuestsCompanion(
      isCompleted: const Value(true),
      completedAt: Value(DateTime.now()),
    ));

    // Log the workout
    await _db.into(_db.workoutLogs).insert(WorkoutLogsCompanion(
      questId: Value(quest.id),
      playerId: Value(player.id),
      completedAt: Value(DateTime.now()),
      xpEarned: Value(totalLp), // Store LP in the xpEarned column
      source: const Value('manual'),
    ));

    // Award LP to the player
    final lpResult =
        await ref.read(userNotifierProvider.notifier).awardLp(totalLp);

    // Award gold
    await ref.read(userNotifierProvider.notifier).awardGold(goldReward.totalGold);

    // Award stat point based on category
    await ref.read(userNotifierProvider.notifier).addStat(statKey, 1);

    // Increment total quests completed
    await ref.read(userNotifierProvider.notifier).incrementQuestsCompleted();

    // Update streak
    await _updateStreak();

    return QuestCompletionResult(
      lpAwarded: lpResult.lpGained,
      goldAwarded: goldReward.totalGold,
      isPromotionReady: lpResult.isPromotionReady,
      tierName: player.tier,
      division: player.division,
    );
  }

  /// Undo a quest completion (toggle back to incomplete).
  Future<void> uncompleteQuest(Quest quest) async {
    if (!quest.isCompleted) return;

    await (_db.update(_db.quests)
          ..where((t) => t.id.equals(quest.id)))
        .write(const QuestsCompanion(
      isCompleted: Value(false),
      completedAt: Value(null),
    ));
  }

  /// v3.0: Generate fresh daily quests from equipped loadout.
  /// Falls back to legacy generation if no weapons equipped.
  Future<void> regenerateDaily() async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();
    final tierInfo = RankEngine.getTierInfo(player.tier, player.division);

    // Delete old daily quests
    await (_db.delete(_db.quests)
          ..where((t) => t.isDaily.equals(true)))
        .go();

    // Try to load equipped weapon definitions
    final equippedWeapons =
        await ref.read(equippedWeaponDefsProvider.future);

    // Generate quests from loadout or fallback
    final generated = QuestEngine.generateFromLoadout(
      equippedWeapons: equippedWeapons,
      classType: player.classType,
      tierIndex: tierInfo.tierIndex,
    );

    for (final g in generated) {
      await _db.into(_db.quests).insert(QuestsCompanion(
        title: Value(g.title),
        category: Value(g.category),
        description: Value(g.description),
        sets: Value(g.sets),
        reps: Value(g.reps),
        duration: Value(g.duration),
        xpReward: Value(g.xpReward),
        lpReward: Value(g.lpReward),
        goldReward: Value(g.goldReward),
        isDaily: const Value(true),
        isCompleted: const Value(false),
        createdAt: Value(DateTime.now()),
      ));
    }
  }

  /// v2.0: Reroll daily quests using a consumable.
  /// Returns true if successful.
  Future<bool> rerollDailyQuests() async {
    // Check for quest reroll consumable
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();
    final rerollItem = await (_db.select(_db.inventory)
          ..where((t) =>
              t.playerId.equals(player.id) &
              t.itemKey.equals('quest_reroll')))
        .getSingleOrNull();

    if (rerollItem == null || rerollItem.quantity <= 0) return false;

    // Consume the reroll
    await (_db.update(_db.inventory)
          ..where((t) => t.id.equals(rerollItem.id)))
        .write(InventoryCompanion(quantity: Value(rerollItem.quantity - 1)));

    // Regenerate quests
    await regenerateDaily();
    return true;
  }

  /// Update the streak after completing a quest.
  Future<void> _updateStreak() async {
    final streak =
        await ((_db.select(_db.streaks))..limit(1)).getSingle();

    final update = StreakEngine.checkIn(
      currentStreak: streak.currentStreak,
      longestStreak: streak.longestStreak,
      lastActiveDate: streak.lastActiveDate,
    );

    if (update.didChange) {
      await (_db.update(_db.streaks)
            ..where((t) => t.id.equals(streak.id)))
          .write(StreaksCompanion(
        currentStreak: Value(update.currentStreak),
        longestStreak: Value(update.longestStreak),
        lastActiveDate: Value(update.lastActiveDate),
      ));
    }
  }
}
