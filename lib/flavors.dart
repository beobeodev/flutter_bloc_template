import 'package:flutter_template/common/constants/env_keys.dart';

enum Flavor {
  DEV,
  STAGING,
  PROD,
}

class AppFlavor {
  static Flavor? appFlavor;

  static String get apiBaseUrl => const String.fromEnvironment(EnvKeys.baseURL);

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Flutter Template DEV';
      case Flavor.STAGING:
        return 'Flutter Template STAGING';
      case Flavor.PROD:
        return 'Flutter Template';
      default:
        return 'Flutter Template DEV';
    }
  }
}
