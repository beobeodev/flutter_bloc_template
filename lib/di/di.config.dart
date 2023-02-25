// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_template/data/datasources/auth.datasource.dart' as _i8;
import 'package:flutter_template/data/datasources/local/local.datasource.dart'
    as _i4;
import 'package:flutter_template/data/datasources/remote/auth.datasource.dart'
    as _i9;
import 'package:flutter_template/data/datasources/remote/dio.helper.dart'
    as _i7;
import 'package:flutter_template/data/repositories/user.repository.dart'
    as _i10;
import 'package:flutter_template/di/modules/local_module.dart' as _i11;
import 'package:flutter_template/di/modules/network_module.dart' as _i12;
import 'package:flutter_template/di/provider/dio_provider.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i5;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
Future<_i1.GetIt> initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final localModule = _$LocalModule();
  final networkModule = _$NetworkModule();
  await gh.singletonAsync<_i3.Box<dynamic>>(
    () => localModule.authBox,
    instanceName: 'auth_box',
    preResolve: true,
  );
  gh.lazySingleton<_i4.LocalDatasource>(() => _i4.LocalDatasource(
      authBox: gh<_i5.Box<dynamic>>(instanceName: 'auth_box')));
  gh.singleton<_i6.DioProvider>(
      _i6.DioProvider(localDatasource: gh<_i4.LocalDatasource>()));
  gh.singleton<_i7.DioHelper>(
      networkModule.providerDioHelper(gh<_i6.DioProvider>()));
  gh.lazySingleton<_i8.AuthDatasource>(
      () => _i8.AuthDatasource(dioHelper: gh<_i7.DioHelper>()));
  gh.lazySingleton<_i9.AuthDatasource>(
      () => _i9.AuthDatasource(dioHelper: gh<_i7.DioHelper>()));
  gh.lazySingleton<_i10.UserRepository>(() => _i10.UserRepository(
        localDataSource: gh<_i4.LocalDatasource>(),
        authDatasource: gh<_i9.AuthDatasource>(),
      ));
  return getIt;
}

class _$LocalModule extends _i11.LocalModule {}

class _$NetworkModule extends _i12.NetworkModule {}
