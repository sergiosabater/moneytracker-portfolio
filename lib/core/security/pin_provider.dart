import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:moneytracker/core/security/pin_service.dart';

part 'pin_provider.g.dart';

@Riverpod(keepAlive: true)
PinService pinService(Ref ref) => PinService();

/// Exposes whether the app currently has a PIN configured.
/// Widgets (like the PIN toggle in Settings) watch this to know the
/// current on/off state, and call [refresh] after setting or clearing
/// the PIN to keep it in sync.
@Riverpod(keepAlive: true)
class PinStatusNotifier extends _$PinStatusNotifier {
  @override
  Future<bool> build() async {
    final service = ref.watch(pinServiceProvider);
    return service.isPinSet();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}