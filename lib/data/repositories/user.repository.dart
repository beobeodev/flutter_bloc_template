import 'package:flutter_template/data/datasources/local/user.datasource.dart';
import 'package:flutter_template/data/datasources/remote/user.datasource.dart';
import 'package:flutter_template/data/dtos/auth/login_by_email_request.dto.dart';
import 'package:flutter_template/data/dtos/auth/login_response.dto.dart';
import 'package:flutter_template/data/models/user.model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRepository {
  UserRepository({
    required UserLocalDataSource localDataSource,
    required UserRemoteDataSource authDatasource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = authDatasource;

  final UserLocalDataSource _localDataSource;
  final UserRemoteDataSource _remoteDataSource;

  Future<UserModel> loginByEmail(LoginByEmailRequestDTO params) async {
    final LoginResponseDTO loginResponse =
        await _remoteDataSource.loginByEmail(params);

    await Future.wait([
      _localDataSource.saveAccessToken(loginResponse.accessToken),
      _localDataSource.saveRefreshToken(loginResponse.refreshToken),
      _localDataSource.saveExpiresIn(loginResponse.expiresIn)
    ]);

    return loginResponse.user;
  }

  String? getAccessToken() {
    return _localDataSource.getAccessToken();
  }

  Future<UserModel> getUserInfo() {
    return _remoteDataSource.getUserInfo();
  }
}
