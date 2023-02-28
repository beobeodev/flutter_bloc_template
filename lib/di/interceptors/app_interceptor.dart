import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_template/common/constants/hive_keys.dart';
import 'package:flutter_template/common/helpers/hive/hive.helper.dart';
import 'package:flutter_template/data/datasources/local/local.datasource.dart';
import 'package:flutter_template/data/dtos/auth/refresh_token.dto.dart';

class AppInterceptor extends QueuedInterceptor {
  AppInterceptor({required LocalDatasource localDatasource, required Dio dio})
      : _localDatasource = localDatasource,
        _dio = dio;

  final LocalDatasource _localDatasource;

  final Dio _dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    log('REQUEST[${options.method}] => PATH: ${options.path}');

    _checkTokenExpired();

    final String? accessToken = await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.accessToken,
    );

    if (accessToken != null) {
      options.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      });
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
      name: 'Intercepter: onResponse',
    );

    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // HACK: handle logout, maybe

      return;
    }

    log(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      name: 'Intercepter: onError',
    );

    return handler.next(err);
  }

  void _checkTokenExpired() {
    final String? expiredTime = _localDatasource.expiresIn;

    if (expiredTime != null &&
        DateTime.parse(expiredTime)
            .isBefore(DateTime.now().add(const Duration(seconds: 3)))) {
      _refreshToken();
    }
  }

  Future<void> _refreshToken() async {
    final String? refreshToken = _localDatasource.refreshToken;

    if (refreshToken == null || refreshToken.isEmpty) {
      // TODO: navigate to login screen

      return;
    }

    log('--[REFRESH TOKEN]--: $refreshToken');

    try {
      final Response response = await _dio.get('');

      final RefreshTokenDTO refreshTokenDTO =
          RefreshTokenDTO.fromJson(response.data);

      /// HACK: replace token data
      await Future.wait([
        _localDatasource.saveAccessToken(refreshTokenDTO.accessToken),
        _localDatasource.saveRefreshToken(refreshTokenDTO.refreshToken),
        _localDatasource.saveExpiresIn(refreshTokenDTO.expiresIn)
      ]);
    } catch (err) {
      // TODO: logout
    }
  }
}
