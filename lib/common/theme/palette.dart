import 'package:flutter/material.dart';

@immutable
class Palette extends ThemeExtension<Palette> {
  final Brightness brightness;

  final Color scaffoldBackground;
  final Color buttonText;
  final Color buttonBackground;
  final Color normalText;
  final Color textFieldBackground;
  final Color hintTextField;

  final Color errorButtonLabel;
  final Color dialogBackground;

  final Color focusedBorderColor;

  const Palette({
    required this.brightness,
    required this.scaffoldBackground,
    required this.buttonBackground,
    required this.normalText,
    required this.textFieldBackground,
    required this.errorButtonLabel,
    required this.dialogBackground,
    required this.focusedBorderColor,
    this.buttonText = const Color(0xFFF7F7FC),
    this.hintTextField = const Color(0xFFADB5BD),
  });

  factory Palette.light() {
    return const Palette(
      brightness: Brightness.light,
      scaffoldBackground: Color(0xFFFFFFFF),
      buttonBackground: Color(0xFF002DE3),
      normalText: Color(0xFF0F1828),
      textFieldBackground: Color(0xFFF7F7FC),
      errorButtonLabel: Color(0xFFFF3333),
      dialogBackground: Color(0xFFFFFFFF),
      focusedBorderColor: Color(0xFF002DE3),
    );
  }

  factory Palette.dark() {
    return const Palette(
      brightness: Brightness.dark,
      scaffoldBackground: Color(0xFF0F1828),
      buttonBackground: Color(0xFF375FFF),
      normalText: Color(0xFFF7F7FC),
      textFieldBackground: Color(0xFF152033),
      errorButtonLabel: Color(0xFFF0424B),
      dialogBackground: Color(0xFF343839),
      focusedBorderColor: Color(0xFF375FFF),
    );
  }

  @override
  ThemeExtension<Palette> copyWith({
    Brightness? brightness,
    Color? scaffoldBackground,
    Color? buttonBackground,
    Color? text,
    Color? textFieldBackground,
    Color? hintTextField,
    Color? errorButtonLabel,
    Color? dialogBackground,
    Color? focusedBorderColor,
  }) {
    return Palette(
      brightness: brightness ?? this.brightness,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      buttonBackground: buttonBackground ?? this.buttonBackground,
      normalText: text ?? normalText,
      textFieldBackground: textFieldBackground ?? this.textFieldBackground,
      hintTextField: hintTextField ?? this.hintTextField,
      errorButtonLabel: errorButtonLabel ?? this.errorButtonLabel,
      dialogBackground: dialogBackground ?? this.dialogBackground,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
    );
  }

  @override
  ThemeExtension<Palette> lerp(covariant ThemeExtension<Palette>? other, double t) {
    if (other is! Palette || identical(this, other)) {
      return this;
    }

    return Palette(
      brightness: brightness,
      scaffoldBackground: Color.lerp(scaffoldBackground, other.scaffoldBackground, t)!,
      buttonBackground: Color.lerp(buttonBackground, other.buttonBackground, t)!,
      normalText: Color.lerp(normalText, other.normalText, t)!,
      textFieldBackground: Color.lerp(textFieldBackground, other.textFieldBackground, t)!,
      hintTextField: Color.lerp(hintTextField, other.hintTextField, t)!,
      errorButtonLabel: Color.lerp(errorButtonLabel, other.errorButtonLabel, t)!,
      dialogBackground: Color.lerp(dialogBackground, other.dialogBackground, t)!,
      focusedBorderColor: Color.lerp(focusedBorderColor, other.focusedBorderColor, t)!,
    );
  }
}
