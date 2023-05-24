import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/color_styles.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/widgets/common_back_button.widget.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    this.isCenterTitle = true,
    this.automaticallyImplyLeading = true,
    this.backgroundColor = Colors.transparent,
    this.titleColor = ColorStyles.zodiacBlue,
    this.toolbarHeight = AppSize.appBarHeight,
    this.titleSpacing = AppSize.titleSpacing,
    this.elevation = 0,
    this.bottomSize = 45,
    required this.title,
    this.bottom,
    this.actions = const [],
    this.onLeadingAction,
  }) : assert(
          title is Widget || title is String,
          'Title must be a widget or string ',
        );
  final bool isCenterTitle;
  final bool automaticallyImplyLeading;

  final Color backgroundColor;
  final Color titleColor;

  final double toolbarHeight;
  final double titleSpacing;
  final double elevation;
  final double bottomSize;

  final dynamic title;
  final Widget? bottom;
  final List<Widget> actions;

  final Function()? onLeadingAction;

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
          ? title
          : Text(
              title,
              style:
                  TextStyles.boldText.copyWith(color: titleColor, fontSize: 16),
            ),
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(bottomSize),
              child: bottom!,
            )
          : null,
      actions: actions,
      leading: (automaticallyImplyLeading && Navigator.of(context).canPop())
          ? const CommonBackButton()
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}