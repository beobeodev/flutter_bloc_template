import 'package:flutter/material.dart';

abstract class SheetUtil {
  static Future<dynamic> show(BuildContext context, Widget child) async {
    final params = await showModalBottomSheet<dynamic>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (_) {
        return child;
      },
    );

    return params;
  }
}
