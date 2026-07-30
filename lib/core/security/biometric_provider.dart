import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:moneytracker/core/security/biometric_service.dart';
import 'package:moneytracker/core/services/preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'biometric_provider.g.dart';

@Riverpod(keepAlive: true)
BiometricService biometricService(Ref ref) => BiometricService();

/// Whether this device can actually offer biometric authentication
/// (hardware present, OS supported, and at least one biometric already
/// enrolled by the user in system settings). Checked once and kept
/// alive — device capability doesn't change while the app is running.
@Riverpod(keepAlive: true)
Future<bool> biometricAvailability(Ref ref) {
  return ref.watch(biometricServiceProvider).isAvailable();
}

/// Whether the user has turned biometric authentication on in Settings.
/// Persisted via [PreferencesService], following the same pattern as
/// [ThemeNotifier]/[LocaleNotifier]/[CurrencyNotifier].
@Riverpod(keepAlive: true)
class BiometricNotifier extends _$BiometricNotifier {
  @override
  bool build() {
    final preferences = ref.watch(preferencesServiceProvider);
    return preferences.getBiometricEnabled();
  }

  Future<void> setEnabled(bool enabled) async {
    state = enabled;
    final preferences = ref.read(preferencesServiceProvider);
    await preferences.saveBiometricEnabled(enabled);
  }
}
