import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import '../data/weapon_catalog.dart';
import 'database_provider.dart';

// ─── Reactive Streams ────────────────────────────────────────────────

/// Watches all equipment the player owns.
final ownedEquipmentProvider = StreamProvider<List<EquipmentData>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.equipment)
        ..where((t) => t.isOwned.equals(true))
        ..orderBy([
          (t) => OrderingTerm.asc(t.id),
        ]))
      .watch();
});

/// Watches ALL equipment (for shop display).
final allEquipmentProvider = StreamProvider<List<EquipmentData>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.equipment)
        ..orderBy([
          (t) => OrderingTerm.asc(t.price),
          (t) => OrderingTerm.asc(t.id),
        ]))
      .watch();
});

/// Watches the player's equipped slots (max 3).
final equippedSlotsProvider = StreamProvider<List<EquippedSlot>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.equippedSlots)
        ..orderBy([(t) => OrderingTerm.asc(t.slotIndex)]))
      .watch();
});

/// Watches exercises linked to a specific equipment piece.
final equipmentExercisesProvider =
    StreamProvider.family<List<EquipmentExercise>, int>((ref, equipmentId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.equipmentExercises)
        ..where((t) => t.equipmentId.equals(equipmentId)))
      .watch();
});

/// Derived: Get the WeaponDef objects for currently equipped weapons.
/// This is used by QuestEngine.generateFromLoadout().
final equippedWeaponDefsProvider = FutureProvider<List<WeaponDef>>((ref) async {
  final db = ref.read(databaseProvider);
  final slots = await (db.select(db.equippedSlots)
        ..orderBy([(t) => OrderingTerm.asc(t.slotIndex)]))
      .get();

  if (slots.isEmpty) return [];

  final defs = <WeaponDef>[];
  for (final slot in slots) {
    final equip = await (db.select(db.equipment)
          ..where((t) => t.id.equals(slot.equipmentId)))
        .getSingleOrNull();
    if (equip != null) {
      // Find the matching WeaponDef from catalog
      final def = weaponCatalog.firstWhere(
        (w) => w.key == equip.key,
        orElse: () => weaponCatalog.first,
      );
      defs.add(def);
    }
  }
  return defs;
});

// ─── Mutations ───────────────────────────────────────────────────────

final equipmentNotifierProvider =
    AsyncNotifierProvider<EquipmentNotifier, void>(EquipmentNotifier.new);

class EquipmentNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  QuestFitDatabase get _db => ref.read(databaseProvider);

  /// Equip a weapon into a specific slot (1-3).
  /// Removes any existing weapon in that slot first.
  Future<void> equipWeapon(int equipmentId, int slotIndex) async {
    final player = await ((_db.select(_db.players))..limit(1)).getSingle();

    // Remove existing weapon in this slot
    await (_db.delete(_db.equippedSlots)
          ..where((t) =>
              t.playerId.equals(player.id) &
              t.slotIndex.equals(slotIndex)))
        .go();

    // Also remove this weapon from any other slot
    await (_db.delete(_db.equippedSlots)
          ..where((t) =>
              t.playerId.equals(player.id) &
              t.equipmentId.equals(equipmentId)))
        .go();

    // Insert into slot
    await _db.into(_db.equippedSlots).insert(EquippedSlotsCompanion(
      playerId: Value(player.id),
      slotIndex: Value(slotIndex),
      equipmentId: Value(equipmentId),
    ));
  }

  /// Unequip a weapon from a slot.
  Future<void> unequipSlot(int slotIndex) async {
    final player = await ((_db.select(_db.players))..limit(1)).getSingle();
    await (_db.delete(_db.equippedSlots)
          ..where((t) =>
              t.playerId.equals(player.id) &
              t.slotIndex.equals(slotIndex)))
        .go();
  }

  /// Purchase a weapon from the shop.
  /// Returns true if successful, false if not enough gold.
  Future<bool> purchaseWeapon(int equipmentId) async {
    final player = await ((_db.select(_db.players))..limit(1)).getSingle();
    final weapon = await ((_db.select(_db.equipment))
          ..where((t) => t.id.equals(equipmentId)))
        .getSingle();

    if (player.gold < weapon.price) return false;
    if (weapon.isOwned) return false;

    // Deduct gold
    await (_db.update(_db.players)
          ..where((t) => t.id.equals(player.id)))
        .write(PlayersCompanion(gold: Value(player.gold - weapon.price)));

    // Mark as owned
    await (_db.update(_db.equipment)
          ..where((t) => t.id.equals(equipmentId)))
        .write(const EquipmentCompanion(isOwned: Value(true)));

    return true;
  }

  /// Get the equipment data for a slot, or null if empty.
  Future<EquipmentData?> getEquippedInSlot(int slotIndex) async {
    final player = await ((_db.select(_db.players))..limit(1)).getSingle();
    final slot = await (_db.select(_db.equippedSlots)
          ..where((t) =>
              t.playerId.equals(player.id) &
              t.slotIndex.equals(slotIndex)))
        .getSingleOrNull();

    if (slot == null) return null;

    return await (_db.select(_db.equipment)
          ..where((t) => t.id.equals(slot.equipmentId)))
        .getSingleOrNull();
  }
}
