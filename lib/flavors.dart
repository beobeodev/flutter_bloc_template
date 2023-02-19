import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Flavor {
  DEV,
  QA,
  STAGING,
}

class AppFlavor {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get apiBaseUrl => dotenv.get('BASE_URL');

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Flutter Template DEV';
      case Flavor.QA:
        return 'Flutter Template QA';
      case Flavor.STAGING:
        return 'Flutter Template';
      default:
        return 'title';
    }
  }

  Future<void> setupFlavor() async {
    switch (appFlavor) {
      case Flavor.DEV:
        await dotenv.load(fileName: '.env.dev');
        break;
      case Flavor.QA:
        await dotenv.load(fileName: '.env.qa');
        break;
      case Flavor.STAGING:
        await dotenv.load(fileName: '.env.staging');
        break;
      default:
        await dotenv.load();
        break;
    }
  }
}
