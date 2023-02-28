import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_template/data/datasources/local/local.datasource.dart';
import 'package:flutter_template/di/interceptors/app_interceptor.dart';
import 'package:injectable/injectable.dart';

@singleton
class DioProvider {
  DioProvider({required LocalDatasource localDatasource})
      : _localDatasource = localDatasource;

  Dio? _dio;

  final LocalDatasource _localDatasource;

  Dio getDio() => _dio ?? _createDio();

  Dio _createDio() {
    final dio = Dio();
    final appInterceptor = AppInterceptor(
      localDatasource: _localDatasource,
      dio: dio,
    );
    final interceptors = <Interceptor>[];
    interceptors.add(appInterceptor);
    
    /// HACK: if you have any intercepters, please add in here
    
    /// HACK: if you want to change connect Timeout, receive Timeout, please change here
    return dio
      ..options.connectTimeout = 3000
      ..options.receiveTimeout = 5000
      ..options.headers = {
        HttpHeaders.contentTypeHeader: ContentType.json.value,
      }
      ..interceptors.addAll(interceptors);
  }
}
