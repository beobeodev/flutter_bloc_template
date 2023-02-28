
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/data/dtos/auth/login_by_email_request.dto.dart';
import 'package:flutter_template/data/models/user.model.dart';
import 'package:flutter_template/data/repositories/auth.repository.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/modules/auth/bloc/auth/auth.bloc.dart';

part 'login.event.dart';
part 'login.state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepository,
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        _authRepository = authRepository,
        super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  final AuthBloc _authBloc;
  final AuthRepository _authRepository;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return LocaleKeys.validator_email_required.tr();
    }

    return null;
  }

  String? validatePassword(String? email) {
    if (email == null || email.isEmpty) {
      return LocaleKeys.validator_password_required.tr();
    }

    return null;
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final UserModel user = await _authRepository.loginByEmail(
        LoginByEmailRequestDTO(
          email: event.email,
          password: event.password,
        ),
      );
      _authBloc.add(AuthSetUser(currentUser: user));
    } on DioError catch (err) {
      addError(err.response.toString());
    }
  }
}
