import 'package:flutter_template/data/datasources/local/local.datasource.dart';
import 'package:flutter_template/data/datasources/remote/auth.datasource.dart';
import 'package:flutter_template/data/dtos/auth/login_by_email_request.dto.dart';
import 'package:flutter_template/data/dtos/auth/login_response.dto.dart';
import 'package:flutter_template/data/models/user.model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRepository {
  AuthRepository({
    required LocalDatasource localDataSource,     
    required AuthDatasource authDatasource,
  })  : _localDatasource = localDataSource,
        _authDatasource = authDatasource;

  final LocalDatasource _localDatasource;
  final AuthDatasource _authDatasource;

  Future<UserModel> loginByEmail(LoginByEmailRequestDTO params) async {
    final LoginResponseDTO loginResponse =
        await _authDatasource.loginByEmail(params);

    await Future.wait([
      _localDatasource.saveAccessToken(loginResponse.accessToken),
      _localDatasource.saveRefreshToken(loginResponse.refreshToken),
      _localDatasource.saveExpiresIn(loginResponse.expiresIn)
    ]);

    return loginResponse.user;
  }
}
