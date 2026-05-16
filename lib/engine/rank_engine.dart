import 'package:flutter/material.dart';

/// QuestFit Rank Tier System.
/// 8 ranks from Iron to Legend, level-gated with Roman numeral tiers.
class RankEngine {
  const RankEngine._();

  static const List<RankDef> _ranks = [
    RankDef(name: 'Iron',      tiers: 4, startLevel: 1,  color: Color(0xFF8B8B8B)),
    RankDef(name: 'Bronze',    tiers: 4, startLevel: 5,  color: Color(0xFFCD7F32)),
    RankDef(name: 'Silver',    tiers: 4, startLevel: 13, color: Color(0xFFC0C0C0)),
    RankDef(name: 'Gold',      tiers: 4, startLevel: 23, color: Color(0xFFF0C850)),
    RankDef(name: 'Platinum',  tiers: 4, startLevel: 35, color: Color(0xFF60A5FA)),
    RankDef(name: 'Diamond',   tiers: 4, startLevel: 49, color: Color(0xFFA78BFA)),
    RankDef(name: 'Esmeralda', tiers: 4, startLevel: 65, color: Color(0xFF2DD4A8)),
    RankDef(name: 'Legend',    tiers: 1, startLevel: 81, color: Color(0xFFF87171)),
  ];

  static const _roman = ['I', 'II', 'III', 'IV'];

  /// Get rank info for a given level.
  static RankInfo getRank(int level) {
    var rankIdx = 0;
    for (var i = _ranks.length - 1; i >= 0; i--) {
      if (level >= _ranks[i].startLevel) {
        rankIdx = i;
        break;
      }
    }

    final rank = _ranks[rankIdx];
    var tier = 1;

    if (rank.tiers > 1 && rankIdx < _ranks.length - 1) {
      final nextStart = _ranks[rankIdx + 1].startLevel;
      final range = nextStart - rank.startLevel;
      final tierSize = (range / rank.tiers).ceil();
      tier = ((level - rank.startLevel) ~/ tierSize + 1).clamp(1, rank.tiers);
    }

    final tierStr = rank.tiers > 1 ? ' ${_roman[tier - 1]}' : '';

    return RankInfo(
      name: rank.name,
      tier: tier,
      fullName: '${rank.name}$tierStr',
      color: rank.color,
      rankIndex: rankIdx,
    );
  }

  /// Get rank key for storage (e.g., "iron_1").
  static String getRankKey(int level) {
    final r = getRank(level);
    return '${r.name.toLowerCase()}_${r.tier}';
  }

  /// Check if a rank-up occurred between two levels.
  static bool didRankUp(int oldLevel, int newLevel) {
    return getRank(oldLevel).fullName != getRank(newLevel).fullName;
  }

  /// Get levels until next rank change.
  static RankMilestone getNextMilestone(int level) {
    final current = getRank(level);
    for (var l = level + 1; l <= 200; l++) {
      final next = getRank(l);
      if (next.fullName != current.fullName) {
        return RankMilestone(levelsAway: l - level, nextRank: next);
      }
    }
    return RankMilestone(levelsAway: 0, nextRank: current);
  }

  /// All rank definitions.
  static List<RankDef> get allRanks => _ranks;
}

class RankDef {
  final String name;
  final int tiers;
  final int startLevel;
  final Color color;

  const RankDef({
    required this.name,
    required this.tiers,
    required this.startLevel,
    required this.color,
  });
}

class RankInfo {
  final String name;
  final int tier;
  final String fullName;
  final Color color;
  final int rankIndex;

  const RankInfo({
    required this.name,
    required this.tier,
    required this.fullName,
    required this.color,
    required this.rankIndex,
  });
}

class RankMilestone {
  final int levelsAway;
  final RankInfo nextRank;

  const RankMilestone({required this.levelsAway, required this.nextRank});
}
