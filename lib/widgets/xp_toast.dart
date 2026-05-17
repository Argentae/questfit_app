import 'package:flutter/material.dart';
import '../app/theme.dart';

/// Floating "+LP" toast that fades in, floats up, then fades out.
///
/// v3.0: Renamed from XP toast to LP toast. Also handles promotion banners.
class LpToast {
  static void show(BuildContext context, int lpAmount, {bool promoted = false}) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => _LpToastWidget(
        lpAmount: lpAmount,
        promoted: promoted,
        onDone: () => entry.remove(),
      ),
    );

    overlay.insert(entry);
  }
}

/// Keep old name as alias for backward compatibility.
typedef XpToast = LpToast;

class _LpToastWidget extends StatefulWidget {
  final int lpAmount;
  final bool promoted;
  final VoidCallback onDone;

  const _LpToastWidget({
    required this.lpAmount,
    required this.promoted,
    required this.onDone,
  });

  @override
  State<_LpToastWidget> createState() => _LpToastWidgetState();
}

class _LpToastWidgetState extends State<_LpToastWidget>
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
                  color: widget.promoted
                      ? QuestFitColors.gold.withValues(alpha: 0.95)
                      : QuestFitColors.emerald.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: (widget.promoted
                              ? QuestFitColors.gold
                              : QuestFitColors.emerald)
                          .withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Text(
                  widget.promoted
                      ? '⚡ PROMOTION READY! +${widget.lpAmount} LP'
                      : '+${widget.lpAmount} LP',
                  style: TextStyle(
                    fontSize: widget.promoted ? 18 : 16,
                    fontWeight: FontWeight.w900,
                    color: widget.promoted
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
