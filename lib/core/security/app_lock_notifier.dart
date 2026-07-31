import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_lock_notifier.g.dart';

enum AppLockState { locked, unlocked }

/// Holds the initial lock state, computed in `main()` (by checking
/// [PinService.isPinSet] before `runApp`) and injected via
/// [ProviderScope] overrides — the same pattern used for
/// [preferencesServiceProvider]. This avoids a one-frame flash of
/// unlocked content while an async check would otherwise still be
/// resolving.
@Riverpod(keepAlive: true)
AppLockState initialAppLockState(Ref ref) {
  throw UnimplementedError(
    'initialAppLockStateProvider must be overridden in ProviderScope',
  );
}

/// Tracks whether the app is currently locked behind the PIN screen.
/// Starts at whatever [initialAppLockStateProvider] resolves to, and
/// moves to [AppLockState.unlocked] once [unlock] is called after a
/// successful PIN entry.
@Riverpod(keepAlive: true)
class AppLockNotifier extends _$AppLockNotifier {
  @override
  AppLockState build() => ref.watch(initialAppLockStateProvider);

  void unlock() => state = AppLockState.unlocked;
}