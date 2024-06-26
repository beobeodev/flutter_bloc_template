import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/presentation/widgets/common_back_button.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    required this.title,
    super.key,
    this.isCenterTitle = true,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.titleStyle,
    this.toolbarHeight = kToolbarHeight,
    this.titleSpacing = AppSize.titleSpacing,
    this.elevation = 0,
    this.bottomSize = 45,
    this.bottom,
    this.actions = const [],
    this.onLeadingAction,
  }) : assert(
          title is Widget || title is String,
          'Title must be a widget or string ',
        );
  final bool isCenterTitle;
  final bool automaticallyImplyLeading;

  final Color? backgroundColor;
  final TextStyle? titleStyle;

  final double toolbarHeight;
  final double titleSpacing;
  final double elevation;
  final double bottomSize;

  final dynamic title;
  final Widget? bottom;
  final List<Widget> actions;

  final VoidCallback? onLeadingAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isCenterTitle,
      backgroundColor: backgroundColor,
      elevation: elevation,
      toolbarHeight: toolbarHeight,
      titleSpacing: titleSpacing,
      automaticallyImplyLeading: false,
      title: title is Widget
          ? title as Widget
          : Text(
              title as String,
              style: titleStyle ?? context.textStyles.body1,
            ),
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(bottomSize),
              child: bottom!,
            )
          : null,
      actions: actions,
      leading: (automaticallyImplyLeading && Navigator.of(context).canPop()) ? const CommonBackButton() : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
