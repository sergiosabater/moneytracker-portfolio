/// Represents the current state of the app's security options. Kept
/// intentionally simple: two booleans and a derived getter. This is the
/// single place that will need to change once PIN code and biometric
/// authentication toggles become functional (currently they're disabled
/// placeholders in SettingsScreen).
class SecuritySettings {
  final bool pinEnabled;
  final bool biometricEnabled;

  const SecuritySettings({
    this.pinEnabled = false,
    this.biometricEnabled = false,
  });

  /// True if the user needs to pass some form of verification before a
  /// sensitive action (like clearing all data) is allowed to proceed.
  bool get requiresVerification => pinEnabled || biometricEnabled;
}