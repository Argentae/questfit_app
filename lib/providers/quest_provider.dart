import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import '../engine/quest_engine.dart';
import '../engine/streak_engine.dart';
import 'database_provider.dart';
import 'user_provider.dart';

// ─── Result type ─────────────────────────────────────────────────────

/// Result from completing a quest — carries data the UI needs for feedback.
class QuestCompletionResult {
  final int xpAwarded;
  final bool didLevelUp;
  final int newLevel;

  const QuestCompletionResult({
    required this.xpAwarded,
    required this.didLevelUp,
    required this.newLevel,
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

  /// Mark a quest as completed and award XP + stat points.
  /// Returns a [QuestCompletionResult] with XP and level-up info.
  Future<QuestCompletionResult> completeQuest(Quest quest) async {
    if (quest.isCompleted) {
      return const QuestCompletionResult(
          xpAwarded: 0, didLevelUp: false, newLevel: 0);
    }

    // Get streak multiplier
    final streak =
        await ((_db.select(_db.streaks))..limit(1)).getSingle();
    final multiplier = StreakEngine.getMultiplier(streak.currentStreak);
    final xp = QuestEngine.completeQuest(quest.xpReward, multiplier);

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

    // Award stat point based on category
    final stat = QuestEngine.categoryToStat(quest.category);
    await ref.read(userNotifierProvider.notifier).addStat(stat, 1);

    // Update streak
    await _updateStreak();

    return QuestCompletionResult(
      xpAwarded: xp,
      didLevelUp: xpResult.didLevelUp,
      newLevel: xpResult.newLevel,
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

  /// Generate fresh daily quests (clears old ones and inserts new).
  Future<void> regenerateDaily() async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();

    // Delete old daily quests
    await (_db.delete(_db.quests)
          ..where((t) => t.isDaily.equals(true)))
        .go();

    // Generate new quests from engine
    final generated = QuestEngine.generateDaily(
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
        isDaily: const Value(true),
        isCompleted: const Value(false),
        createdAt: Value(DateTime.now()),
      ));
    }
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
