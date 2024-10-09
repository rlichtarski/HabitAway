import 'package:habit_away/app/app.dart';
import 'package:habit_away/bootstrap.dart';
import 'package:habit_away/firebase_options_prod.dart';
import 'package:shared/shared.dart';

void main() {
  bootstrap(
    () {
      return const AppView();
    },
    appFlavor: AppFlavor.production(),
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
