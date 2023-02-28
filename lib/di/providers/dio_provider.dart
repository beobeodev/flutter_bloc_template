import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_template/data/datasources/local/user.datasource.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/di/interceptors/app_interceptor.dart';

@lazySingleton
class DioProvider {
  DioProvider();

  Dio? _dio;

  Dio getDio() => _dio ?? _createDio();

  Dio _createDio() {
    final Dio interceptorDio = Dio();

    final AppInterceptor appInterceptor = AppInterceptor(
      userLocalDataSource: getIt.get<UserLocalDataSource>(),
    );
    final List<Interceptor> interceptors = <Interceptor>[];
    interceptors.add(appInterceptor);

    /// HACK: if you have any intercepters, please add in here

    /// HACK: if you want to change connect Timeout, receive Timeout, please change here
    return interceptorDio
      ..options.connectTimeout = 3000
      ..options.receiveTimeout = 5000
      ..options.headers = {
        HttpHeaders.contentTypeHeader: ContentType.json.value,
      }
      ..interceptors.addAll(interceptors);
  }
}
