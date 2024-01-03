import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/data/dtos/auth/login_by_email_request_dto.dart';
import 'package:flutter_template/data/models/user_model.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/presentation/auth/bloc/auth/auth_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required UserRepository userRepository,
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        _userRepository = userRepository,
        super(LoginInitial()) {
    on<LoginSubmit>(_onLoginSubmit);
  }

  final AuthBloc _authBloc;
  final UserRepository _userRepository;

  Future<void> _onLoginSubmit(
    LoginSubmit event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final UserModel user = await _userRepository.loginByEmail(
        LoginByEmailRequestDTO(
          email: event.email,
          password: event.password,
        ),
      );

      _authBloc.add(AuthUserInfoSet(currentUser: user));
    } catch (err) {
      bool isUnauthorizedError = err is DioException && err.response?.statusCode == 401;

      emit(
        LoginNotSuccess(
          error: isUnauthorizedError ? LocaleKeys.validator_incorrect_email_password.tr() : null,
        ),
      );
    }
  }
}
