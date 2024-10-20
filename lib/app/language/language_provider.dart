import 'package:flutter/material.dart';
import 'package:habit_away/app/app.dart';
import 'package:user_storage/user_storage.dart';

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale;

  LanguageProvider({required String initialLanguage}) 
    : _currentLocale = Locale(initialLanguage);

  Locale get currentLocale => _currentLocale;

  Future<void> changeLanguage(String languageCode) async {
    _currentLocale = Locale(languageCode);
    await getIt<UserStorage>().saveUserLanguage(languageCode);
    notifyListeners();
  }

}
