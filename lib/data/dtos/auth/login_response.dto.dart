import 'package:flutter_template/data/models/user.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.dto.g.dart';

@JsonSerializable(createToJson: false)
class LoginResponseDTO {
  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);

  LoginResponseDTO({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });
  final UserModel user;
  final String accessToken;
  final String refreshToken;
  final String expiresIn;
}
