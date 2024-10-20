import 'package:go_router/go_router.dart';
import 'package:habit_away/app/routes/routes.dart';
import 'package:habit_away/auth/view/auth_page.dart';
import 'package:habit_away/onboarding/onboarding.dart';
import 'package:user_storage/user_storage.dart';

class AppRouter {
  GoRouter router(UserStorage userStorage) => GoRouter(
    initialLocation: AppRoutes.onboarding.route,
    routes: [
       GoRoute(
        path: AppRoutes.onboarding.route,
        name: AppRoutes.onboarding.name,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.auth.route,
        name: AppRoutes.auth.name,
        builder: (context, state) => const AuthPage(),
      ),
    ],
    redirect: (context, state) async {
      final hasSeenOnboarding = await userStorage.hasSeenOnboarding();

      if (!hasSeenOnboarding) {
        return AppRoutes.onboarding.route;
      } else {
        return AppRoutes.auth.route;
      }
    },
    
  );
}
