import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/common/theme/palette.dart';
import 'package:flutter_template/common/theme/text_styles.dart';

extension ContextExtension on BuildContext {
  /// The same of [MediaQuery.of(context).size]
  Size get mediaQuerySize => MediaQuery.of(this).size;

  double get height => mediaQuerySize.height;

  double get width => mediaQuerySize.width;

  ThemeData get theme => Theme.of(this);

  /// similar to [MediaQuery.of(context).viewPadding]
  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).viewPadding;

  double get paddingTop => mediaQueryPadding.top;

  double get paddingBottom => mediaQueryPadding.bottom;

  /// similar to [MediaQuery.of(context).devicePixelRatio]
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  double dialogInsideWidth({
    double contentPadding = AppSize.horizontalSpacing,
  }) {
    return width - 40 * 2 - 2 * contentPadding;
  }

  double get bottomSpacing => paddingBottom > 0 ? paddingBottom : 10;

  AppTextStyles get textStyles => Theme.of(this).extension<AppTextStyles>()!;

  Palette get palette => Theme.of(this).extension<Palette>()!;

}

extension ConfigurationExt on BuildContext {
  /// Check if dark mode theme is enable
  bool get isDarkMode => theme.brightness == Brightness.dark;

  TargetPlatform get platform => Theme.of(this).platform;

  bool get isAndroid => platform == TargetPlatform.android;

  bool get isIOS => platform == TargetPlatform.iOS;

  bool get isMacOS => platform == TargetPlatform.macOS;

  bool get isWindows => platform == TargetPlatform.windows;

  bool get isFuchsia => platform == TargetPlatform.fuchsia;

  bool get isLinux => platform == TargetPlatform.linux;

  bool get alwaysUse24HourFormat => MediaQuery.of(this).alwaysUse24HourFormat;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;
}

extension ScaffoldExt on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackbar,
  ) =>
      ScaffoldMessenger.of(this).showSnackBar(snackbar);

  void removeCurrentSnackBar({
    SnackBarClosedReason reason = SnackBarClosedReason.remove,
  }) =>
      ScaffoldMessenger.of(this).removeCurrentSnackBar(reason: reason);

  void hideCurrentSnackBar({
    SnackBarClosedReason reason = SnackBarClosedReason.hide,
  }) =>
      ScaffoldMessenger.of(this).hideCurrentSnackBar(reason: reason);

  void openDrawer() => Scaffold.of(this).openDrawer();

  void openEndDrawer() => Scaffold.of(this).openEndDrawer();

  void showBottomSheet(
    WidgetBuilder builder, {
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehaviour,
  }) =>
      Scaffold.of(this).showBottomSheet(
        builder,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehaviour,
      );
}

class _Form {
  _Form(this._context);

  final BuildContext _context;

  bool validate() => Form.of(_context).validate();

  void reset() => Form.of(_context).reset();

  void save() => Form.of(_context).save();
}

extension FormExt on BuildContext {
  // ignore: library_private_types_in_public_api
  _Form get form => _Form(this);
}

class _FocusScope {
  const _FocusScope(this._context);

  final BuildContext _context;

  FocusScopeNode _node() => FocusScope.of(_context);

  bool get hasFocus => _node().hasFocus;

  bool get isFirstFocus => _node().isFirstFocus;

  bool get hasPrimaryFocus => _node().hasPrimaryFocus;

  bool get canRequestFocus => _node().canRequestFocus;

  void nextFocus() => _node().nextFocus();

  void requestFocus([FocusNode? node]) => _node().requestFocus(node);

  void previousFocus() => _node().previousFocus();

  void unfocus({UnfocusDisposition disposition = UnfocusDisposition.scope}) =>
      _node().unfocus(disposition: disposition);

  void setFirstFocus(FocusScopeNode scope) => _node().setFirstFocus(scope);

  bool consumeKeyboardToken() => _node().consumeKeyboardToken();
}

extension FocusScopeExt on BuildContext {
  // ignore: library_private_types_in_public_api
  _FocusScope get focusScope => _FocusScope(this);

  void closeKeyboard() => focusScope.requestFocus(FocusNode());
}

extension ModalRouteExt<T> on BuildContext {
  ModalRoute<T>? get modalRoute => ModalRoute.of<T>(this);

  RouteSettings? get routeSettings => modalRoute?.settings;
}
