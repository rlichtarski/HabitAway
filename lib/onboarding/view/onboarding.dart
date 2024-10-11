import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_away/app/routes/app_routes.dart';
import 'package:habit_away/app/service_locator/service_locator.dart';
import 'package:onboarding_storage/onboarding_storage.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingView();
  }
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the App!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final prefsService = getIt<OnboardingStorageService>();
                await prefsService.markOnboardingSeen();
                
                if (context.mounted) {
                  context.go(AppRoutes.auth.route);
                }
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
