import 'package:flutter/material.dart';
import '../app/theme.dart';

/// Floating "+XP" toast that fades in, floats up, then fades out.
class XpToast {
  static void show(BuildContext context, int xpAmount, {bool levelUp = false}) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => _XpToastWidget(
        xpAmount: xpAmount,
        levelUp: levelUp,
        onDone: () => entry.remove(),
      ),
    );

    overlay.insert(entry);
  }
}

class _XpToastWidget extends StatefulWidget {
  final int xpAmount;
  final bool levelUp;
  final VoidCallback onDone;

  const _XpToastWidget({
    required this.xpAmount,
    required this.levelUp,
    required this.onDone,
  });

  @override
  State<_XpToastWidget> createState() => _XpToastWidgetState();
}

class _XpToastWidgetState extends State<_XpToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 55),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
    ]).animate(_ctrl);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: const Offset(0, -0.3),
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.15), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 1.0), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 65),
    ]).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    _ctrl.forward().then((_) => widget.onDone());
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.35,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _opacity,
          child: ScaleTransition(
            scale: _scale,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: widget.levelUp
                      ? QuestFitColors.gold.withValues(alpha: 0.95)
                      : QuestFitColors.emerald.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: (widget.levelUp
                              ? QuestFitColors.gold
                              : QuestFitColors.emerald)
                          .withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Text(
                  widget.levelUp
                      ? '⚡ LEVEL UP! +${widget.xpAmount} XP'
                      : '+${widget.xpAmount} XP',
                  style: TextStyle(
                    fontSize: widget.levelUp ? 18 : 16,
                    fontWeight: FontWeight.w900,
                    color: widget.levelUp
                        ? const Color(0xFF1A1200)
                        : QuestFitColors.bgDark,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
