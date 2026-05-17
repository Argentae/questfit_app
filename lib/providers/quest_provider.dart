import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import '../engine/gold_engine.dart';
import '../engine/quest_engine.dart';
import '../engine/streak_engine.dart';
import 'database_provider.dart';
import 'equipment_provider.dart';
import 'user_provider.dart';

// ─── Result type ─────────────────────────────────────────────────────

/// Result from completing a quest — carries data the UI needs for feedback.
class QuestCompletionResult {
  final int xpAwarded;
  final int goldAwarded;
  final bool didLevelUp;
  final int newLevel;
  final bool isXpCapped;

  const QuestCompletionResult({
    required this.xpAwarded,
    required this.goldAwarded,
    required this.didLevelUp,
    required this.newLevel,
    this.isXpCapped = false,
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

  /// Mark a quest as completed and award XP + gold + stat points.
  /// Returns a [QuestCompletionResult] with XP, gold, and level-up info.
  Future<QuestCompletionResult> completeQuest(Quest quest) async {
    if (quest.isCompleted) {
      return const QuestCompletionResult(
          xpAwarded: 0, goldAwarded: 0, didLevelUp: false, newLevel: 0);
    }

    // Get streak multiplier
    final streak =
        await ((_db.select(_db.streaks))..limit(1)).getSingle();
    final xpMultiplier = StreakEngine.getMultiplier(streak.currentStreak);
    final xp = QuestEngine.completeQuest(quest.xpReward, xpMultiplier);

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
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();
    await _db.into(_db.workoutLogs).insert(WorkoutLogsCompanion(
      questId: Value(quest.id),
      playerId: Value(player.id),
      completedAt: Value(DateTime.now()),
      xpEarned: Value(xp),
      source: const Value('manual'),
    ));

    // Award XP to the player
    final xpResult =
        await ref.read(userNotifierProvider.notifier).awardXp(xp);

    // Award gold
    await ref.read(userNotifierProvider.notifier).awardGold(goldReward.totalGold);

    // Award stat point based on category
    final stat = QuestEngine.categoryToStat(quest.category);
    await ref.read(userNotifierProvider.notifier).addStat(stat, 1);

    // Update streak
    await _updateStreak();

    return QuestCompletionResult(
      xpAwarded: xp,
      goldAwarded: goldReward.totalGold,
      didLevelUp: xpResult.didLevelUp,
      newLevel: xpResult.newLevel,
      isXpCapped: xpResult.isXpCapped,
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

  /// v2.0: Generate fresh daily quests from equipped loadout.
  /// Falls back to legacy generation if no weapons equipped.
  Future<void> regenerateDaily() async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();

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
      playerLevel: player.level,
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
