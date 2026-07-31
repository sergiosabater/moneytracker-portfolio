import 'package:local_auth/local_auth.dart';

/// Wraps [LocalAuthentication], the platform-agnostic biometric API
/// (Face ID / Touch ID on iOS, fingerprint / face unlock on Android —
/// the OS decides which one to offer based on what the device and user
/// have configured; the app never picks a specific biometric type).
class BiometricService {
  final LocalAuthentication _auth;

  BiometricService({LocalAuthentication? auth})
      : _auth = auth ?? LocalAuthentication();

  /// Whether this device has biometric hardware AND the user has at
  /// least one biometric enrolled (e.g. a fingerprint registered in
  /// system settings). If this is false, the toggle in Settings
  /// shouldn't be offered at all — there's nothing to authenticate with.
  Future<bool> isAvailable() async {
    final canCheck = await _auth.canCheckBiometrics;
    final isSupported = await _auth.isDeviceSupported();
    if (!canCheck || !isSupported) return false;

    final enrolled = await _auth.getAvailableBiometrics();
    return enrolled.isNotEmpty;
  }

  /// Triggers the OS biometric prompt and resolves to whether it
  /// succeeded. Resolves to `false` (rather than throwing) for any
  /// failure reason — wrong fingerprint, user cancellation, lockout,
  /// or no biometrics enrolled — since the caller only needs to know
  /// "did it work", and always offers a PIN fallback regardless of why
  /// it didn't.
  Future<bool> authenticate(String reason) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }

  /// Cancels any in-flight authentication and dismisses the native
  /// biometric UI (Face ID's system sheet on iOS, the BiometricPrompt
  /// dialog on Android). Must be called before navigating away while an
  /// [authenticate] call is still pending — otherwise, on iOS
  /// specifically, the Face ID sheet can linger on screen after the app
  /// has already moved to a different screen underneath it.
  Future<void> cancelAuthentication() => _auth.stopAuthentication();
}