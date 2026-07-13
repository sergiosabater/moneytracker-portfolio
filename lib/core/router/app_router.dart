import 'package:go_router/go_router.dart';
import 'package:moneytracker/core/security/presentation/screens/pin_setup_screen.dart';
import 'package:moneytracker/core/security/presentation/screens/pin_verify_screen.dart';
import 'package:moneytracker/features/settings/presentation/screens/about_screen.dart';
import 'package:moneytracker/features/settings/presentation/screens/settings_screen.dart';
import 'package:moneytracker/features/transactions/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsScreen(),
          routes: [
            GoRoute(
              path: 'about',
              builder: (context, state) => const AboutScreen(),
            ),
            GoRoute(
              path: 'pin-setup',
              builder: (context, state) => const PinSetupScreen(),
            ),
            GoRoute(
              path: 'pin-verify',
              builder: (context, state) => const PinVerifyScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);