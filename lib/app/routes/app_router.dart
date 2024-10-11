import 'package:go_router/go_router.dart';
import 'package:habit_away/app/routes/routes.dart';
import 'package:habit_away/auth/view/auth_page.dart';
import 'package:habit_away/onboarding/onboarding.dart';
import 'package:onboarding_storage/onboarding_storage.dart';

class AppRouter {
  GoRouter router(OnboardingStorageService onboardingStorage) => GoRouter(
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
      final hasSeenOnboarding = await onboardingStorage.hasSeenOnboarding();

      if (!hasSeenOnboarding) {
        return AppRoutes.onboarding.route;
      } else {
        return AppRoutes.auth.route;
      }
    },
    
  );
}
