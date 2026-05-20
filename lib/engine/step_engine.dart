import 'dart:math';

/// QuestFit v2.2 — Step Counter Game Engine.
/// Handles step milestones, expedition rewards, Momentum Buff, and egg incubation.
class StepEngine {
  const StepEngine._();

  static final _rng = Random();

  // ─── Momentum Buff ─────────────────────────────────────────────────

  /// Whether the Momentum Buff should be granted today.
  /// Checks if yesterday's steps met the daily goal.
  static bool shouldGrantMomentumBuff({
    required int yesterdaySteps,
    required int dailyStepGoal,
  }) =>
      yesterdaySteps >= dailyStepGoal;

  /// Momentum Buff bonus multiplier (+10% to LP and Gold).
  static const double momentumMultiplier = 1.10;

  // ─── Step Milestones (Expedition) ──────────────────────────────────

  /// Steps between each expedition milestone reward.
  static const int milestoneInterval = 2000;

  /// Maximum milestones claimable per day.
  static const int maxDailyMilestones = 8;

  /// Calculate how many milestones have been earned given total steps.
  static int milestonesEarned(int totalSteps) {
    return (totalSteps / milestoneInterval).floor().clamp(0, maxDailyMilestones);
  }

  /// Calculate unclaimed milestones.
  static int unclaimedMilestones({
    required int totalSteps,
    required int milestonesClaimed,
  }) {
    final earned = milestonesEarned(totalSteps);
    return (earned - milestonesClaimed).clamp(0, maxDailyMilestones);
  }

  /// Generate a random expedition reward for a milestone.
  /// Later milestones give better rewards.
  static ExpeditionReward generateMilestoneReward(int milestoneNumber) {
    // Reward pool weights change by milestone tier
    final roll = _rng.nextDouble();

    if (milestoneNumber >= 6) {
      // Late milestones: higher chance of eggs and big gold
      if (roll < 0.15) {
        return _eggReward('rare');
      } else if (roll < 0.35) {
        return _eggReward('common');
      } else if (roll < 0.65) {
        return ExpeditionReward(
          type: 'gold',
          amount: 20 + _rng.nextInt(15),
          description: 'A hidden treasure chest!',
          emoji: '💰',
        );
      } else {
        return ExpeditionReward(
          type: 'lp',
          amount: 3 + _rng.nextInt(3),
          description: 'The journey strengthens you.',
          emoji: '⚡',
        );
      }
    } else if (milestoneNumber >= 3) {
      // Mid milestones: balanced rewards
      if (roll < 0.10) {
        return _eggReward('common');
      } else if (roll < 0.45) {
        return ExpeditionReward(
          type: 'gold',
          amount: 10 + _rng.nextInt(10),
          description: 'You found scattered coins!',
          emoji: '🪙',
        );
      } else if (roll < 0.75) {
        return ExpeditionReward(
          type: 'lp',
          amount: 2 + _rng.nextInt(2),
          description: 'Exploration grants wisdom.',
          emoji: '⚡',
        );
      } else {
        return ExpeditionReward(
          type: 'gold',
          amount: 5 + _rng.nextInt(5),
          description: 'A few coins on the road.',
          emoji: '🪙',
        );
      }
    } else {
      // Early milestones: small rewards
      if (roll < 0.50) {
        return ExpeditionReward(
          type: 'gold',
          amount: 5 + _rng.nextInt(5),
          description: 'A small pouch of coins.',
          emoji: '🪙',
        );
      } else if (roll < 0.80) {
        return ExpeditionReward(
          type: 'lp',
          amount: 1 + _rng.nextInt(2),
          description: 'Each step makes you stronger.',
          emoji: '⚡',
        );
      } else {
        return ExpeditionReward(
          type: 'gold',
          amount: 8 + _rng.nextInt(7),
          description: 'A wandering merchant dropped these!',
          emoji: '🪙',
        );
      }
    }
  }

  static ExpeditionReward _eggReward(String rarity) {
    final rarityEmoji = {
      'common': '🥚',
      'rare': '🥚',
      'epic': '✨',
      'legendary': '🌟',
    };
    return ExpeditionReward(
      type: 'egg',
      amount: 1,
      description: 'You discovered a ${rarity[0].toUpperCase()}${rarity.substring(1)} Egg!',
      emoji: rarityEmoji[rarity] ?? '🥚',
      metadata: rarity,
    );
  }

  // ─── Egg Incubation ────────────────────────────────────────────────

  /// Calculate egg incubation progress (0.0 – 1.0).
  static double eggProgress(int stepsAccumulated, int stepsRequired) {
    if (stepsRequired <= 0) return 1.0;
    return (stepsAccumulated / stepsRequired).clamp(0.0, 1.0);
  }

  /// Check if an egg should hatch.
  static bool shouldHatch(int stepsAccumulated, int stepsRequired) {
    return stepsAccumulated >= stepsRequired;
  }
}

/// A reward earned from a step expedition milestone.
class ExpeditionReward {
  final String type; // 'gold', 'lp', 'egg', 'consumable'
  final int amount;
  final String description;
  final String emoji;
  /// Extra data (e.g., egg rarity)
  final String? metadata;

  const ExpeditionReward({
    required this.type,
    required this.amount,
    required this.description,
    required this.emoji,
    this.metadata,
  });
}
