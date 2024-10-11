import 'package:flutter/material.dart';
import 'package:habit_away/app/routes/routes.dart';
import 'package:habit_away/app/service_locator/service_locator.dart';
import 'package:habit_away/l10n/l10n.dart';
import 'package:onboarding_storage/onboarding_storage.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter().router(getIt<OnboardingStorageService>());
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
