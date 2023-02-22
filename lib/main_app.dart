import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/constants/locales.dart';
import 'package:flutter_template/configs/app_bloc_observer.dart';
import 'package:flutter_template/modules/auth/bloc/auth/auth.bloc.dart';
import 'package:flutter_template/configs/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/flavors.dart';
import 'package:flutter_template/generated/codegen_loader.g.dart';

Future<void> mainApp(Flavor flavor) async {
  AppFlavor.appFlavor = flavor;
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        AppLocales.en,
        AppLocales.vi,
      ],
      path: AppLocales.path,
      fallbackLocale: AppLocales.vi,
      startLocale: AppLocales.vi,
      useOnlyLangCode: true,
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Listener(
        onPointerDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          title: AppFlavor.title,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // routerConfig: AppRoutes.router,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          initialRoute: AppRoutes.splash,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          builder: (_, child) {
            return BlocListener<AuthBloc, AuthState>(
              listener: (_, state) {
                switch (state.status) {
                  case AuthenticationStatus.unknown:
                    break;
                  case AuthenticationStatus.authenticated:
                    _navigator.pushNamedAndRemoveUntil(
                      AppRoutes.root,
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushNamedAndRemoveUntil(
                      AppRoutes.login,
                      (route) => false,
                    );
                    break;
                }
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}

Future<void> initializeApp() async {
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
  await AppFlavor().setupFlavor();

  configureDependencies();

  await Hive.initFlutter();

  Bloc.observer = AppBlocObserver();
}
