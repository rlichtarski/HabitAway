import 'package:get_it/get_it.dart';
import 'package:shared/shared.dart';

final getIt = GetIt.instance;

void setupServiceLocator({AppFlavor? appFlavor}) {
  final flavor = appFlavor ?? AppFlavor.development();
  getIt.registerSingleton<AppFlavor>(flavor);
}
