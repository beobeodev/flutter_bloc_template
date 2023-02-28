import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/data/dtos/auth/refresh_token.dto.dart';
import 'package:flutter_template/data/models/user.model.dart';
import 'package:flutter_template/data/repositories/user.repository.dart';

part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<AuthUserInfoSet>(_onSetUserInfo);
    on<AuthUserInfoChecked>(_onCheckUserInfo);
  }
  final UserRepository _userRepository;

  Future<void> _getUserInfo(
    Emitter<AuthState> emitter,
  ) async {
    try {
      final UserModel user = await _userRepository.getUserInfo();

      emitter(AuthState.authenticated(user));
    } catch (err) {
      emitter(const AuthState.unauthenticated());
    }
  }

  Future<void> _onCheckUserInfo(
    AuthUserInfoChecked event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final String? accessToken = _userRepository.getAccessToken();

      if (accessToken == null) {
        emit(const AuthState.unauthenticated());
      } else {
        _getUserInfo(emit);
      }
    } catch (err) {
      emit(const AuthState.unauthenticated());
    }
  }

  void _onSetUserInfo(AuthUserInfoSet event, Emitter<AuthState> emit) {
    if (event.currentUser == null) {
      emit(const AuthState.unauthenticated());
    } else {
      emit(AuthState.authenticated(event.currentUser!));
    }
  }
}
