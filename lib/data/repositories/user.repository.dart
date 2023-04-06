import 'package:flutter_template/data/datasources/user/user.datasource.dart';
import 'package:flutter_template/data/dtos/auth/login_by_email_request.dto.dart';
import 'package:flutter_template/data/models/user.model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRepository {
  UserRepository({
    required UserDataSource dataSource,
  }) : _dataSource = dataSource;

  final UserDataSource _dataSource;

  Future<UserModel> loginByEmail(LoginByEmailRequestDTO params) {
    return _dataSource.loginByEmail(params);
  }

  UserModel? getUserInfo() {
    return _dataSource.getUserInfo();
  }
}
