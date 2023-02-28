part of 'auth.bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserInfoChecked extends AuthEvent {}

class AuthUserInfoSet extends AuthEvent {
  const AuthUserInfoSet({required this.currentUser});

  final UserModel? currentUser;

  @override
  List<Object?> get props => [currentUser];
}

class AuthTokenSet extends AuthEvent {
  const AuthTokenSet({
    required this.refreshToken,
  });

  final RefreshTokenDTO? refreshToken;

  @override
  List<Object?> get props => [refreshToken];
}

class AuthLogOut extends AuthEvent {}
