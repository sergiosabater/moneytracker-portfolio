import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:moneytracker/core/security/security_settings.dart';

part 'security_notifier.g.dart';

/// Exposes the app's current [SecuritySettings]. Today this always
/// returns disabled settings, since PIN code and biometric authentication
/// are UI-only placeholders (SettingsScreen's toggles are hardcoded to
/// `value: false, onChanged: null`). This provider is the single
/// extension point for that future work: once the toggles persist a real
/// value (following the same PreferencesService + Notifier pattern as
/// ThemeNotifier/LocaleNotifier/CurrencyNotifier), `build()` here is the
/// only place that needs to change — nothing that depends on this
/// provider (like SecurityGate) will need to be touched.
@Riverpod(keepAlive: true)
class SecurityNotifier extends _$SecurityNotifier {
  @override
  SecuritySettings build() {
    return const SecuritySettings();
  }
}