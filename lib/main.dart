import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneytracker/core/locale/locale_notifier.dart';
import 'package:moneytracker/core/router/app_router.dart';
import 'package:moneytracker/core/security/app_lock_notifier.dart';
import 'package:moneytracker/core/security/pin_service.dart';
import 'package:moneytracker/core/security/presentation/screens/app_lock_screen.dart';
import 'package:moneytracker/core/services/preferences_provider.dart';
import 'package:moneytracker/core/services/preferences_service.dart';
import 'package:moneytracker/core/theme/app_theme.dart';
import 'package:moneytracker/core/theme/theme_notifier.dart';
import 'package:moneytracker/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferencesService = await PreferencesService.create();

  // Resolved before runApp so the app never briefly shows unlocked
  // content while this async check would otherwise still be pending.
  final isPinSet = await PinService().isPinSet();
  final initialLockState =
      isPinSet ? AppLockState.locked : AppLockState.unlocked;

  // Draw the app edge-to-edge and keep the status bar transparent.
  // Force status bar icons/text to be white on both Android and iOS.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Android: white icons
      statusBarBrightness: Brightness.dark, // iOS: white icons
    ),
  );

  runApp(
    ProviderScope(
      overrides: [
        preferencesServiceProvider.overrideWithValue(preferencesService),
        initialAppLockStateProvider.overrideWithValue(initialLockState),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    final localeOption = ref.watch(localeNotifierProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      locale: localeOption.toLocale(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('de'),
        Locale('pl'),
      ],
      title: 'Money Tracker',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode.toThemeMode(),
      debugShowCheckedModeBanner: false,
      // Wraps whatever GoRouter builds. While the app is locked, this
      // replaces it entirely with the PIN screen — same MaterialApp
      // instance underneath, so theme/locale/etc. still apply.
      builder: (context, child) {
        return Consumer(
          builder: (context, ref, _) {
            final lockState = ref.watch(appLockNotifierProvider);
            if (lockState == AppLockState.locked) {
              return const AppLockScreen();
            }
            return child!;
          },
        );
      },
    );
  }
}
