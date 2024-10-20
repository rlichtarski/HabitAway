// ignore_for_file: cascade_invocations

import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:habit_away/app/app.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage.dart';
import 'package:user_storage/user_storage.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator({AppFlavor? appFlavor}) async {
  final flavor = appFlavor ?? AppFlavor.development();
  getIt.registerSingleton<AppFlavor>(flavor);

  final sharedPreferences = await SharedPreferences.getInstance();
  final storage = PersistentStorage(sharedPreferences: sharedPreferences);

  getIt.registerSingleton<Storage>(storage);

  getIt.registerSingleton<UserStorage>(
    UserStorage(storage: storage),
  );

  final initialLanguage = await getIt<UserStorage>()
    .getUserLanguage() ?? Platform.localeName.substring(0, 2);

  getIt.registerSingleton<LanguageProvider>(
    LanguageProvider(initialLanguage: initialLanguage),
  );
  
}
