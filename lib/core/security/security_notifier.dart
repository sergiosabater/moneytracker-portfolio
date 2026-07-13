import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:moneytracker/core/security/pin_provider.dart';
import 'package:moneytracker/core/security/security_settings.dart';

part 'security_notifier.g.dart';

/// Exposes the app's current [SecuritySettings], derived from the real
/// PIN status. Biometric authentication is still a disabled placeholder
/// (SettingsScreen's toggle is hardcoded to `value: false, onChanged:
/// null`) — once implemented, following the same PreferencesService +
/// Notifier pattern, this is the only place that needs to change.
@Riverpod(keepAlive: true)
class SecurityNotifier extends _$SecurityNotifier {
  @override
  SecuritySettings build() {
    final isPinSet = ref.watch(pinStatusNotifierProvider).value ?? false;
    return SecuritySettings(pinEnabled: isPinSet);
  }
}