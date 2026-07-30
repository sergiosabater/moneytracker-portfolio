import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneytracker/core/security/biometric_provider.dart';
import 'package:moneytracker/core/theme/app_colors.dart';
import 'package:moneytracker/l10n/app_localizations.dart';

enum _BiometricPromptState { waiting, success, error }

/// Full-screen biometric prompt. Triggers OS-level authentication
/// automatically as soon as it appears, and reflects the outcome with
/// its own success/error UI — since the OS's native biometric dialog
/// only reports a final result, not live scan progress, this screen
/// can't animate the scan itself, only what happens before and after it.
///
/// Pops `true` on success, `false` if the user backs out or taps
/// "Try another way" (when a PIN fallback is available).
class BiometricPromptScreen extends ConsumerStatefulWidget {
  final String reason;
  final bool showPinFallback;

  const BiometricPromptScreen({
    super.key,
    required this.reason,
    required this.showPinFallback,
  });

  @override
  ConsumerState<BiometricPromptScreen> createState() =>
      _BiometricPromptScreenState();
}

class _BiometricPromptScreenState
    extends ConsumerState<BiometricPromptScreen> {
  _BiometricPromptState _state = _BiometricPromptState.waiting;

  @override
  void initState() {
    super.initState();
    // Slight delay so the screen (and its icon) is actually visible for
    // a beat before the OS's own biometric dialog appears on top of it.
    Future.delayed(const Duration(milliseconds: 300), _authenticate);
  }

  Future<void> _authenticate() async {
    if (!mounted) return;
    setState(() => _state = _BiometricPromptState.waiting);

    final success = await ref
        .read(biometricServiceProvider)
        .authenticate(widget.reason);

    if (!mounted) return;

    if (success) {
      setState(() => _state = _BiometricPromptState.success);
      // Let the success check animate before popping.
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;
      Navigator.of(context).pop(true);
      return;
    }

    HapticFeedback.vibrate();
    setState(() => _state = _BiometricPromptState.error);
  }

  void _tryPinInstead() => Navigator.of(context).pop(false);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const Spacer(flex: 2),
                Text(
                  l10n.appTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(flex: 2),
                _BiometricIcon(state: _state),
                const SizedBox(height: 24),
                SizedBox(
                  height: 44,
                  child: Center(child: _buildStatusText(l10n)),
                ),
                const Spacer(flex: 3),
                if (widget.showPinFallback)
                  TextButton(
                    onPressed: _tryPinInstead,
                    child: Text(
                      l10n.tryAnotherWay,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildStatusText(AppLocalizations l10n) {
    switch (_state) {
      case _BiometricPromptState.waiting:
        return Text(
          l10n.biometricPromptSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 15,
          ),
        );
      case _BiometricPromptState.success:
        return null;
      case _BiometricPromptState.error:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.biometricNotRecognized,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _authenticate,
              child: Text(
                l10n.tryAgain,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
    }
  }
}

class _BiometricIcon extends StatefulWidget {
  final _BiometricPromptState state;

  const _BiometricIcon({required this.state});

  @override
  State<_BiometricIcon> createState() => _BiometricIconState();
}

class _BiometricIconState extends State<_BiometricIcon>
    with SingleTickerProviderStateMixin {
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
  void didUpdateWidget(_BiometricIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state == _BiometricPromptState.error &&
        oldWidget.state != _BiometricPromptState.error) {
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
    final isError = widget.state == _BiometricPromptState.error;
    final isSuccess = widget.state == _BiometricPromptState.success;

    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0),
          child: child,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: isError ? 0.15 : 0.12),
          border: Border.all(
            color: Colors.white.withValues(alpha: isError ? 0.8 : 0.5),
            width: 2,
          ),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: isSuccess
                ? const Icon(
                    Icons.check_circle,
                    key: ValueKey('success'),
                    color: Colors.white,
                    size: 56,
                  )
                : Icon(
                    Icons.fingerprint,
                    key: const ValueKey('fingerprint'),
                    color: Colors.white,
                    size: 64,
                  ),
          ),
        ),
      ),
    );
  }
}