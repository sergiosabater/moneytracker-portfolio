// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$securityNotifierHash() => r'98de2f694c60e6c8a972ebb361ef259fb8eb6fb5';

/// Exposes the app's current [SecuritySettings], derived from the real
/// PIN status. Biometric authentication is still a disabled placeholder
/// (SettingsScreen's toggle is hardcoded to `value: false, onChanged:
/// null`) — once implemented, following the same PreferencesService +
/// Notifier pattern, this is the only place that needs to change.
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
