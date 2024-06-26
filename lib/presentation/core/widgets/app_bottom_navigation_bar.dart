import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/presentation/core/bloc/root_bloc.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
      ),
      child: BlocBuilder<RootBloc, RootState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (int newIndex) {
              context.read<RootBloc>().add(RootBottomTabChange(newIndex: newIndex));
            },
            selectedItemColor: context.palette.buttonBackground,
            unselectedItemColor: context.palette.hintTextField,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: LocaleKeys.root_home.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.manage_accounts_outlined),
                label: LocaleKeys.root_management.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.notifications_outlined),
                label: LocaleKeys.texts_notification.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle_outlined),
                label: LocaleKeys.root_profile.tr(),
              ),
            ],
          );
        },
        buildWhen: (previous, current) {
          return previous.currentIndex != current.currentIndex;
        },
      ),
    );
  }
}
