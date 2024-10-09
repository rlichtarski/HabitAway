import 'package:habit_away/app/app.dart';
import 'package:habit_away/bootstrap.dart';
import 'package:habit_away/firebase_options_dev.dart';
import 'package:shared/shared.dart';

void main() {
  bootstrap(
    () {
      return const AppView();
    },
    appFlavor: AppFlavor.development(),
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
