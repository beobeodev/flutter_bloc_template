import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/common/constants/locales.dart';
import 'package:flutter_template/common/theme/app_theme.dart';
import 'package:flutter_template/generated/codegen_loader.g.dart';
import 'package:flutter_template/router/app_router.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/flavors.dart';
import 'package:flutter_template/presentation/auth/bloc/auth/auth_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        AppLocales.en,
        AppLocales.vi,
      ],
      path: AppLocales.path,
      fallbackLocale: AppLocales.vi,
      startLocale: AppLocales.vi,
      useOnlyLangCode: true,
      assetLoader: const CodegenLoader(),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Builder(
          builder: (context) {
            return BlocProvider(
              create: (context) => AuthBloc(
                userRepository: getIt.get<UserRepository>(),
              ),
              child: ScreenUtilInit(
                designSize: const Size(414, 896), // View-port size of iphone XS max
                minTextAdapt: true,
                splitScreenMode: true,
                useInheritedMediaQuery: true,
                child: MaterialApp(
                  navigatorKey: _navigatorKey,
                  title: AppFlavor.title,
                  theme: AppTheme.themeData,
                  onGenerateRoute: AppRouter.onGenerateRoute,
                  initialRoute: AppRouter.splash,
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
                              AppRouter.root,
                              (route) => false,
                            );
                            break;
                          case AuthenticationStatus.unauthenticated:
                            _navigator.pushNamedAndRemoveUntil(
                              AppRouter.login,
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
          },
        ),
      ),
    );
  }
}
