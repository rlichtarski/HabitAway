import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  Brightness get brightness => theme.brightness;

  bool get isLight => brightness == Brightness.light;

  bool get isDark => !isLight;

  void unfocus() => FocusScope.of(this).unfocus();

  void popNavigator() => Navigator.of(this).pop();

  ThemeData get themeReference => const AppTheme().theme;

  /// Defines an adaptive [Color], depending on current theme brightness.
  Color get adaptiveColor => isDark ? AppColors.white : AppColors.black;

  /// Defines a reversed adaptive [Color], depending on current theme
  /// brightness.
  Color get reversedAdaptiveColor => isDark ? AppColors.black : AppColors.white;

  /// Defines a customizable adaptive [Color]. If [light] or [dark] is not
  /// provided default colors are used.
  Color customAdaptiveColor({Color? light, Color? dark}) =>
      isDark ? (light ?? AppColors.white) : (dark ?? AppColors.black);

  /// Defines a customizable reversed adaptive [Color]. If [light] or [dark]
  /// is not provided default reversed colors are used.
  Color customReversedAdaptiveColor({Color? light, Color? dark}) =>
      isDark ? (dark ?? AppColors.black) : (light ?? AppColors.white);

  Size get size => MediaQuery.sizeOf(this);

  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  double get screenWidth => size.width;

  double get screenHeight => size.height;

  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  bool get isAndroid => theme.platform == TargetPlatform.android;

  bool get isIOS => !isAndroid;

  bool get isMobile => isAndroid || isIOS;

  void showSnackBar(
    String text, {
    bool dismissible = true,
    Color color = AppColors.white,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior? behavior,
    SnackBarAction? snackBarAction,
    String? solution,
    DismissDirection dismissDirection = DismissDirection.down,
  }) => ScaffoldMessenger.of(this)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
        action: snackBarAction,
        behavior: behavior,
        backgroundColor: color,
        dismissDirection: dismissDirection,
        duration: duration,
      ),
    );

  void closeSnackBars() {
    ScaffoldMessenger.of(this).clearSnackBars();
  }

}
