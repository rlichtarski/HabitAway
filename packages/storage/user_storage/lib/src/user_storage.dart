import 'package:shared/shared.dart';
import 'package:storage/storage.dart';

class UserStorage {

  UserStorage({required this.storage});
  final Storage storage;

  Future<bool> hasSeenOnboarding() async {
    final value = await storage.read(key: ConstantKeys.hasSeenOnboardingKey);
    return value != null;
  }

  Future<void> markOnboardingSeen() async {
    await storage.write(key: ConstantKeys.hasSeenOnboardingKey, value: 'true');
  }

  Future<String?> getUserLanguage() async {
    return storage.read(key: ConstantKeys.userLanguage);
  }

  Future<void> saveUserLanguage(String languageCode) async {
    await storage.write(key: ConstantKeys.userLanguage, value: languageCode);
  }

}
