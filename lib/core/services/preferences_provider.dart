import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:moneytracker/core/services/preferences_service.dart';

part 'preferences_provider.g.dart';

// Provides the [PreferencesService] singleton to the rest of the app.

@Riverpod(keepAlive: true)
PreferencesService preferencesService(Ref ref) {
  throw UnimplementedError(
    'preferencesServiceProvider must be overridden in ProviderScope',
  );
}