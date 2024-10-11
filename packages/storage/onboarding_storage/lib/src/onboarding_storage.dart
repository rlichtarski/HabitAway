import 'package:shared/shared.dart';
import 'package:storage/storage.dart';

class OnboardingStorageService {

  OnboardingStorageService({required this.storage});
  final Storage storage;

  Future<bool> hasSeenOnboarding() async {
    final value = await storage.read(key: ConstantKeys.hasSeenOnboardingKey);
    return value != null;
  }

  Future<void> markOnboardingSeen() async {
    await storage.write(key: ConstantKeys.hasSeenOnboardingKey, value: 'true');
  }
}
