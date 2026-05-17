import '../lib/engine/rank_engine.dart';
import '../lib/engine/lp_engine.dart';

void main() {
  // ── v3.0 Tier System Tests ──────────────────────────────────────────

  // Test tier ladder navigation
  assert(RankEngine.getNextRank('iron', 4)?.tier == 'iron');
  assert(RankEngine.getNextRank('iron', 4)?.division == 3);
  assert(RankEngine.getNextRank('iron', 1)?.tier == 'bronze');
  assert(RankEngine.getNextRank('iron', 1)?.division == 4);
  assert(RankEngine.getNextRank('challenger', 1) == null); // Max rank

  // Test demotion
  assert(RankEngine.getPreviousRank('iron', 4) == null); // Min rank
  assert(RankEngine.getPreviousRank('bronze', 4)?.tier == 'iron');
  assert(RankEngine.getPreviousRank('bronze', 4)?.division == 1);

  // Test LP engine
  final result1 = LpEngine.addLp(currentLp: 50, amount: 30);
  assert(result1.newLp == 80);
  assert(!result1.isPromotionReady);

  final result2 = LpEngine.addLp(currentLp: 90, amount: 20);
  assert(result2.newLp == 100);
  assert(result2.isPromotionReady);

  // Test LP cap
  final result3 = LpEngine.addLp(currentLp: 95, amount: 20);
  assert(result3.newLp == 100); // Capped at 100

  // Test LP decay
  final decay1 = LpEngine.removeLp(currentLp: 30, amount: 10);
  assert(decay1.newLp == 20);
  assert(!decay1.shouldDemote);

  final decay2 = LpEngine.removeLp(currentLp: 5, amount: 10);
  assert(decay2.newLp == 75); // Landing LP after demotion
  assert(decay2.shouldDemote);

  // Test mastery bonus
  final lp1 = LpEngine.calculateQuestLp(baseLp: 8, masteryPoints: 50, currentStreak: 0);
  assert(lp1 == 10); // 8 + 2 mastery bonus

  final lp2 = LpEngine.calculateQuestLp(baseLp: 8, masteryPoints: 0, currentStreak: 7);
  assert(lp2 == 10); // 8 + 2 streak bonus

  // Test decay amounts by tier
  assert(RankEngine.getDecayAmount('iron') == 5);
  assert(RankEngine.getDecayAmount('gold') == 10);
  assert(RankEngine.getDecayAmount('diamond') == 20);

  // Test tier info
  final info = RankEngine.getTierInfo('silver', 2);
  assert(info.fullName == 'Silver III');
  assert(info.tierIndex == 2);

  print('✅ All v3.0 LP/Tier system tests passed!');
}
