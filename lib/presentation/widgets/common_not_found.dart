import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/generated/assets.gen.dart';

class CommonNotFound extends StatelessWidget {
  const CommonNotFound({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.images.lottie.searchNotFound.lottie(
          width: context.width / 2,
        ),
        Text(
          text,
          style: context.textStyles.body1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
