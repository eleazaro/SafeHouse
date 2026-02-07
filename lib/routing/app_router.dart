import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ui/auth/view_models/auth_view_model.dart';
import '../ui/auth/widgets/login_screen.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/property_detail/widgets/property_detail_screen.dart';
import '../ui/splash/widgets/splash_screen.dart';

/// Rotas do SafeHouse com auth guard.
class AppRouter {
  static GoRouter router(AuthViewModel authViewModel) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable: authViewModel,
      redirect: (context, state) {
        final isAuthenticated = authViewModel.isAuthenticated;
        final isOnSplash = state.matchedLocation == '/';
        final isOnLogin = state.matchedLocation == '/login';

        // Splash handles its own navigation
        if (isOnSplash) return null;

        // Not authenticated → go to login
        if (!isAuthenticated && !isOnLogin) return '/login';

        // Authenticated but on login → go to home
        if (isAuthenticated && isOnLogin) return '/home';

        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/property/:id',
          pageBuilder: (context, state) {
            final id = state.pathParameters['id']!;
            return CustomTransitionPage(
              key: state.pageKey,
              child: PropertyDetailScreen(propertyId: id),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 300),
            );
          },
        ),
      ],
    );
  }
}
