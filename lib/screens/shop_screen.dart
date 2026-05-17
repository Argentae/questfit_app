import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../db/database.dart';
import '../data/weapon_catalog.dart';
import '../engine/gold_engine.dart';
import '../providers/equipment_provider.dart';
import '../providers/shop_provider.dart';
import '../providers/user_provider.dart';
import '../services/haptic_service.dart';

/// v2.0: Gold Shop Screen.
/// Players spend gold on permanent equipment and consumable items.
class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goldAsync = ref.watch(goldProvider);
    final allEquipAsync = ref.watch(allEquipmentProvider);
    final inventoryAsync = ref.watch(inventoryProvider);

    return Scaffold(
      backgroundColor: QuestFitColors.bgDark,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(goldAsync),
                    const SizedBox(height: 28),
                    _buildConsumablesSection(context, ref, goldAsync, inventoryAsync),
                    const SizedBox(height: 28),
                    _buildWeaponsHeader(),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            _buildWeaponShop(context, ref, allEquipAsync, goldAsync),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AsyncValue<int> goldAsync) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShaderMask(
          shaderCallback: goldGradientShader,
          child: Text(
            'SHOP',
            style: GoogleFonts.cinzel(
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
        // Gold balance
        goldAsync.when(
          data: (gold) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(colors: [
                QuestFitColors.gold.withValues(alpha: 0.15),
                QuestFitColors.gold.withValues(alpha: 0.05),
              ]),
              border: Border.all(
                color: QuestFitColors.gold.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                const Text('🪙', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text(
                  '$gold',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: QuestFitColors.gold,
                  ),
                ),
              ],
            ),
          ),
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildConsumablesSection(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<int> goldAsync,
    AsyncValue<List<InventoryData>> inventoryAsync,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONSUMABLES',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 11,
            color: QuestFitColors.textMuted,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 12),
        _ConsumableCard(
          icon: Icons.shield_rounded,
          name: 'Streak Insurance',
          description: 'Auto-saves your streak if you miss a day.',
          price: GoldEngine.shopPrices['streak_insurance']!,
          itemKey: 'streak_insurance',
          color: QuestFitColors.emerald,
          currentGold: goldAsync.value ?? 0,
          quantity: _getQuantity(inventoryAsync, 'streak_insurance'),
          onBuy: () => _buyConsumable(context, ref, 'streak_insurance'),
        ),
        const SizedBox(height: 10),
        _ConsumableCard(
          icon: Icons.refresh_rounded,
          name: 'Quest Reroll',
          description: 'Reroll your daily quests for a fresh set.',
          price: GoldEngine.shopPrices['quest_reroll']!,
          itemKey: 'quest_reroll',
          color: QuestFitColors.blueAccent,
          currentGold: goldAsync.value ?? 0,
          quantity: _getQuantity(inventoryAsync, 'quest_reroll'),
          onBuy: () => _buyConsumable(context, ref, 'quest_reroll'),
        ),
      ],
    );
  }

  int _getQuantity(AsyncValue<List<InventoryData>> inventoryAsync, String key) {
    return inventoryAsync.when(
      data: (items) {
        final item = items.where((i) => i.itemKey == key).firstOrNull;
        return item?.quantity ?? 0;
      },
      loading: () => 0,
      error: (_, __) => 0,
    );
  }

  Widget _buildWeaponsHeader() {
    return Text(
      'EQUIPMENT',
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        fontSize: 11,
        color: QuestFitColors.textMuted,
        letterSpacing: 3,
      ),
    );
  }

  Widget _buildWeaponShop(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<EquipmentData>> allEquipAsync,
    AsyncValue<int> goldAsync,
  ) {
    return allEquipAsync.when(
      loading: () => const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SliverToBoxAdapter(child: Text('Error: $e')),
      data: (weapons) {
        // Only show purchasable weapons (not owned, price > 0)
        final shopWeapons = weapons.where((w) => !w.isOwned && w.price > 0).toList();

        if (shopWeapons.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Center(
                child: Column(
                  children: [
                    const Text('⚔️', style: TextStyle(fontSize: 40)),
                    const SizedBox(height: 12),
                    Text(
                      'Arsenal Complete',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: QuestFitColors.gold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'You own every weapon in the forge.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: QuestFitColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final weapon = shopWeapons[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ShopWeaponCard(
                    weapon: weapon,
                    currentGold: goldAsync.value ?? 0,
                    onBuy: () => _buyWeapon(context, ref, weapon),
                  ),
                );
              },
              childCount: shopWeapons.length,
            ),
          ),
        );
      },
    );
  }

  Future<void> _buyConsumable(
      BuildContext context, WidgetRef ref, String itemKey) async {
    HapticService.onQuestComplete();
    final success =
        await ref.read(shopNotifierProvider.notifier).buyConsumable(itemKey);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(success ? 'Purchase successful!' : 'Not enough gold.'),
        backgroundColor: success ? QuestFitColors.emerald : QuestFitColors.redAccent,
      ));
    }
  }

  Future<void> _buyWeapon(
      BuildContext context, WidgetRef ref, EquipmentData weapon) async {
    HapticService.onLevelUp();
    final success = await ref
        .read(equipmentNotifierProvider.notifier)
        .purchaseWeapon(weapon.id);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            success ? '${weapon.name} acquired!' : 'Not enough gold.'),
        backgroundColor: success ? QuestFitColors.emerald : QuestFitColors.redAccent,
      ));
    }
  }
}

class _ConsumableCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String description;
  final int price;
  final String itemKey;
  final Color color;
  final int currentGold;
  final int quantity;
  final VoidCallback onBuy;

  const _ConsumableCard({
    required this.icon,
    required this.name,
    required this.description,
    required this.price,
    required this.itemKey,
    required this.color,
    required this.currentGold,
    required this.quantity,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    final canAfford = currentGold >= price;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: QuestFitColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: QuestFitColors.glassBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: QuestFitColors.textPrimary,
                      ),
                    ),
                    if (quantity > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '×$quantity',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: QuestFitColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: canAfford ? onBuy : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: canAfford
                    ? QuestFitColors.gold.withValues(alpha: 0.15)
                    : QuestFitColors.bgCard,
                border: Border.all(
                  color: canAfford
                      ? QuestFitColors.gold.withValues(alpha: 0.3)
                      : QuestFitColors.glassBorder,
                ),
              ),
              child: Row(
                children: [
                  const Text('🪙', style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 4),
                  Text(
                    '$price',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: canAfford
                          ? QuestFitColors.gold
                          : QuestFitColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShopWeaponCard extends StatelessWidget {
  final EquipmentData weapon;
  final int currentGold;
  final VoidCallback onBuy;

  const _ShopWeaponCard({
    required this.weapon,
    required this.currentGold,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    final rarityColor = Color(rarityColors[weapon.rarity] ?? 0xFF8B8B8B);
    final rarityName = rarityNames[weapon.rarity] ?? 'Common';
    final canAfford = currentGold >= weapon.price;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: QuestFitColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: rarityColor.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          // Weapon image
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: rarityColor.withValues(alpha: 0.08),
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              weapon.imagePath,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Icon(
                Icons.shield_rounded,
                size: 28,
                color: rarityColor,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      weapon.name,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: QuestFitColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: rarityColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        rarityName.toUpperCase(),
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          color: rarityColor,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  weapon.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: QuestFitColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  weapon.category.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: QuestFitColors.textMuted,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: canAfford ? onBuy : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: canAfford
                    ? QuestFitColors.gold.withValues(alpha: 0.15)
                    : QuestFitColors.bgCard,
                border: Border.all(
                  color: canAfford
                      ? QuestFitColors.gold.withValues(alpha: 0.3)
                      : QuestFitColors.glassBorder,
                ),
              ),
              child: Column(
                children: [
                  const Text('🪙', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(
                    '${weapon.price}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: canAfford
                          ? QuestFitColors.gold
                          : QuestFitColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
