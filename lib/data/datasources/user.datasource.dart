import 'package:flutter_template/common/constants/endpoints.dart';
import 'package:flutter_template/common/helpers/dio/dio.helper.dart';
import 'package:flutter_template/data/dtos/auth.dto.dart';
import 'package:flutter_template/data/models/user.model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserDataSource {
  Future<LoginResponseDTO> loginByEmail(AuthenticationDTO params) async {
    final HttpRequestResponse response = await DioHelper.post(
      Endpoints.login,
      data: params.toJson(),
    );

    return LoginResponseDTO(
      user: UserModel.fromJson(response.body['data']['user']),
      refreshToken: response.body['data']['token']['refreshToken'],
      accessToken: response.body['data']['token']['accessToken'],
      expiresIn: response.body['data']['token']['expiresIn'],
    );
  }
}
