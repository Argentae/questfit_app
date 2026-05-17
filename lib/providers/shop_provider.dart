import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/database.dart';
import '../engine/gold_engine.dart';
import 'database_provider.dart';

// ─── Reactive Streams ────────────────────────────────────────────────

/// Watches the player's consumable inventory.
final inventoryProvider = StreamProvider<List<InventoryData>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.inventory)).watch();
});

/// Derived: Get quantity of a specific consumable.
final consumableQuantityProvider =
    Provider.family<AsyncValue<int>, String>((ref, itemKey) {
  final inventoryAsync = ref.watch(inventoryProvider);
  return inventoryAsync.whenData((items) {
    final item = items.where((i) => i.itemKey == itemKey).firstOrNull;
    return item?.quantity ?? 0;
  });
});

// ─── Shop Notifier ───────────────────────────────────────────────────

final shopNotifierProvider =
    AsyncNotifierProvider<ShopNotifier, void>(ShopNotifier.new);

class ShopNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  QuestFitDatabase get _db => ref.read(databaseProvider);

  /// Buy a consumable item.
  /// Returns true if purchase succeeded.
  Future<bool> buyConsumable(String itemKey) async {
    final price = GoldEngine.shopPrices[itemKey];
    if (price == null) return false;

    final player = await ((_db.select(_db.players))..limit(1)).getSingle();
    if (player.gold < price) return false;

    // Deduct gold
    await (_db.update(_db.players)
          ..where((t) => t.id.equals(player.id)))
        .write(PlayersCompanion(gold: Value(player.gold - price)));

    // Add to inventory
    final existing = await (_db.select(_db.inventory)
          ..where((t) =>
              t.playerId.equals(player.id) & t.itemKey.equals(itemKey)))
        .getSingleOrNull();

    if (existing != null) {
      await (_db.update(_db.inventory)
            ..where((t) => t.id.equals(existing.id)))
          .write(InventoryCompanion(quantity: Value(existing.quantity + 1)));
    } else {
      await _db.into(_db.inventory).insert(InventoryCompanion(
        playerId: Value(player.id),
        itemKey: Value(itemKey),
        quantity: const Value(1),
      ));
    }

    return true;
  }

  /// Use a consumable from inventory.
  /// Returns true if the item was available and consumed.
  Future<bool> useConsumable(String itemKey) async {
    final player = await ((_db.select(_db.players))..limit(1)).getSingle();
    final item = await (_db.select(_db.inventory)
          ..where((t) =>
              t.playerId.equals(player.id) & t.itemKey.equals(itemKey)))
        .getSingleOrNull();

    if (item == null || item.quantity <= 0) return false;

    await (_db.update(_db.inventory)
          ..where((t) => t.id.equals(item.id)))
        .write(InventoryCompanion(quantity: Value(item.quantity - 1)));

    return true;
  }

  /// Check if the player has a specific consumable.
  Future<bool> hasConsumable(String itemKey) async {
    final player = await ((_db.select(_db.players))..limit(1)).getSingle();
    final item = await (_db.select(_db.inventory)
          ..where((t) =>
              t.playerId.equals(player.id) & t.itemKey.equals(itemKey)))
        .getSingleOrNull();

    return item != null && item.quantity > 0;
  }
}
