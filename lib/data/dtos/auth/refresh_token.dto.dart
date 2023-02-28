import 'package:flutter_template/common/constants/hive_keys.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_token.dto.g.dart';

@JsonSerializable()
class RefreshTokenDTO {
  factory RefreshTokenDTO.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenDTOFromJson(json);

  RefreshTokenDTO({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });
  final String accessToken;
  final String refreshToken;
  final String expiresIn;

  Map<String, dynamic> toJson() => _$RefreshTokenDTOToJson(this);

  Map<String, String> toLocalJson() {
    return {
      HiveKeys.accessToken: accessToken,
      HiveKeys.refreshToken: refreshToken,
      HiveKeys.expiresIn: expiresIn,
    };
  }
}
