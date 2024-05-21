import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/common/theme/palette.dart';
import 'package:flutter_template/generated/fonts.gen.dart';

extension on TextStyle {
  TextStyle get w3 => copyWith(fontWeight: FontWeight.w300);
  TextStyle get w4 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w5 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w6 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w7 => copyWith(fontWeight: FontWeight.w700);
}

class Fonts {
  static const TextStyle _defaultTextStyle = TextStyle(fontFamily: FontFamily.mulish);

  static final TextStyle s10w4 = _defaultTextStyle.copyWith(fontSize: 10.sp).w4;
  static final TextStyle s10w6 = _defaultTextStyle.copyWith(fontSize: 10.sp).w6;
  static final TextStyle s12w4 = _defaultTextStyle.copyWith(fontSize: 12.sp).w4;
  static final TextStyle s14w4 = _defaultTextStyle.copyWith(fontSize: 14.sp).w4;
  static final TextStyle s14w6 = _defaultTextStyle.copyWith(fontSize: 14.sp).w6;
  static final TextStyle s16w6 = _defaultTextStyle.copyWith(fontSize: 16.sp).w6;
  static final TextStyle s18w6 = _defaultTextStyle.copyWith(fontSize: 18.sp).w6;
  static final TextStyle s24w7 = _defaultTextStyle.copyWith(fontSize: 24.sp).w7;
  static final TextStyle s32w7 = _defaultTextStyle.copyWith(fontSize: 32.sp).w7;
}

@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle subHeading1;
  final TextStyle subHeading2;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle metadata1;
  final TextStyle metadata2;
  final TextStyle metadata3;

  final TextStyle errorButtonLabel;

  final TextStyle buttonLabel;

  final TextStyle textFieldLabel;
  final TextStyle textField;
  final TextStyle hintTextField;
  final TextStyle errorTextField;
  final TextStyle helperTexField;

  const AppTextStyles({
    required this.heading1,
    required this.heading2,
    required this.subHeading1,
    required this.subHeading2,
    required this.body1,
    required this.body2,
    required this.metadata1,
    required this.metadata2,
    required this.metadata3,
    required this.errorButtonLabel,
    required this.buttonLabel,
    required this.textFieldLabel,
    required this.textField,
    required this.hintTextField,
    required this.errorTextField,
    required this.helperTexField,
  });

  factory AppTextStyles.fromPalette(Palette palette) {
    return AppTextStyles(
      heading1: Fonts.s32w7.copyWith(color: palette.normalText),
      heading2: Fonts.s24w7.copyWith(color: palette.normalText),
      subHeading1: Fonts.s18w6.copyWith(color: palette.normalText),
      subHeading2: Fonts.s16w6.copyWith(color: palette.normalText),
      body1: Fonts.s14w6.copyWith(color: palette.normalText),
      body2: Fonts.s14w4.copyWith(color: palette.normalText),
      metadata1: Fonts.s12w4.copyWith(color: palette.normalText),
      metadata2: Fonts.s10w4.copyWith(color: palette.normalText),
      metadata3: Fonts.s10w6.copyWith(color: palette.normalText),
      errorButtonLabel: Fonts.s14w6.copyWith(color: palette.errorButtonLabel),
      buttonLabel: Fonts.s14w6.copyWith(color: palette.buttonText),
      textFieldLabel: Fonts.s14w6.copyWith(color: palette.normalText),
      textField: Fonts.s14w4.copyWith(color: palette.normalText),
      hintTextField: Fonts.s14w4.copyWith(color: palette.hintTextField),
      errorTextField: Fonts.s12w4.copyWith(color: palette.errorButtonLabel),
      helperTexField: Fonts.s12w4.copyWith(color: palette.normalText),
    );
  }

  @override
  ThemeExtension<AppTextStyles> copyWith({
    TextStyle? heading1,
    TextStyle? heading2,
    TextStyle? subHeading1,
    TextStyle? subHeading2,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? metadata1,
    TextStyle? metadata2,
    TextStyle? metadata3,
    TextStyle? errorButtonLabel,
    TextStyle? buttonLabel,
    TextStyle? textFieldLabel,
    TextStyle? textField,
    TextStyle? hintTextField,
    TextStyle? errorTextField,
    TextStyle? helperTexField,
  }) {
    return AppTextStyles(
      heading1: heading1 ?? this.heading1,
      heading2: heading2 ?? this.heading2,
      subHeading1: subHeading1 ?? this.subHeading1,
      subHeading2: subHeading2 ?? this.subHeading2,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      metadata1: metadata1 ?? this.metadata1,
      metadata2: metadata2 ?? this.metadata2,
      metadata3: metadata3 ?? this.metadata3,
      errorButtonLabel: errorButtonLabel ?? this.errorButtonLabel,
      buttonLabel: buttonLabel ?? this.buttonLabel,
      textFieldLabel: textFieldLabel ?? this.textFieldLabel,
      textField: textField ?? this.textField,
      hintTextField: hintTextField ?? this.hintTextField,
      errorTextField: errorTextField ?? this.errorTextField,
      helperTexField: helperTexField ?? this.helperTexField,
    );
  }

  @override
  ThemeExtension<AppTextStyles> lerp(covariant ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles || identical(this, other)) {
      return this;
    }

    return AppTextStyles(
      heading1: TextStyle.lerp(heading1, other.heading1, t)!,
      heading2: TextStyle.lerp(heading2, other.heading2, t)!,
      subHeading1: TextStyle.lerp(subHeading1, other.subHeading1, t)!,
      subHeading2: TextStyle.lerp(subHeading2, other.subHeading2, t)!,
      body1: TextStyle.lerp(body1, other.body1, t)!,
      body2: TextStyle.lerp(body2, other.body2, t)!,
      metadata1: TextStyle.lerp(metadata1, other.metadata1, t)!,
      metadata2: TextStyle.lerp(metadata2, other.metadata2, t)!,
      metadata3: TextStyle.lerp(metadata3, other.metadata3, t)!,
      errorButtonLabel: TextStyle.lerp(errorButtonLabel, other.errorButtonLabel, t)!,
      buttonLabel: TextStyle.lerp(buttonLabel, other.buttonLabel, t)!,
      textFieldLabel: TextStyle.lerp(textFieldLabel, other.textFieldLabel, t)!,
      textField: TextStyle.lerp(textField, other.textField, t)!,
      hintTextField: TextStyle.lerp(hintTextField, other.hintTextField, t)!,
      errorTextField: TextStyle.lerp(errorTextField, other.errorTextField, t)!,
      helperTexField: TextStyle.lerp(helperTexField, other.helperTexField, t)!,
    );
  }
}
