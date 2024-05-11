import 'dart:convert';

import 'package:flutter_template/common/constants/hive_keys.dart';
import 'package:flutter_template/data/dtos/auth/login_response_dto.dart';
import 'package:flutter_template/data/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserLocalDataSource {
  UserLocalDataSource({
    @Named(HiveKeys.authBox) required Box<dynamic> authBox,
  }) : _authBox = authBox;

  final Box<dynamic> _authBox;

  UserModel? getUserInfo() {
    final rawData = _authBox.get(HiveKeys.user) as String?;

    if (rawData == null) {
      return null;
    } else {
      return UserModel.fromJson(Map<String, dynamic>.from(jsonDecode(rawData) as Map<String, dynamic>));
    }
  }

  Future<void> setUserInfo(UserModel user) async {
    await _authBox.put(HiveKeys.user, jsonEncode(user));
  }

  Future<void> setUserAuth(LoginResponseDTO? response) async {
    if (response == null) {
      await _authBox.clear();
    } else {
      await _authBox.putAll({
        ...response.toRefreshTokenDTO().toLocalJson(),
        HiveKeys.user: jsonEncode(response.user),
      });
    }
  }
}
