import 'package:go_router/go_router.dart';
import 'package:moneytracker/features/transactions/presentation/screens/home_screen.dart';

/// Centralized declarative navigation configuration for the app.
/// New routes (settings, about, etc.) will be registered here as
/// the app grows.
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);