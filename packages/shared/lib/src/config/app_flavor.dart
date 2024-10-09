import 'package:env/env.dart';

enum Flavor { development, production }

sealed class AppEnv {
  const AppEnv();

  String getEnv(Env env);
}

class AppFlavor extends AppEnv {
  const AppFlavor._({required this.flavor});

  factory AppFlavor.development() =>
      const AppFlavor._(flavor: Flavor.development);
  factory AppFlavor.production() =>
      const AppFlavor._(flavor: Flavor.production);

  final Flavor flavor;
  
  @override
  String getEnv(Env env) => switch (env) {
    Env.iOSClientId => switch (flavor) {
      Flavor.development => EnvDev.iOSClientId,
      Flavor.production => EnvProd.iOSClientId,
    }
  };
}
