import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FocusedMenuItem {
  Color? backgroundColor;
  Widget title;
  Widget? trailing;
  VoidCallback onPressed;

  FocusedMenuItem({
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.trailing,
  });
}
