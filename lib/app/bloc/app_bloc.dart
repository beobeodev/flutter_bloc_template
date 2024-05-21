import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/app_theme.dart';
import 'package:flutter_template/common/theme/palette.dart';
import 'package:flutter_template/common/theme/text_styles.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<AppThemeChanged>(_onAppThemeChanged);
  }

  void _onAppThemeChanged(AppThemeChanged event, Emitter<AppState> emit) {
    emit(
      state.copyWith(
        themeMode: event.themeMode,
      ),
    );
  }
}
