// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$biometricServiceHash() => r'c28c66fc179eade56af90e4df7c5cd6fc01e79b2';

/// See also [biometricService].
@ProviderFor(biometricService)
final biometricServiceProvider = Provider<BiometricService>.internal(
  biometricService,
  name: r'biometricServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$biometricServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BiometricServiceRef = ProviderRef<BiometricService>;
String _$biometricAvailabilityHash() =>
    r'764f57922c9eebacfb2dbdd1f3ddbdb72b70e8c9';

/// Whether this device can actually offer biometric authentication
/// (hardware present, OS supported, and at least one biometric already
/// enrolled by the user in system settings). Checked once and kept
/// alive — device capability doesn't change while the app is running.
///
/// Copied from [biometricAvailability].
@ProviderFor(biometricAvailability)
final biometricAvailabilityProvider = FutureProvider<bool>.internal(
  biometricAvailability,
  name: r'biometricAvailabilityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$biometricAvailabilityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BiometricAvailabilityRef = FutureProviderRef<bool>;
String _$biometricNotifierHash() => r'0c9b72a0882855465fd775d2bf707dba28f738d2';

/// Whether the user has turned biometric authentication on in Settings.
/// Persisted via [PreferencesService], following the same pattern as
/// [ThemeNotifier]/[LocaleNotifier]/[CurrencyNotifier].
///
/// Copied from [BiometricNotifier].
@ProviderFor(BiometricNotifier)
final biometricNotifierProvider =
    NotifierProvider<BiometricNotifier, bool>.internal(
      BiometricNotifier.new,
      name: r'biometricNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$biometricNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BiometricNotifier = Notifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
