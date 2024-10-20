import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_away/app/routes/app_routes.dart';
import 'package:habit_away/app/service_locator/service_locator.dart';
import 'package:habit_away/l10n/l10n.dart';
import 'package:user_storage/user_storage.dart';

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
    final l10n = context.l10n;
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      releaseFocus: true,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.icons.welcome.image(),
            Text(l10n.welcomeText, style: UITextStyle.headline5),
            const SizedBox(height: AppSpacing.xxs),
            Text('${l10n.habitAway}!', style: UITextStyle.headline2),
            const SizedBox(height: AppSpacing.xxlg),
            ElevatedButton(
              onPressed: () async {
                final prefsService = getIt<UserStorage>();
                await prefsService.markOnboardingSeen();
                
                if (context.mounted) {
                  context.go(AppRoutes.auth.route);
                }
              },
              child: Text(l10n.getStarted, style: UITextStyle.button,),
            ),
          ],
        ),
      ),
    );
  }
}
