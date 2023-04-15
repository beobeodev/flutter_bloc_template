import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  /// The same of [MediaQuery.of(context).size]
  Size get mediaQuerySize => MediaQuery.of(this).size;

  double get height => mediaQuerySize.height;

  double get width => mediaQuerySize.width;

  ThemeData get theme => Theme.of(this);

  /// Check if dark mode theme is enable
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// similar to [MediaQuery.of(context).viewPadding]
  EdgeInsets get mediaQueryViewPadding => MediaQuery.of(this).viewPadding;

  double get paddingTop => mediaQueryViewPadding.top;

  double get paddingBottom => mediaQueryViewPadding.bottom;

  /// similar to [MediaQuery.of(context).devicePixelRatio]
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;
}
