import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/presentation/widgets/loading_dot.dart';

class CommonRoundedButton extends StatelessWidget {
  const CommonRoundedButton({
    required this.onPressed,
    required this.content,
    super.key,
    this.width,
    this.height = 48,
    this.borderRadius = 7,
    this.elevation = 0,
    this.backgroundColor,
    this.disableBackgroundColor,
    this.shadowColor,
    this.textStyle,
    this.isDisable = false,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.child,
    this.borderSide,
  });

  final VoidCallback onPressed;

  final double? width;
  final double height;
  final double borderRadius;
  final double elevation;

  final Color? backgroundColor;
  final Color? disableBackgroundColor;
  final Color? shadowColor;

  final String content;

  final TextStyle? textStyle;

  final bool isLoading;
  final bool isDisable;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? child;

  final BorderSide? borderSide;

  @override
  Widget build(BuildContext context) {
    final buttonColor = WidgetStatePropertyAll(
      isDisable
          ? (disableBackgroundColor ?? context.palette.hintTextField)
          : (backgroundColor ?? context.palette.buttonBackground),
    );

    return SizedBox(
      width: width,
      height: height,
      child: Theme(
        data: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              overlayColor: buttonColor,
              foregroundColor: buttonColor,
              backgroundColor: buttonColor,
              elevation: WidgetStateProperty.resolveWith<double>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.focused)) {
                    return 0;
                  }

                  return elevation;
                },
              ),
            ),
          ),
        ),
        child: ElevatedButton(
          onPressed: (isLoading || isDisable) ? null : onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: borderSide ?? BorderSide.none,
            ),
            shadowColor: shadowColor,
            splashFactory: NoSplash.splashFactory,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            disabledBackgroundColor: disableBackgroundColor,
            disabledForegroundColor: disableBackgroundColor,
            enableFeedback: false,
          ),
          child: isLoading
              ? const LoadingDot()
              : (child ??
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (prefixIcon != null)
                          Row(
                            children: [
                              prefixIcon!,
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        Text(
                          content,
                          style: textStyle ?? context.textStyles.buttonLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (suffixIcon != null)
                          Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              suffixIcon!,
                            ],
                          ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
