// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$securityNotifierHash() => r'6c97e91c78520d4b8f598bfd057f24edcf675801';

/// Exposes the app's current [SecuritySettings], derived from the real
/// PIN and biometric state. This is what [SecurityGate] reads to decide
/// whether — and how — to challenge a sensitive action.
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
