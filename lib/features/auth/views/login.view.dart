import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/string.extension.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/utils/toast.util.dart';
import 'package:flutter_template/common/widgets/common_rounded_button.widget.dart';
import 'package:flutter_template/data/repositories/user.repository.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/features/auth/bloc/auth/auth.bloc.dart';
import 'package:flutter_template/features/auth/bloc/login/login.bloc.dart';
import 'package:flutter_template/features/auth/widgets/login_form.widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _listenLoginStateChanged(BuildContext context, LoginState state) {
    if (state is LoginNotSuccess && state.error.isNullOrEmpty) {
      ToastUtil.showError(
        context,
      );
    }
  }

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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSize.horizontalSpace,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.auth_welcome_back.tr(),
                    style: TextStyles.s17BoldText,
                  ),
                  LoginForm(
                    formKey: _formKey,
                    emailEditController: _emailEditController,
                    passwordEditController: _passwordEditController,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return CommonRoundedButton(
                        onPressed: () {
                          _submitLogin(context);
                        },
                        isLoading: state is LoginLoading,
                        content: LocaleKeys.auth_sign_in.tr(),
                        width: double.infinity,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
