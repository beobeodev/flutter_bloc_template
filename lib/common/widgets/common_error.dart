import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/common/theme/color_styles.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/widgets/common_rounded_button.dart';
import 'package:flutter_template/generated/assets.gen.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';

class CommonError extends StatelessWidget {
  const CommonError({super.key, this.onRefresh});
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.lottie.error.lottie(
            width: context.width / 2,
          ),
          Text(
            LocaleKeys.texts_error_occur.tr(),
            style:
                TextStyles.s17RegularText.copyWith(color: ColorStyles.red500),
            textAlign: TextAlign.center,
          ),
          if (onRefresh != null)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CommonRoundedButton(
                onPressed: onRefresh!,
                content: LocaleKeys.button_try_again.tr(),
              ),
            )
        ],
      ),
    );
  }
}