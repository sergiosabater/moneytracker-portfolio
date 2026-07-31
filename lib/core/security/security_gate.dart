import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moneytracker/core/security/security_notifier.dart';

/// Guards sensitive actions (like clearing all app data) behind the
/// user's security settings. Call [verify] right before performing the
/// action; it resolves to `true` when it's safe to proceed.
///
/// If no security option is enabled, resolves to `true` immediately.
/// If biometric authentication is enabled, it's tried first (with its
/// own built-in PIN fallback); otherwise, if only a PIN is set, the PIN
/// verification screen is used directly.
class SecurityGate {
  SecurityGate._();

  static Future<bool> verify(BuildContext context, WidgetRef ref) async {
    final settings = ref.read(securityNotifierProvider);

    if (!settings.requiresVerification) {
      return true;
    }

    final route = settings.biometricEnabled
        ? '/settings/biometric-verify'
        : '/settings/pin-verify';

    final verified = await context.push<bool>(route);
    return verified ?? false;
  }
}