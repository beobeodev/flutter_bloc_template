import 'package:flutter_template/common/constants/hive_keys.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocalDatasource {
  LocalDatasource({
    @Named(HiveKeys.authBox) required Box authBox,
  }) : _authbox = authBox;

  final Box _authbox;

  String? get accessToken => _authbox.get(HiveKeys.accessToken);

  String? get refreshToken => _authbox.get(HiveKeys.refreshToken);

  String? get expiresIn => _authbox.get(HiveKeys.expiresIn);

  Future<void> saveAccessToken(String accessToken) =>
      _authbox.put(HiveKeys.accessToken, accessToken);

  Future<void> saveRefreshToken(String refreshToken) =>
      _authbox.put(HiveKeys.accessToken, accessToken);

  Future<void> saveExpiresIn(String refreshToken) =>
      _authbox.put(HiveKeys.accessToken, accessToken);

  Future<void> clear() => _authbox.clear();
}
