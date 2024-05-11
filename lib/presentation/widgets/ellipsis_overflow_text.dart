import 'package:flutter/material.dart';

///
/// Flutter widget that automatically sets the number of lines to be shown on a text
/// with the ellipsis overflow type.
///
class EllipsisOverflowText extends StatelessWidget {
  const EllipsisOverflowText(
    this.data, {
    super.key,
    this.textKey,
    this.locale,
    this.maxLines,
    this.semanticsLabel,
    this.selectionColor,
    this.softWrap,
    this.strutStyle,
    this.style,
    this.textAlign,
    this.textDirection,
    this.textHeightBehavior,
    this.textScaler,
    this.textWidthBasis,
  })  : assert(
          maxLines == null || maxLines > 0,
          'maxLines must be greather than 0.',
        ),
        assert(
          key == null || key != textKey,
          'Key and textKey must not be equal.',
        );

  final Key? textKey;
  final String data;
  final TextStyle? style;
  static const double _defaultFontSize = 14;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextScaler? textScaler;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  final int? maxLines;

  int? _calculateMaxLines(BoxConstraints constraints, TextPainter textPainter) {
    if (!constraints.hasBoundedHeight || !constraints.hasBoundedWidth) {
      return null;
    }

    final boxes = textPainter.getBoxesForSelection(
      TextSelection(baseOffset: 0, extentOffset: data.length),
    );

    final textHeight = boxes.first.toRect().height;

    final maxLines = constraints.maxHeight ~/ (textHeight - (textPainter.text?.style?.height ?? 1));

    if (maxLines < 1) {
      return null;
    }

    return maxLines;
  }

  (int?, String) _loadData({
    required BoxConstraints constraints,
    required TextStyle style,
    required TextScaler textScaler,
    int? initMaxLines,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: data, style: style),
      textDirection: TextDirection.ltr,
      locale: locale ?? style.locale,
      textScaler: textScaler,
      textHeightBehavior: textHeightBehavior,
      strutStyle: strutStyle,
    );

    textPainter.layout(maxWidth: constraints.maxWidth);

    final finalMaxLines = initMaxLines ?? _calculateMaxLines(constraints, textPainter);

    return (finalMaxLines, data);
  }

  @override
  Widget build(BuildContext context) {
    if (data.trim().isEmpty) {
      return Text(
        data,
        style: style,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final defaultTextStyle = DefaultTextStyle.of(context);

        var textStyle = style ?? defaultTextStyle.style;

        if (textStyle.fontSize == null) {
          textStyle = textStyle.copyWith(
            fontSize: EllipsisOverflowText._defaultFontSize,
          );
        }

        final defaultTextScaler = textScaler ?? MediaQuery.of(context).textScaler;

        final maxLinesFinal = maxLines ?? defaultTextStyle.maxLines;

        final r = _loadData(
          constraints: constraints,
          style: textStyle,
          textScaler: defaultTextScaler,
          initMaxLines: maxLinesFinal,
        );

        return Text(
          r.$2,
          key: textKey,
          style: textStyle,
          overflow: TextOverflow.ellipsis,
          textHeightBehavior: textHeightBehavior,
          textAlign: textAlign,
          softWrap: softWrap,
          textDirection: textDirection,
          textWidthBasis: textWidthBasis,
          textScaler: defaultTextScaler,
          locale: locale,
          selectionColor: selectionColor,
          semanticsLabel: semanticsLabel,
          strutStyle: strutStyle,
          maxLines: r.$1,
        );
      },
    );
  }
}
