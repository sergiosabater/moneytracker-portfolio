import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneytracker/core/security/security_notifier.dart';

/// Guards sensitive actions (like clearing all app data) behind the
/// user's security settings. Call [verify] right before performing the
/// action; it resolves to `true` when it's safe to proceed.
///
/// Today, since PIN code and biometric authentication aren't implemented
/// yet, [SecurityNotifier] always reports them as disabled, so [verify]
/// always resolves to `true` immediately — the gate is present and
/// correctly wired, but currently a no-op pass-through. When real PIN/
/// biometric verification is added, only the `requiresVerification`
/// branch below needs an actual implementation (showing a PIN entry
/// screen, or calling `local_auth`); every call site that already uses
/// [SecurityGate.verify] will start enforcing it automatically, with no
/// changes needed at the call site.
class SecurityGate {
  SecurityGate._();

  static Future<bool> verify(WidgetRef ref) async {
    final settings = ref.read(securityNotifierProvider);

    if (!settings.requiresVerification) {
      return true;
    }

    // TODO: once PIN code / biometric authentication are implemented,
    // trigger the appropriate verification flow here and return its
    // result instead of this placeholder.
    throw UnimplementedError(
      'Security verification is enabled but not yet implemented.',
    );
  }
}