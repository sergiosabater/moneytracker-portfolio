import 'package:flutter/material.dart';
import 'package:moneytracker/core/security/pin_service.dart';
import 'package:moneytracker/core/security/presentation/widgets/pin_dots.dart';
import 'package:moneytracker/core/security/presentation/widgets/pin_keypad.dart';
import 'package:moneytracker/core/theme/app_colors.dart';

/// Reusable full-screen PIN entry UI. Purely presentational and
/// context-agnostic — it doesn't know whether it's being used to create,
/// confirm, verify, or unlock a PIN. The caller decides what happens
/// when 4 digits are entered via [onCompleted].
///
/// Set [animateEntrance] to true for a staggered entrance: the header
/// group (icon/title/subtitle/dots) slides down and fades in, while the
/// keypad slides up from the bottom — used for the app-open lock screen,
/// left off for setup/verify flows reached via normal navigation.
class PinEntryScreen extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? errorMessage;
  final int errorTrigger;
  final ValueChanged<String> onCompleted;
  final VoidCallback? onBack;
  final bool animateEntrance;

  const PinEntryScreen({
    super.key,
    required this.title,
    this.subtitle,
    this.errorMessage,
    this.errorTrigger = 0,
    required this.onCompleted,
    this.onBack,
    this.animateEntrance = false,
  });

  @override
  State<PinEntryScreen> createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _digits = [];

  AnimationController? _entranceController;
  Animation<double>? _headerFade;
  Animation<Offset>? _headerSlide;
  Animation<double>? _keypadFade;
  Animation<Offset>? _keypadSlide;

  @override
  void initState() {
    super.initState();

    if (widget.animateEntrance) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 700),
        vsync: this,
      );
      _entranceController = controller;

      _headerFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
        ),
      );
      _headerSlide = Tween<Offset>(
        begin: const Offset(0, -0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
        ),
      );

      _keypadFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
        ),
      );
      _keypadSlide = Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
        ),
      );

      controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant PinEntryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorTrigger != oldWidget.errorTrigger) {
      setState(() => _digits.clear());
    }
  }

  @override
  void dispose() {
    _entranceController?.dispose();
    super.dispose();
  }

  void _onDigit(String digit) {
    if (_digits.length >= PinService.pinLength) return;

    setState(() => _digits.add(digit));

    if (_digits.length == PinService.pinLength) {
      final pin = _digits.join();
      // Let the last dot render for a beat before handing off, so the
      // user sees all 4 dots filled instead of the screen reacting
      // (navigating away / showing an error) on the exact same frame.
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) widget.onCompleted(pin);
      });
    }
  }

  void _onBackspace() {
    if (_digits.isEmpty) return;
    setState(() => _digits.removeLast());
  }

  @override
  Widget build(BuildContext context) {
    Widget header = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock_outline,
          color: Colors.white.withValues(alpha: 0.9),
          size: 40,
        ),
        const SizedBox(height: 20),
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (widget.subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.subtitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
        ],
        const SizedBox(height: 32),
        PinDots(
          length: PinService.pinLength,
          filledCount: _digits.length,
          errorTrigger: widget.errorTrigger,
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 24,
          child: widget.errorMessage != null
              ? Text(
                  widget.errorMessage!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                )
              : null,
        ),
      ],
    );

    Widget keypad = Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: PinKeypad(
        onDigitPressed: _onDigit,
        onBackspacePressed: _onBackspace,
      ),
    );

    if (widget.animateEntrance) {
      header = FadeTransition(
        opacity: _headerFade!,
        child: SlideTransition(position: _headerSlide!, child: header),
      );
      keypad = FadeTransition(
        opacity: _keypadFade!,
        child: SlideTransition(position: _keypadSlide!, child: keypad),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.headerGradient(Theme.of(context).brightness),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (widget.onBack != null)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        onPressed: widget.onBack,
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Center(child: header),
                ),
              ),
              keypad,
            ],
          ),
        ),
      ),
    );
  }
}