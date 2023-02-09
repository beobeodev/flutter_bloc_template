import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/modules/core/bloc/root.bloc.dart';
import 'package:flutter_template/modules/core/widgets/app_bottom_navigation_bar.widget.dart';
import 'package:flutter_template/modules/core/widgets/custom_lazy_indexed_stack.widget.dart';
import 'package:flutter_template/modules/home/home.dart';
import 'package:flutter_template/modules/notification/notification.dart';
import 'package:flutter_template/modules/profile/profile.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RootBloc(),
      child: const _RootView(),
    );
  }
}

class _RootView extends StatelessWidget {
  const _RootView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RootBloc, RootState>(
        builder: (
          context,
          state,
        ) {
          return SlideIndexedStack(
            index: state.currentIndex,
            children: const [HomePage(), NotificationPage(), ProfilePage()],
          );
        },
        buildWhen: (previous, current) {
          return previous.currentIndex != current.currentIndex;
        },
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}
