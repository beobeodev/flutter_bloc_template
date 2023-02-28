import 'package:flutter_template/common/constants/hive_keys.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserLocalDataSource {
  UserLocalDataSource({
    @Named(HiveKeys.authBox) required Box authBox,
  }) : _authbox = authBox;

  final Box _authbox;

  String? getAccessToken() {
    return _authbox.get(HiveKeys.accessToken);
  }

  String? getRefreshToken() {
    return _authbox.get(HiveKeys.refreshToken);
  }

  String? getExpiresIn() {
    return _authbox.get(HiveKeys.expiresIn);
  }

  Future<void> saveAccessToken(String accessToken) {
    return _authbox.put(HiveKeys.accessToken, accessToken);
  }

  Future<void> saveRefreshToken(String refreshToken) {
    return _authbox.put(HiveKeys.refreshToken, refreshToken);
  }

  Future<void> saveExpiresIn(int expiresIn) {
    return _authbox.put(HiveKeys.expiresIn, expiresIn);
  }

  Future<void> clear() {
    return _authbox.clear();
  }
}
