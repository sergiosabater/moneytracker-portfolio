// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$securityNotifierHash() => r'99c9fbcb1e09b289cc55cf0f24bcc08e78859002';

/// Exposes the app's current [SecuritySettings]. Today this always
/// returns disabled settings, since PIN code and biometric authentication
/// are UI-only placeholders (SettingsScreen's toggles are hardcoded to
/// `value: false, onChanged: null`). This provider is the single
/// extension point for that future work: once the toggles persist a real
/// value (following the same PreferencesService + Notifier pattern as
/// ThemeNotifier/LocaleNotifier/CurrencyNotifier), `build()` here is the
/// only place that needs to change — nothing that depends on this
/// provider (like SecurityGate) will need to be touched.
///
/// Copied from [SecurityNotifier].
@ProviderFor(SecurityNotifier)
final securityNotifierProvider =
    NotifierProvider<SecurityNotifier, SecuritySettings>.internal(
      SecurityNotifier.new,
      name: r'securityNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$securityNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SecurityNotifier = Notifier<SecuritySettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
