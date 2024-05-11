import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_template/presentation/widgets/focused_menu/focused_menu_item.dart';

class FocusedMenuDetails extends StatelessWidget {
  final List<FocusedMenuItem> menuItems;
  final BoxDecoration? menuBoxDecoration;
  final Offset childOffset;
  final double? itemExtent;
  final Size? childSize;
  final Widget child;
  final bool animateMenu;
  final double? blurSize;
  final double? menuWidth;
  final Color? blurBackgroundColor;
  final double? bottomOffsetHeight;
  final double? menuOffset;

  const FocusedMenuDetails({
    required this.menuItems,
    required this.child,
    required this.childOffset,
    required this.childSize,
    required this.menuBoxDecoration,
    required this.itemExtent,
    required this.animateMenu,
    required this.blurSize,
    required this.blurBackgroundColor,
    required this.menuWidth,
    super.key,
    this.bottomOffsetHeight,
    this.menuOffset,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final maxMenuHeight = size.height * 0.45;
    final listHeight = menuItems.length * (itemExtent ?? 50.0);

    final maxMenuWidth = menuWidth ?? (size.width * 0.70);
    final menuHeight = listHeight < maxMenuHeight ? listHeight : maxMenuHeight;
    final leftOffset = (childOffset.dx + maxMenuWidth) < size.width
        ? childOffset.dx
        : (childOffset.dx - maxMenuWidth + childSize!.width);
    final topOffset = (childOffset.dy + menuHeight + childSize!.height) < size.height - bottomOffsetHeight!
        ? childOffset.dy + childSize!.height + menuOffset!
        : childOffset.dy - menuHeight - menuOffset!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurSize ?? 4,
                sigmaY: blurSize ?? 4,
              ),
              child: Container(
                color: (blurBackgroundColor ?? Colors.black).withOpacity(0.7),
              ),
            ),
          ),
          Positioned(
            top: topOffset,
            left: leftOffset,
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 200),
              builder: (BuildContext context, int value, Widget? child) {
                return Transform.scale(
                  scale: value.toDouble(),
                  child: child,
                );
              },
              tween: Tween(begin: 0, end: 1),
              child: Container(
                width: maxMenuWidth,
                height: menuHeight,
                decoration: menuBoxDecoration ??
                    BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: ListView.builder(
                    itemCount: menuItems.length,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      final Widget listItem = GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          item.onPressed();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 1),
                          color: item.backgroundColor ?? Colors.white,
                          height: itemExtent ?? 50.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 14,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                item.title,
                                if (item.trailing != null) ...[item.trailing!],
                              ],
                            ),
                          ),
                        ),
                      );
                      if (animateMenu) {
                        return TweenAnimationBuilder(
                          builder: (context, int value, child) {
                            return Transform(
                              transform: Matrix4.rotationX(1.5708 * value),
                              alignment: Alignment.bottomCenter,
                              child: child,
                            );
                          },
                          tween: Tween(begin: 1, end: 0),
                          duration: Duration(milliseconds: index * 200),
                          child: listItem,
                        );
                      } else {
                        return listItem;
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: childOffset.dy,
            left: childOffset.dx,
            child: AbsorbPointer(
              child: SizedBox(
                width: childSize!.width,
                height: childSize!.height,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
