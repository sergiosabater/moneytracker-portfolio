import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:moneytracker/core/security/biometric_provider.dart';
import 'package:moneytracker/core/security/pin_provider.dart';
import 'package:moneytracker/core/security/security_settings.dart';

part 'security_notifier.g.dart';

/// Exposes the app's current [SecuritySettings], derived from the real
/// PIN and biometric state. This is what [SecurityGate] reads to decide
/// whether — and how — to challenge a sensitive action.
@Riverpod(keepAlive: true)
class SecurityNotifier extends _$SecurityNotifier {
  @override
  SecuritySettings build() {
    final isPinSet = ref.watch(pinStatusNotifierProvider).value ?? false;
    final isBiometricEnabled = ref.watch(biometricNotifierProvider);
    return SecuritySettings(
      pinEnabled: isPinSet,
      biometricEnabled: isBiometricEnabled,
    );
  }
}