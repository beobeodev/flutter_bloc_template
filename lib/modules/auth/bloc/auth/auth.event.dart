part of 'auth.bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthGetUserInfo extends AuthEvent {}

class AuthSetUser extends AuthEvent {
  const AuthSetUser({required this.currentUser});
  
  final UserModel? currentUser;

  @override
  List<Object?> get props => [currentUser];
}

class AuthSetTokens extends AuthEvent {
  const AuthSetTokens({
    required this.refreshToken,
  });
  
  final RefreshTokenDTO? refreshToken;

  @override
  List<Object?> get props => [refreshToken];
}

class AuthLogOut extends AuthEvent {}
