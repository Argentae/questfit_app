import 'package:flutter/material.dart';

/// QuestFit LP Tier System — League of Legends style.
///
/// Tiers: Iron → Challenger (10 tiers)
/// Divisions: IV, III, II, I (within tiered ranks; Master+ have 1)
/// LP: 0–100 per division
/// Reaching 100 LP → auto-promote next app launch
/// 48h inactivity → LP decay (scales with tier)
/// 0 LP + decay → demotion to previous division at 75 LP
class RankEngine {
  const RankEngine._();

  static const List<TierDef> _tiers = [
    TierDef(name: 'Iron',        divisions: 4, color: Color(0xFF8B8B8B)),
    TierDef(name: 'Bronze',      divisions: 4, color: Color(0xFFCD7F32)),
    TierDef(name: 'Silver',      divisions: 4, color: Color(0xFFC0C0C0)),
    TierDef(name: 'Gold',        divisions: 4, color: Color(0xFFF0C850)),
    TierDef(name: 'Platinum',    divisions: 4, color: Color(0xFF60A5FA)),
    TierDef(name: 'Emerald',     divisions: 4, color: Color(0xFF2DD4A8)),
    TierDef(name: 'Diamond',     divisions: 4, color: Color(0xFFA78BFA)),
    TierDef(name: 'Master',      divisions: 1, color: Color(0xFFF87171)),
    TierDef(name: 'Grandmaster', divisions: 1, color: Color(0xFFFF6B35)),
    TierDef(name: 'Challenger',  divisions: 1, color: Color(0xFF00D4FF)),
  ];

  static const _roman = ['IV', 'III', 'II', 'I'];

  // ─── Tier Info ──────────────────────────────────────────────────────

  /// Get tier info from tier name and division.
  static TierInfo getTierInfo(String tierName, int division) {
    final tierIdx = _findTierIndex(tierName);
    if (tierIdx < 0) return defaultTierInfo;

    final tier = _tiers[tierIdx];
    final clampedDiv = division.clamp(1, tier.divisions);
    final divStr = tier.divisions > 1 ? ' ${_roman[clampedDiv - 1]}' : '';

    return TierInfo(
      name: tier.name,
      division: clampedDiv,
      fullName: '${tier.name}$divStr',
      color: tier.color,
      tierIndex: tierIdx,
    );
  }

  static TierInfo get defaultTierInfo => const TierInfo(
    name: 'Iron',
    division: 4,
    fullName: 'Iron IV',
    color: Color(0xFF8B8B8B),
    tierIndex: 0,
  );

  /// Get the tier key for storage (lowercase name, e.g. "iron").
  static String getTierKey(String tierName) => tierName.toLowerCase();

  // ─── Promotion / Demotion ──────────────────────────────────────────

  /// Get the next rank after the current one.
  /// Returns null if already at Challenger (max).
  static ({String tier, int division})? getNextRank(
      String tierName, int division) {
    final tierIdx = _findTierIndex(tierName);
    if (tierIdx < 0) return null;

    final tier = _tiers[tierIdx];

    if (tier.divisions > 1 && division > 1) {
      // Promote within same tier: IV→III, III→II, II→I
      return (tier: tier.name.toLowerCase(), division: division - 1);
    } else if (tierIdx < _tiers.length - 1) {
      // Promote to next tier's lowest division
      final nextTier = _tiers[tierIdx + 1];
      return (
        tier: nextTier.name.toLowerCase(),
        division: nextTier.divisions,
      );
    }

    return null; // Already at Challenger
  }

  /// Get the previous rank (for demotion).
  /// Returns null if already at Iron IV (min).
  static ({String tier, int division})? getPreviousRank(
      String tierName, int division) {
    final tierIdx = _findTierIndex(tierName);
    if (tierIdx < 0) return null;

    final tier = _tiers[tierIdx];

    if (tier.divisions > 1 && division < tier.divisions) {
      // Demote within same tier: I→II, II→III, III→IV
      return (tier: tier.name.toLowerCase(), division: division + 1);
    } else if (tierIdx > 0) {
      // Demote to previous tier's highest division (I)
      final prevTier = _tiers[tierIdx - 1];
      return (tier: prevTier.name.toLowerCase(), division: 1);
    }

    return null; // Already at Iron IV
  }

  /// Whether the player is at the absolute lowest rank (can't demote further).
  static bool isLowestRank(String tierName, int division) {
    return _findTierIndex(tierName) == 0 && division >= _tiers[0].divisions;
  }

  /// Whether the player is at the absolute highest rank.
  static bool isHighestRank(String tierName) {
    return _findTierIndex(tierName) == _tiers.length - 1;
  }

  // ─── LP Decay ─────────────────────────────────────────────────────

  /// LP decay amount for 48h inactivity, scaled by tier.
  static int getDecayAmount(String tierName) {
    final tierIdx = _findTierIndex(tierName);
    if (tierIdx <= 1) return 5;    // Iron, Bronze
    if (tierIdx == 2) return 8;    // Silver
    if (tierIdx == 3) return 10;   // Gold
    if (tierIdx == 4) return 15;   // Platinum
    return 20;                      // Emerald, Diamond, Master+
  }

  /// Check if 48h have passed since last activity.
  static bool shouldDecay(DateTime? lastActivityAt) {
    if (lastActivityAt == null) return false;
    return DateTime.now().difference(lastActivityAt).inHours >= 48;
  }

  // ─── Rank Position (for progress visualization) ───────────────────

  /// Get ordinal position from 0 (Iron IV) to totalPositions-1 (Challenger).
  static int getRankPosition(String tierName, int division) {
    var position = 0;
    for (final tier in _tiers) {
      if (tier.name.toLowerCase() == tierName.toLowerCase()) {
        if (tier.divisions > 1) {
          position += (tier.divisions - division);
        }
        return position;
      }
      position += tier.divisions;
    }
    return 0;
  }

  /// Total number of rank positions in the ladder.
  static int get totalPositions {
    return _tiers.fold(0, (sum, t) => sum + t.divisions);
  }

  // ─── Helpers ──────────────────────────────────────────────────────

  static int _findTierIndex(String tierName) {
    return _tiers.indexWhere(
      (t) => t.name.toLowerCase() == tierName.toLowerCase(),
    );
  }

  /// All tier definitions (for UI tier ladder display).
  static List<TierDef> get allTiers => _tiers;
}

// ─── Data Classes ──────────────────────────────────────────────────────

class TierDef {
  final String name;
  final int divisions;
  final Color color;

  const TierDef({
    required this.name,
    required this.divisions,
    required this.color,
  });
}

class TierInfo {
  final String name;
  final int division;
  final String fullName;
  final Color color;
  final int tierIndex;

  const TierInfo({
    required this.name,
    required this.division,
    required this.fullName,
    required this.color,
    required this.tierIndex,
  });
}
