import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/presentation/widgets/common_rounded_button.dart';
import 'package:flutter_template/presentation/widgets/custom_popup_route.dart';

abstract class DialogUtil {
  static bool _isDialogOpen = false;

  static void hideLoading(BuildContext context) {
    if (!_isDialogOpen) return;

    _isDialogOpen = false;
    Navigator.of(context).pop();
  }

  static void showLoading(BuildContext context) {
    _isDialogOpen = true;

    Navigator.of(context).push(
      CustomPopupRoute<dynamic>(
        child: PopScope(
          canPop: false,
          child: Center(
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const CupertinoActivityIndicator(),
            ),
          ),
        ),
        barrierDismissible: false,
      ),
    );
  }

  static Future<dynamic> showCustomDialog(
    BuildContext context, {
    required String title,
    bool barrierDismissible = true,
    TextStyle? titleStyle,
    String? content,
    TextStyle? contentStyle,
    Widget? child,
    String? cancelButtonText,
    VoidCallback? cancelAction,
    String? confirmButtonText,
    VoidCallback? confirmAction,
    bool isConfirmDialog = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
          content: child ??
              Text(
                content ?? '',
                style: contentStyle,
              ),
          actions: <Widget>[
            if (isConfirmDialog)
              CommonRoundedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  cancelAction?.call();
                },
                content: cancelButtonText ?? LocaleKeys.button_cancel.tr(),
                textStyle: context.textStyles.errorButtonLabel,
                borderSide: BorderSide(color: context.palette.errorButtonLabel),
                backgroundColor: Colors.transparent,
                height: 45,
              ),
            const SizedBox(
              width: 15,
            ),
            CommonRoundedButton(
              width: isConfirmDialog ? null : double.infinity,
              onPressed: () {
                Navigator.of(context).pop();
                confirmAction?.call();
              },
              content: confirmButtonText ?? LocaleKeys.button_confirm.tr(),
              textStyle: context.textStyles.buttonLabel,
              height: 45,
            ),
          ],
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          actionsPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          buttonPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: context.palette.dialogBackground,
        );
      },
    );
  }
}
