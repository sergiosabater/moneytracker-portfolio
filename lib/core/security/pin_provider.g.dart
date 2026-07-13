// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pinServiceHash() => r'bf1dd1c71fbdc18aea66afe776324414e3903658';

/// See also [pinService].
@ProviderFor(pinService)
final pinServiceProvider = Provider<PinService>.internal(
  pinService,
  name: r'pinServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pinServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PinServiceRef = ProviderRef<PinService>;
String _$pinStatusNotifierHash() => r'463b93e201c3c6a0a7e454a4b03c7f7270518133';

/// Exposes whether the app currently has a PIN configured.
/// Widgets (like the PIN toggle in Settings) watch this to know the
/// current on/off state, and call [refresh] after setting or clearing
/// the PIN to keep it in sync.
///
/// Copied from [PinStatusNotifier].
@ProviderFor(PinStatusNotifier)
final pinStatusNotifierProvider =
    AsyncNotifierProvider<PinStatusNotifier, bool>.internal(
      PinStatusNotifier.new,
      name: r'pinStatusNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pinStatusNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PinStatusNotifier = AsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
