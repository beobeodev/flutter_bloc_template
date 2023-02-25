import 'package:flutter_template/data/datasources/remote/dio.helper.dart';
import 'package:flutter_template/di/provider/dio_provider.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @singleton
  DioHelper providerDioHelper(DioProvider dioProvider) {
    return DioHelper(dio: dioProvider.getDio());
  }
}
