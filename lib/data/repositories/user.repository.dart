import 'package:flutter_template/data/datasources/user.datasource.dart';
import 'package:flutter_template/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRepository {
  final UserDataSource _dataSource;

  UserRepository({required UserDataSource dataSource})
      : _dataSource = dataSource;

  Future<LoginResponseDTO> loginByEmail(AuthenticationDTO params) {
    return _dataSource.loginByEmail(params);
  }
}
