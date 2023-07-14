import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/app_bloc_observer.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/flavors.dart';
import 'package:hive_flutter/hive_flutter.dart';

typedef BootstrapBuilder = FutureOr<Widget> Function();

Future<void> bootstrap(BootstrapBuilder builder, Flavor flavor) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      AppFlavor.appFlavor = flavor;

      await initializeApp();

      runApp(
        await builder(),
      );
    },
    (error, stack) =>
        log(error.toString(), stackTrace: stack, name: 'runZonedGuarded'),
  );
}

Future<void> initializeApp() async {
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];

  await Hive.initFlutter();

  await configureDependencies();

  Bloc.observer = AppBlocObserver();
}
