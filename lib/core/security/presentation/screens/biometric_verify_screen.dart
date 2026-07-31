import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moneytracker/core/security/presentation/screens/biometric_prompt_screen.dart';
import 'package:moneytracker/l10n/app_localizations.dart';

/// Thin routed wrapper around [BiometricPromptScreen], adapting its
/// callback-based result into a standard `Navigator.pop` — used by
/// [SecurityGate] for one-off verification (e.g. before clearing data).
/// [AppLockScreen] sequences the same underlying screen without a
/// navigation stack, since it has none to pop; this wrapper exists
/// specifically for contexts that do.
class BiometricVerifyScreen extends StatelessWidget {
  const BiometricVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BiometricPromptScreen(
      reason: AppLocalizations.of(context)!.biometricVerifyReason,
      showPinFallback: true,
      onSuccess: () => Navigator.of(context).pop(true),
      onFallback: () async {
        final verified = await context.push<bool>('/settings/pin-verify');
        if (!context.mounted) return;
        Navigator.of(context).pop(verified ?? false);
      },
    );
  }
}