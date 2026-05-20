import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../app/theme.dart';
import '../data/exercise_catalog.dart';
import '../engine/step_engine.dart';

/// Widget showing an incubating egg with progress ring and rarity styling.
class EggCard extends StatefulWidget {
  final int stepsAccumulated;
  final int stepsRequired;
  final String rarity;
  final String companionType;

  const EggCard({
    super.key,
    required this.stepsAccumulated,
    required this.stepsRequired,
    required this.rarity,
    required this.companionType,
  });

  @override
  State<EggCard> createState() => _EggCardState();
}

class _EggCardState extends State<EggCard> with SingleTickerProviderStateMixin {
  late AnimationController _wobbleController;

  @override
  void initState() {
    super.initState();
    _wobbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    final progress = StepEngine.eggProgress(
        widget.stepsAccumulated, widget.stepsRequired);
    if (progress > 0.9) {
      _wobbleController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(EggCard old) {
    super.didUpdateWidget(old);
    final progress = StepEngine.eggProgress(
        widget.stepsAccumulated, widget.stepsRequired);
    if (progress > 0.9 && !_wobbleController.isAnimating) {
      _wobbleController.repeat(reverse: true);
    } else if (progress <= 0.9 && _wobbleController.isAnimating) {
      _wobbleController.stop();
      _wobbleController.reset();
    }
  }

  @override
  void dispose() {
    _wobbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = StepEngine.eggProgress(
        widget.stepsAccumulated, widget.stepsRequired);
    final rarityColor =
        Color(companionRarityColors[widget.rarity] ?? 0xFF8B8B8B);
    final pct = (progress * 100).toInt();

    return AnimatedBuilder(
      animation: _wobbleController,
      builder: (context, child) {
        final wobble = progress > 0.9
            ? math.sin(_wobbleController.value * math.pi * 2) * 0.05
            : 0.0;
        return Transform.rotate(angle: wobble, child: child);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: QuestFitColors.bgCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: rarityColor.withOpacity(0.5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: rarityColor.withOpacity(0.15),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress ring with egg
            SizedBox(
              width: 56, height: 56,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 4,
                    strokeCap: StrokeCap.round,
                    color: rarityColor,
                    backgroundColor: QuestFitColors.glassBorder,
                  ),
                  const Text('🥚', style: TextStyle(fontSize: 26)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Percentage
            Text('$pct%',
                style: TextStyle(
                    color: rarityColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w800)),
            // Steps
            Text(
              '${widget.stepsAccumulated} / ${widget.stepsRequired}',
              style: const TextStyle(
                  color: QuestFitColors.textMuted, fontSize: 9),
            ),
          ],
        ),
      ),
    );
  }
}
