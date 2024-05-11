import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_template/common/constants/hive_keys.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_template/di/interceptors/app_interceptor.dart';

@lazySingleton
class DioProvider {
  DioProvider(@Named(HiveKeys.authBox) this._authBox);
  final Box<dynamic> _authBox;

  Dio? _dio;
  Dio getDio() => _dio ?? _createDio();

  Dio _createDio() {
    final interceptorDio = Dio();
    final refreshTokenDio = Dio();

    final appInterceptor = AppInterceptor(
      authBox: _authBox,
      dio: refreshTokenDio,
    );
    final interceptors = <Interceptor>[];
    interceptors.add(appInterceptor);

    return interceptorDio
      ..options.headers = {
        HttpHeaders.contentTypeHeader: ContentType.json.value,
      }
      ..interceptors.addAll(interceptors);
  }
}
