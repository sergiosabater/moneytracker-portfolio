import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Row of dots representing PIN digits entered so far.
///
/// [errorTrigger] is a simple "nonce" pattern for one-shot animations:
/// increment it every time a wrong PIN is submitted, and this widget will
/// shake, flash the dots, and trigger a haptic buzz — without needing an
/// external AnimationController or GlobalKey. Any screen reusing this
/// widget (setup mismatch, verify failure, future unlock screen) gets
/// this feedback automatically, with nothing to wire up on its own.
class PinDots extends StatefulWidget {
  final int length;
  final int filledCount;
  final int errorTrigger;

  const PinDots({
    super.key,
    required this.length,
    required this.filledCount,
    this.errorTrigger = 0,
  });

  @override
  State<PinDots> createState() => _PinDotsState();
}

class _PinDotsState extends State<PinDots> with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeController, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(PinDots oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorTrigger != oldWidget.errorTrigger) {
      HapticFeedback.vibrate();
      _shakeController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0),
          child: child,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.length, (index) {
          final isFilled = index < widget.filledCount;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFilled ? Colors.white : Colors.white.withValues(alpha: 0.25),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.6),
                width: 1.5,
              ),
            ),
          );
        }),
      ),
    );
  }
}