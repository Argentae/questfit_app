import 'package:flutter/material.dart';
import '../engine/step_engine.dart';

/// Floating toast overlay for expedition milestone rewards.
class ExpeditionRewardToast {
  static void show(BuildContext context, ExpeditionReward reward) {
    final overlay = Overlay.of(context);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _RewardToastWidget(
        reward: reward,
        onDismiss: () => entry.remove(),
      ),
    );

    overlay.insert(entry);
  }
}

class _RewardToastWidget extends StatefulWidget {
  final ExpeditionReward reward;
  final VoidCallback onDismiss;

  const _RewardToastWidget({required this.reward, required this.onDismiss});

  @override
  State<_RewardToastWidget> createState() => _RewardToastWidgetState();
}

class _RewardToastWidgetState extends State<_RewardToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _slideAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: -50.0, end: 0.0)
          .chain(CurveTween(curve: Curves.easeOutBack)), weight: 20),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -50.0)
          .chain(CurveTween(curve: Curves.easeIn)), weight: 20),
    ]).animate(_controller);

    _fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 15),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 65),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 20),
    ]).animate(_controller);

    _controller.forward().then((_) => widget.onDismiss());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = _rewardColors(widget.reward.type);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Positioned(
        top: MediaQuery.of(context).padding.top + 16 + _slideAnimation.value,
        left: 24,
        right: 24,
        child: Opacity(
          opacity: _fadeAnimation.value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colors.first.withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(widget.reward.emoji,
                    style: const TextStyle(fontSize: 26)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _rewardTitle(widget.reward.type),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5),
                      ),
                      Text(
                        widget.reward.description,
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Text(
                  _rewardAmount(widget.reward),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _rewardTitle(String type) {
    switch (type) {
      case 'gold': return '🗺️ EXPEDITION LOOT';
      case 'lp': return '⚡ WISDOM GAINED';
      case 'egg': return '🥚 EGG FOUND!';
      default: return '🎁 REWARD';
    }
  }

  String _rewardAmount(ExpeditionReward reward) {
    switch (reward.type) {
      case 'gold': return '+${reward.amount}g';
      case 'lp': return '+${reward.amount}';
      case 'egg': return '×${reward.amount}';
      default: return '+${reward.amount}';
    }
  }

  List<Color> _rewardColors(String type) {
    switch (type) {
      case 'gold':
        return [const Color(0xFFF0C850), const Color(0xFFB8962E)];
      case 'lp':
        return [const Color(0xFF2DD4A8), const Color(0xFF1A8A6D)];
      case 'egg':
        return [const Color(0xFFA78BFA), const Color(0xFF7C3AED)];
      default:
        return [const Color(0xFF60A5FA), const Color(0xFF3B82F6)];
    }
  }
}
