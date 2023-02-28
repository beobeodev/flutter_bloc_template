part of 'login.bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState({
    this.emailError,
    this.passwordError,
  });
  
  final String? emailError;
  final String? passwordError;

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginNotAllowed extends LoginState {
  const LoginNotAllowed({super.emailError, super.passwordError});
}

class LoginNotSuccess extends LoginState {
  const LoginNotSuccess() : super(emailError: null, passwordError: null);
}
