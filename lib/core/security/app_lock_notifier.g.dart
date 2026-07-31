// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_lock_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$initialAppLockStateHash() =>
    r'bbd7bbe243bc80d354e61f498a3b1f7fdc17821f';

/// Holds the initial lock state, computed in `main()` (by checking
/// [PinService.isPinSet] before `runApp`) and injected via
/// [ProviderScope] overrides — the same pattern used for
/// [preferencesServiceProvider]. This avoids a one-frame flash of
/// unlocked content while an async check would otherwise still be
/// resolving.
///
/// Copied from [initialAppLockState].
@ProviderFor(initialAppLockState)
final initialAppLockStateProvider = Provider<AppLockState>.internal(
  initialAppLockState,
  name: r'initialAppLockStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$initialAppLockStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InitialAppLockStateRef = ProviderRef<AppLockState>;
String _$appLockNotifierHash() => r'4a45026aa03a654b03c95ae102d71ac7bebf2d8b';

/// Tracks whether the app is currently locked behind the PIN screen.
/// Starts at whatever [initialAppLockStateProvider] resolves to, and
/// moves to [AppLockState.unlocked] once [unlock] is called after a
/// successful PIN entry.
///
/// Copied from [AppLockNotifier].
@ProviderFor(AppLockNotifier)
final appLockNotifierProvider =
    NotifierProvider<AppLockNotifier, AppLockState>.internal(
      AppLockNotifier.new,
      name: r'appLockNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appLockNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppLockNotifier = Notifier<AppLockState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
