// ignore_for_file: cascade_invocations

import 'package:get_it/get_it.dart';
import 'package:onboarding_storage/onboarding_storage.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator({AppFlavor? appFlavor}) async {
  final flavor = appFlavor ?? AppFlavor.development();
  getIt.registerSingleton<AppFlavor>(flavor);

  final sharedPreferences = await SharedPreferences.getInstance();
  final storage = PersistentStorage(sharedPreferences: sharedPreferences);

  getIt.registerSingleton<Storage>(storage);

  getIt.registerSingleton<OnboardingStorageService>(
    OnboardingStorageService(storage: storage),
  );
}
