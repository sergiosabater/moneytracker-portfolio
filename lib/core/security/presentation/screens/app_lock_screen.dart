import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneytracker/core/security/app_lock_notifier.dart';
import 'package:moneytracker/core/security/biometric_provider.dart';
import 'package:moneytracker/core/security/presentation/screens/biometric_prompt_screen.dart';
import 'package:moneytracker/core/security/presentation/screens/pin_unlock_screen.dart';
import 'package:moneytracker/l10n/app_localizations.dart';

enum _AppLockStep { biometric, pin }

/// Decides which unlock screen to show when the app starts locked (see
/// [AppLockNotifier]): biometric authentication first if the user has
/// it enabled, falling back to (or starting directly with) the PIN
/// screen otherwise. Neither underlying screen needs to know about the
/// other — this is the only place that sequences them.
class AppLockScreen extends ConsumerStatefulWidget {
  const AppLockScreen({super.key});

  @override
  ConsumerState<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends ConsumerState<AppLockScreen> {
  late _AppLockStep _step;

  @override
  void initState() {
    super.initState();
    final biometricEnabled = ref.read(biometricNotifierProvider);
    _step = biometricEnabled ? _AppLockStep.biometric : _AppLockStep.pin;
  }

  void _fallBackToPin() => setState(() => _step = _AppLockStep.pin);

  @override
  Widget build(BuildContext context) {
    if (_step == _AppLockStep.biometric) {
      return BiometricPromptScreen(
        reason: AppLocalizations.of(context)!.biometricUnlockReason,
        showPinFallback: true,
        onSuccess: () => ref.read(appLockNotifierProvider.notifier).unlock(),
        onFallback: _fallBackToPin,
      );
    }

    return const PinUnlockScreen();
  }
}