import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/string_extension.dart';
import 'package:flutter_template/common/utils/toast_util.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/presentation/auth/bloc/auth/auth_bloc.dart';
import 'package:flutter_template/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_template/presentation/widgets/ads/native_ads_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        authBloc: context.read<AuthBloc>(),
        userRepository: getIt.get<UserRepository>(),
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listener: _listenLoginStateChanged,
        child: _LoginView(),
      ),
    );
  }

  void _listenLoginStateChanged(BuildContext context, LoginState state) {
    if (state is LoginNotSuccess && state.error.isNullOrEmpty) {
      ToastUtil.showError(
        context,
      );
    }
  }
}

class _LoginView extends StatelessWidget {
  _LoginView();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEditController = TextEditingController();
  final TextEditingController _passwordEditController = TextEditingController();

  void _submitLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(
            LoginSubmit(
              email: _emailEditController.text,
              password: _passwordEditController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: NativeAdsContainer(),
      ),
    );
  }
}
