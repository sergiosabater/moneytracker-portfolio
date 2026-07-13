import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moneytracker/core/security/security_notifier.dart';

/// Guards sensitive actions (like clearing all app data) behind the
/// user's security settings. Call [verify] right before performing the
/// action; it resolves to `true` when it's safe to proceed.
///
/// If no security option is enabled, resolves to `true` immediately. If
/// a PIN is set, pushes the PIN verification screen and waits for the
/// result.
class SecurityGate {
  SecurityGate._();

  static Future<bool> verify(BuildContext context, WidgetRef ref) async {
    final settings = ref.read(securityNotifierProvider);

    if (!settings.requiresVerification) {
      return true;
    }

    final verified = await context.push<bool>('/settings/pin-verify');
    return verified ?? false;
  }
}