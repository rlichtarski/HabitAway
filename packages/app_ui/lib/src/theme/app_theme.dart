import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  const AppTheme();

  Brightness get brightness => Brightness.light;

  Color get backgroundColor => AppColors.lightBackground;

  Color get primary => AppColors.black;

  ThemeData get theme => FlexThemeData.light(
    scheme: FlexScheme.custom,
    colors: FlexSchemeColor.from(
      brightness: brightness,
      primary: primary,
      swapOnMaterial3: true,
    ),
    scaffoldBackground: AppColors.lightBackground,
    useMaterial3: true,
    useMaterial3ErrorColors: true,
  ).copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
      ),
    ),
    textTheme: const AppTheme().textTheme,
    iconTheme: const IconThemeData(color: AppColors.black),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      border: OutlineInputBorder(borderSide: BorderSide.none),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      showDragHandle: true,
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
    ),
  );

  /// Defines iOS dart SystemUiOverlayStyle.
  static const SystemUiOverlayStyle iOSDarkSystemBarTheme =
      SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: AppColors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  /// Text theme of the App theme.
  TextTheme get textTheme => contentTextTheme;

  static final contentTextTheme = TextTheme(
    displayLarge: ContentTextStyle.headline1,
    displayMedium: ContentTextStyle.headline2,
    displaySmall: ContentTextStyle.headline3,
    headlineLarge: ContentTextStyle.headline4,
    headlineMedium: ContentTextStyle.headline5,
    headlineSmall: ContentTextStyle.headline6,
    titleLarge: ContentTextStyle.headline7,
    titleMedium: ContentTextStyle.subtitle1,
    titleSmall: ContentTextStyle.subtitle2,
    bodyLarge: ContentTextStyle.bodyText1,
    bodyMedium: ContentTextStyle.bodyText2,
    labelLarge: ContentTextStyle.button,
    bodySmall: ContentTextStyle.caption,
    labelSmall: ContentTextStyle.overline,
  ).apply(
    bodyColor: AppColors.black,
    displayColor: AppColors.black,
    decorationColor: AppColors.black,
  );

  /// The UI text theme based on [UITextStyle].
  static final uiTextTheme = TextTheme(
    displayLarge: UITextStyle.headline1,
    displayMedium: UITextStyle.headline2,
    displaySmall: UITextStyle.headline3,
    headlineMedium: UITextStyle.headline4,
    headlineSmall: UITextStyle.headline5,
    titleLarge: UITextStyle.headline6,
    titleMedium: UITextStyle.subtitle1,
    titleSmall: UITextStyle.subtitle2,
    bodyLarge: UITextStyle.bodyText1,
    bodyMedium: UITextStyle.bodyText2,
    labelLarge: UITextStyle.button,
    bodySmall: UITextStyle.caption,
    labelSmall: UITextStyle.overline,
  ).apply(
    bodyColor: AppColors.black,
    displayColor: AppColors.black,
    decorationColor: AppColors.black,
  );
}

class AppDarkTheme extends AppTheme {
  const AppDarkTheme();

  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get backgroundColor => AppColors.darkBackground;

  @override
  Color get primary => AppColors.white;

  @override
  TextTheme get textTheme {
    return AppTheme.contentTextTheme.apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
      decorationColor: AppColors.white,
    );
  }

  @override
  ThemeData get theme => FlexThemeData.dark(
    scheme: FlexScheme.custom,
    darkIsTrueBlack: true,
    colors: FlexSchemeColor.from(
      brightness: brightness,
      primary: primary,
      appBarColor: AppColors.transparent,
      swapOnMaterial3: true,
    ),
    scaffoldBackground: AppColors.darkBackground,
    useMaterial3: true,
    useMaterial3ErrorColors: true,
  ).copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
      ),
    ),
    textTheme: const AppDarkTheme().textTheme,
    iconTheme: const IconThemeData(color: AppColors.white),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      border: OutlineInputBorder(borderSide: BorderSide.none),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.background,
      surfaceTintColor: AppColors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: AppColors.background,
      backgroundColor: AppColors.background,
      modalBackgroundColor: AppColors.background,
    ),
  );
}

class SystemUiOverlayTheme {
  const SystemUiOverlayTheme();

  /// Defines iOS light SystemUiOverlayStyle.
  static const SystemUiOverlayStyle iOSLightSystemBarTheme =
      SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarColor: AppColors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  /// Defines iOS dark SystemUiOverlayStyle.
  static const SystemUiOverlayStyle iOSDarkSystemBarTheme =
      SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: AppColors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  /// Defines Android light SystemUiOverlayStyle.
  static const SystemUiOverlayStyle androidLightSystemBarTheme =
      SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: AppColors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  /// Defines light SystemUiOverlayStyle.
  static const SystemUiOverlayStyle androidDarkSystemBarTheme =
      SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarColor: AppColors.black,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  /// Defines a portrait only orientation for any device.
  static void setPortraitOrientation() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
  }
}
