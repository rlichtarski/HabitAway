import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habit_away/app/language/language_provider.dart';
import 'package:habit_away/app/routes/routes.dart';
import 'package:habit_away/app/service_locator/service_locator.dart';
import 'package:habit_away/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:user_storage/user_storage.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter().router(getIt<UserStorage>());
    return ChangeNotifierProvider(
      create: (context) => getIt<LanguageProvider>(),
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: const AppTheme().theme,
            darkTheme: const AppDarkTheme().theme,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('pl'),
            ],
            locale: languageProvider.currentLocale,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
