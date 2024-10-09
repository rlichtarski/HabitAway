import 'package:env/env.dart';
import 'package:flutter/material.dart';
import 'package:habit_away/app/service_locator/service_locator.dart';
import 'package:habit_away/l10n/l10n.dart';
import 'package:shared/shared.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SafeArea(
        child: Scaffold(
          body: Text(getIt<AppFlavor>().getEnv(Env.iOSClientId)),
        ),
      ),
    );
  }
}
