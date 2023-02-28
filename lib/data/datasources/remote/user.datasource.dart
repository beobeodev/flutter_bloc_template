import 'package:flutter_template/common/constants/endpoints.dart';
import 'package:flutter_template/common/helpers/dio.helper.dart';
import 'package:flutter_template/data/dtos/auth/login_by_email_request.dto.dart';
import 'package:flutter_template/data/dtos/auth/login_response.dto.dart';
import 'package:flutter_template/data/models/user.model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRemoteDataSource {
  UserRemoteDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;

  final DioHelper _dioHelper;

  Future<LoginResponseDTO> loginByEmail(LoginByEmailRequestDTO params) async {
    final HttpRequestResponse response = await _dioHelper.post(
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

  Future<UserModel> getUserInfo() async {
    final HttpRequestResponse response = await _dioHelper.get(
      Endpoints.login,
    );

    return UserModel.fromJson(response.body['user']);
  }
}
