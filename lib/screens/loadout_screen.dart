import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme.dart';
import '../db/database.dart';
import '../data/weapon_catalog.dart';
import '../providers/equipment_provider.dart';
import '../providers/database_provider.dart';
import '../services/haptic_service.dart';

/// v2.0: Equipment Loadout Screen.
/// Players manage their 3-slot weapon loadout.
/// Equipped weapons drive daily quest generation.
class LoadoutScreen extends ConsumerStatefulWidget {
  const LoadoutScreen({super.key});

  @override
  ConsumerState<LoadoutScreen> createState() => _LoadoutScreenState();
}

class _LoadoutScreenState extends ConsumerState<LoadoutScreen> {
  int? _selectedSlot; // null or 1-3

  @override
  Widget build(BuildContext context) {
    final ownedAsync = ref.watch(ownedEquipmentProvider);
    final slotsAsync = ref.watch(equippedSlotsProvider);

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
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildEquippedSlots(slotsAsync),
                    const SizedBox(height: 28),
                    _buildInventoryHeader(),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            _buildWeaponGrid(ownedAsync, slotsAsync),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        ShaderMask(
          shaderCallback: goldGradientShader,
          child: Text(
            'LOADOUT',
            style: GoogleFonts.cinzel(
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: QuestFitColors.purple.withValues(alpha: 0.1),
              border: Border.all(
                color: QuestFitColors.purple.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_awesome,
                    size: 14, color: QuestFitColors.purple),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'Equipped weapons drive your quests',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: QuestFitColors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEquippedSlots(AsyncValue<List<EquippedSlot>> slotsAsync) {
    return slotsAsync.when(
      loading: () => const SizedBox(height: 120),
      error: (e, _) => Text('Error: $e'),
      data: (slots) {
        return Row(
          children: List.generate(3, (i) {
            final slotIndex = i + 1;
            final slot = slots.where((s) => s.slotIndex == slotIndex).firstOrNull;
            final isSelected = _selectedSlot == slotIndex;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: i > 0 ? 6 : 0,
                  right: i < 2 ? 6 : 0,
                ),
                child: _EquipmentSlot(
                  slotIndex: slotIndex,
                  equipmentId: slot?.equipmentId,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedSlot = isSelected ? null : slotIndex;
                    });
                  },
                  onUnequip: slot != null
                      ? () => _unequipSlot(slotIndex)
                      : null,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildInventoryHeader() {
    return Row(
      children: [
        Text(
          'ARSENAL',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 11,
            color: QuestFitColors.textMuted,
            letterSpacing: 3,
          ),
        ),
        if (_selectedSlot != null) ...[
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: QuestFitColors.emerald.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Tap a weapon to equip → Slot $_selectedSlot',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: QuestFitColors.emerald,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildWeaponGrid(
    AsyncValue<List<EquipmentData>> ownedAsync,
    AsyncValue<List<EquippedSlot>> slotsAsync,
  ) {
    return ownedAsync.when(
      loading: () => const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SliverToBoxAdapter(child: Text('Error: $e')),
      data: (weapons) {
        final equippedIds = slotsAsync.value
                ?.map((s) => s.equipmentId)
                .toSet() ??
            {};

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final weapon = weapons[index];
                final isEquipped = equippedIds.contains(weapon.id);

                return _WeaponCard(
                  weapon: weapon,
                  isEquipped: isEquipped,
                  isSlotSelected: _selectedSlot != null,
                  onTap: () {
                    if (_selectedSlot != null) {
                      _equipWeapon(weapon.id, _selectedSlot!);
                    } else {
                      _showWeaponDetail(weapon);
                    }
                  },
                );
              },
              childCount: weapons.length,
            ),
          ),
        );
      },
    );
  }

  Future<void> _equipWeapon(int equipmentId, int slotIndex) async {
    HapticService.onQuestComplete();
    await ref
        .read(equipmentNotifierProvider.notifier)
        .equipWeapon(equipmentId, slotIndex);
    setState(() => _selectedSlot = null);
  }

  Future<void> _unequipSlot(int slotIndex) async {
    HapticService.onQuestComplete();
    await ref
        .read(equipmentNotifierProvider.notifier)
        .unequipSlot(slotIndex);
  }

  void _showWeaponDetail(EquipmentData weapon) {

    showModalBottomSheet(
      context: context,
      backgroundColor: QuestFitColors.bgDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _WeaponDetailSheet(weapon: weapon),
    );
  }
}

/// Individual equipment slot display.
class _EquipmentSlot extends ConsumerWidget {
  final int slotIndex;
  final int? equipmentId;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onUnequip;

  const _EquipmentSlot({
    required this.slotIndex,
    this.equipmentId,
    required this.isSelected,
    required this.onTap,
    this.onUnequip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (equipmentId == null) {
      return _buildEmptySlot(context);
    }

    // Look up the equipment data
    final db = ref.watch(databaseProvider);
    return FutureBuilder<EquipmentData?>(
      future: (db.select(db.equipment)
            ..where((t) => t.id.equals(equipmentId!)))
          .getSingleOrNull(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return _buildEmptySlot(context);
        }
        return _buildFilledSlot(context, snapshot.data!);
      },
    );
  }

  Widget _buildEmptySlot(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 130,
        decoration: BoxDecoration(
          color: isSelected
              ? QuestFitColors.emerald.withValues(alpha: 0.06)
              : QuestFitColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? QuestFitColors.emerald.withValues(alpha: 0.4)
                : QuestFitColors.glassBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_rounded,
              size: 28,
              color: isSelected
                  ? QuestFitColors.emerald
                  : QuestFitColors.textMuted,
            ),
            const SizedBox(height: 6),
            Text(
              'SLOT $slotIndex',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 9,
                color: QuestFitColors.textMuted,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilledSlot(BuildContext context, EquipmentData weapon) {
    final rarityColor = Color(rarityColors[weapon.rarity] ?? 0xFF8B8B8B);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onUnequip,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 130,
        decoration: BoxDecoration(
          color: isSelected
              ? QuestFitColors.emerald.withValues(alpha: 0.06)
              : rarityColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? QuestFitColors.emerald.withValues(alpha: 0.4)
                : rarityColor.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 56,
              width: 56,
              child: Image.asset(
                weapon.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.shield_rounded,
                  size: 32,
                  color: rarityColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              weapon.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: QuestFitColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'SLOT $slotIndex',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 8,
                color: rarityColor,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Weapon card in the arsenal grid.
class _WeaponCard extends StatelessWidget {
  final EquipmentData weapon;
  final bool isEquipped;
  final bool isSlotSelected;
  final VoidCallback onTap;

  const _WeaponCard({
    required this.weapon,
    required this.isEquipped,
    required this.isSlotSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rarityColor = Color(rarityColors[weapon.rarity] ?? 0xFF8B8B8B);
    final rarityName = rarityNames[weapon.rarity] ?? 'Common';

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isEquipped
              ? rarityColor.withValues(alpha: 0.08)
              : QuestFitColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isEquipped
                ? rarityColor.withValues(alpha: 0.4)
                : QuestFitColors.glassBorder,
            width: isEquipped ? 1.5 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Rarity badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                  if (isEquipped)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: QuestFitColors.emerald.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'EQUIPPED',
                        style: TextStyle(
                          fontSize: 7,
                          fontWeight: FontWeight.w800,
                          color: QuestFitColors.emerald,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              // Weapon image
              SizedBox(
                height: 72,
                width: 72,
                child: Image.asset(
                  weapon.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.shield_rounded,
                    size: 40,
                    color: rarityColor,
                  ),
                ),
              ),
              const Spacer(),
              // Name
              Text(
                weapon.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  color: QuestFitColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              // Category
              Text(
                weapon.category.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  color: QuestFitColors.textMuted,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Weapon detail bottom sheet.
class _WeaponDetailSheet extends ConsumerWidget {
  final EquipmentData weapon;

  const _WeaponDetailSheet({required this.weapon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rarityColor = Color(rarityColors[weapon.rarity] ?? 0xFF8B8B8B);
    final exercisesAsync = ref.watch(equipmentExercisesProvider(weapon.id));

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: QuestFitColors.glassBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          // Weapon image
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(
              weapon.imagePath,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Icon(
                Icons.shield_rounded,
                size: 60,
                color: rarityColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            weapon.name,
            style: GoogleFonts.cinzel(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: rarityColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            weapon.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: QuestFitColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          // Linked exercises
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'LINKED EXERCISES',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: QuestFitColors.textMuted,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 10),
          exercisesAsync.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('Error: $e'),
            data: (exercises) => Column(
              children: exercises.map((ex) {
                String desc;
                if (ex.sets != null && ex.reps != null) {
                  desc = '${ex.sets}×${ex.reps}';
                } else if (ex.duration != null) {
                  desc = '${ex.duration} min';
                } else {
                  desc = '';
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Text(ex.emoji, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          ex.exerciseTitle,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: QuestFitColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        desc,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: QuestFitColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '+${ex.baseXp} XP',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: QuestFitColors.emerald,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
