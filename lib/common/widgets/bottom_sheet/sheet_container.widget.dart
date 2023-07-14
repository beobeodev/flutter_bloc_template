import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/common/widgets/bottom_sheet/sheet_header.widget.dart';
import 'package:flutter_template/common/widgets/bottom_sheet/sheet_search_field.widget.dart';

class SheetSearchContainer extends StatelessWidget {
  final String title;
  final String hintText;
  final Widget child;
  final void Function(String)? onFieldSubmitted;

  const SheetSearchContainer({
    super.key,
    required this.title,
    required this.child,
    required this.hintText,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height / 1.2,
      child: Column(
        children: [
          SheetHeader(
            title: title,
          ),
          SheetSearchField(
            hintText: hintText,
            onFieldSubmitted: onFieldSubmitted,
          ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
