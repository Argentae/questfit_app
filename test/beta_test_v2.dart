import 'package:flutter_test/flutter_test.dart';
import 'package:questfit_app/engine/xp_engine.dart';
import 'package:questfit_app/engine/rank_engine.dart';

void main() {
  group('v2.0 Beta Tests', () {
    test('Promotion Boundary Calculation', () {
      // Iron starts at 1, Bronze starts at 5.
      // Iron levels: 1 (I), 2 (II), 3 (III), 4 (IV)
      expect(RankEngine.isPromotionBoundary(1), isFalse, reason: 'Level 1->2 is free');
      expect(RankEngine.isPromotionBoundary(2), isTrue, reason: 'Level 2->3 needs trial');
      expect(RankEngine.isPromotionBoundary(4), isTrue, reason: 'Level 4->5 (Iron->Bronze) needs trial');
      
      // Bronze: 5,6 (I), 7,8 (II), 9,10 (III), 11,12 (IV)
      expect(RankEngine.isPromotionBoundary(5), isFalse);
      expect(RankEngine.isPromotionBoundary(6), isTrue, reason: 'Bronze I -> II');
      expect(RankEngine.isPromotionBoundary(12), isTrue, reason: 'Bronze IV -> Silver I');
    });

    test('XP Engine Capping', () {
      // Start at Level 2 (which is a boundary)
      // xpForLevel(2) = floor(100 * 2^1.5) = floor(282.84) = 282
      final int needed = XpEngine.xpForLevel(2);
      
      final result = XpEngine.addXp(
        currentLevel: 2,
        currentXp: 0,
        totalXp: 0,
        amount: needed + 500, // Try to overshoot
      );
      
      expect(result.newLevel, equals(2)); // Should not level up!
      expect(result.newXp, equals(needed)); // XP should be capped at needed
      expect(result.isXpCapped, isTrue);
      
      // Now simulate having a passed trial
      final resultWithTrial = XpEngine.addXp(
        currentLevel: 2,
        currentXp: 0,
        totalXp: 0,
        amount: needed + 500,
        hasActiveTrialOrPassed: true,
      );
      
      expect(resultWithTrial.newLevel, greaterThan(2)); // Allowed to level up
      expect(resultWithTrial.isXpCapped, isFalse);
    });
    
    test('Gatekeeper Requirements', () {
      // Level 4 is Iron IV -> Bronze I (Major transition)
      final req = RankEngine.getTrialRequirements(4);
      expect(req.trialType, equals('gatekeeper'));
      
      // Level 2 is Iron II -> Iron III (Tier transition)
      final req2 = RankEngine.getTrialRequirements(2);
      expect(req2.trialType, equals('consistency'));
    });
  });
}
