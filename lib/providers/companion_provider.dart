import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import '../data/exercise_catalog.dart';
import 'database_provider.dart';

// ─── Reactive Streams ────────────────────────────────────────────────

/// Active (unhatched) eggs for the current player.
final activeEggsProvider = StreamProvider<List<Egg>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.eggs)
        ..where((t) => t.hatchedAt.isNull())
        ..orderBy([(t) => OrderingTerm.asc(t.foundAt)]))
      .watch();
});

/// All hatched companions for the current player.
final companionsProvider = StreamProvider<List<Companion>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.companions)
        ..orderBy([(t) => OrderingTerm.desc(t.hatchedAt)]))
      .watch();
});

/// Currently active companion (for buff display).
final activeCompanionProvider = Provider<Companion?>((ref) {
  final companions = ref.watch(companionsProvider).valueOrNull ?? [];
  try {
    return companions.firstWhere((c) => c.isActive);
  } catch (_) {
    return null;
  }
});

/// Active companion's buff info for LP/Gold calculations.
/// Returns {'type': buffType, 'value': buffValue} or null.
final companionBuffProvider = Provider<Map<String, dynamic>?>((ref) {
  final companion = ref.watch(activeCompanionProvider);
  if (companion == null) return null;
  return {'type': companion.buffType, 'value': companion.buffValue};
});

/// Companion LP bonus percentage (0 if no companion or wrong buff type).
final companionLpBonusProvider = Provider<int>((ref) {
  final buff = ref.watch(companionBuffProvider);
  if (buff == null) return 0;
  final type = buff['type'] as String;
  final value = buff['value'] as int;
  if (type == 'lp_bonus' || type == 'all_bonus') return value;
  return 0;
});

/// Companion Gold bonus percentage (0 if no companion or wrong buff type).
final companionGoldBonusProvider = Provider<int>((ref) {
  final buff = ref.watch(companionBuffProvider);
  if (buff == null) return 0;
  final type = buff['type'] as String;
  final value = buff['value'] as int;
  if (type == 'gold_bonus' || type == 'all_bonus') return value;
  return 0;
});

// ─── Companion Notifier ──────────────────────────────────────────────

final companionNotifierProvider =
    NotifierProvider<CompanionNotifier, void>(CompanionNotifier.new);

class CompanionNotifier extends Notifier<void> {
  @override
  void build() {}

  QuestFitDatabase get _db => ref.read(databaseProvider);

  /// Add a new egg to the hatchery.
  Future<void> addEgg(String rarity) async {
    final companion = getRandomCompanion(rarity);
    final stepsReq = eggStepRequirements[rarity] ?? 3000;
    final playerId = await _getPlayerId();

    await _db.into(_db.eggs).insert(EggsCompanion(
      playerId: Value(playerId),
      companionType: Value(companion.type),
      rarity: Value(rarity),
      stepsRequired: Value(stepsReq),
      stepsAccumulated: const Value(0),
    ));
  }

  /// Update egg incubation progress with new steps.
  /// Returns list of hatched egg results.
  Future<List<Companion>> updateEggProgress(int totalStepsToday) async {
    final hatched = <Companion>[];

    try {
      final unhatched = await ((_db.select(_db.eggs))
            ..where((t) => t.hatchedAt.isNull()))
          .get();

      for (final egg in unhatched) {
        // Calculate new steps for this egg (proportional to today's walking)
        // Each egg accumulates steps independently
        final newAccumulated = egg.stepsAccumulated + totalStepsToday;

        if (newAccumulated >= egg.stepsRequired) {
          // Hatch the egg!
          await (_db.update(_db.eggs)
                ..where((t) => t.id.equals(egg.id)))
              .write(EggsCompanion(
            stepsAccumulated: Value(egg.stepsRequired),
            hatchedAt: Value(DateTime.now()),
          ));

          // Create the companion
          final def = getCompanionByType(egg.companionType);
          if (def != null) {
            final companionId =
                await _db.into(_db.companions).insert(CompanionsCompanion(
              playerId: Value(egg.playerId),
              name: Value(def.name),
              type: Value(def.type),
              rarity: Value(def.rarity),
              buffType: Value(def.buffType),
              buffValue: Value(def.buffValue),
              isActive: const Value(false),
            ));

            final companion = await (_db.select(_db.companions)
                  ..where((t) => t.id.equals(companionId)))
                .getSingle();
            hatched.add(companion);
          }
        } else {
          // Update steps accumulated
          await (_db.update(_db.eggs)
                ..where((t) => t.id.equals(egg.id)))
              .write(EggsCompanion(
            stepsAccumulated: Value(newAccumulated),
          ));
        }
      }
    } catch (e) {
      debugPrint('CompanionNotifier.updateEggProgress error: $e');
    }

    return hatched;
  }

  /// Set a companion as the active one (only 1 active at a time).
  Future<void> setActiveCompanion(int companionId) async {
    final playerId = await _getPlayerId();

    // Deactivate all companions
    await (_db.update(_db.companions)
          ..where((t) => t.playerId.equals(playerId)))
        .write(const CompanionsCompanion(isActive: Value(false)));

    // Activate the selected one
    await (_db.update(_db.companions)
          ..where((t) => t.id.equals(companionId)))
        .write(const CompanionsCompanion(isActive: Value(true)));
  }

  /// Deactivate all companions.
  Future<void> deactivateAll() async {
    final playerId = await _getPlayerId();
    await (_db.update(_db.companions)
          ..where((t) => t.playerId.equals(playerId)))
        .write(const CompanionsCompanion(isActive: Value(false)));
  }

  Future<int> _getPlayerId() async {
    final player =
        await ((_db.select(_db.players))..limit(1)).getSingle();
    return player.id;
  }
}
