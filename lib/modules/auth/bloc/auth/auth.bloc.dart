import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/common/constants/hive_keys.dart';
import 'package:flutter_template/common/helpers/hive/hive.helper.dart';
import 'package:flutter_template/data/dtos/auth/refresh_token.dto.dart';
import 'package:flutter_template/data/models/user.model.dart';

part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.unknown()) {
    on<AuthSetUser>(_onSetUser);
    on<AuthGetUserInfo>(_onGetUserInfo);
  }

  Future<void> _onGetUserInfo(
    AuthGetUserInfo event,
    Emitter<AuthState> emit,
  ) async {
    final String? accessToken = await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.accessToken,
    );

    if (accessToken == null) {
      emit(const AuthState.unauthenticated());
    } else {
      emit(AuthState.authenticated(UserModel(email: '')));
    }
  }

  void _onSetUser(AuthSetUser event, Emitter<AuthState> emit) {
    if (event.currentUser == null) {
      emit(const AuthState.unauthenticated());
    } else {
      emit(AuthState.authenticated(event.currentUser!));
    }
  }
}
