import 'package:go_router/go_router.dart';

import '../ui/splash/widgets/splash_screen.dart';
import '../ui/home/widgets/home_screen.dart';

/// Rotas do SafeHouse.
class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
