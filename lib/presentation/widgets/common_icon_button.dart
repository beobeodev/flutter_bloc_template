import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';

class CommonIconButton extends StatelessWidget {
  const CommonIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.iconColor,
  });
  final Color? iconColor;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor ?? context.palette.normalText,
        size: 28,
      ),
      padding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    );
  }
}
