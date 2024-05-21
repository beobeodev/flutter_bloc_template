part of 'app_bloc.dart';

final Map<ThemeMode, ThemeSheet> themes = {
  ThemeMode.light: ThemeSheet(palette: Palette.light(), textStyles: AppTextStyles.fromPalette(Palette.light())),
  ThemeMode.dark: ThemeSheet(palette: Palette.dark(), textStyles: AppTextStyles.fromPalette(Palette.dark())),
};

class AppState extends Equatable {
  final ThemeMode themeMode;

  const AppState({this.themeMode = ThemeMode.light});

  @override
  List<Object> get props => [themeMode];

  AppState copyWith({
    ThemeMode? themeMode,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
