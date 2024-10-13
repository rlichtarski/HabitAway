import 'package:firebase_authentication_client/firebase_authentication_client.dart';
import 'package:habit_away/app/app.dart';
import 'package:habit_away/bootstrap.dart';
import 'package:habit_away/firebase_options_dev.dart';
import 'package:shared/shared.dart';
import 'package:token_storage/token_storage.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  await bootstrap(
    () async {
      final tokenStorage = InMemoryTokenStorage();
      final authenticationClient = FirebaseAuthenticationClient(
        tokenStorage: tokenStorage,
      );
      final userRepository = UserRepository(
        authenticationClient: authenticationClient,
      );
      return App(userRepository: userRepository,);
    },
    appFlavor: AppFlavor.development(),
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
