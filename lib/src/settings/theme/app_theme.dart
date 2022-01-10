import 'package:flutter/material.dart';

abstract class ColorPalletes {
  static var patricksBlue = const Color(0xFF1F2970);
  static var sapphire = const Color(0xFF0D50AB);
  static var mediumPurple = const Color(0xFF7C83FD);
  static var azure = const Color(0xFF1E7AF5);
  static var goGreen = const Color(0xFF12AE67);
  static var yellowRed = const Color(0xFFFFCA60);
  static var bgColor = const Color(0xFFEBF1FF);
}

abstract class AppTheme {
  static final light = ThemeData.light().copyWith(
    backgroundColor: ColorPalletes.bgColor,
    scaffoldBackgroundColor: ColorPalletes.bgColor,
    primaryColor: ColorPalletes.azure,
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorPalletes.azure,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: ColorPalletes.azure,
    ),
  );

  static final dark = ThemeData.dark().copyWith(
    backgroundColor: const Color(0x00f4f6f8),
    buttonTheme: const ButtonThemeData(buttonColor: Colors.lightBlue),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.lightBlue,
      foregroundColor: Colors.white,
    ),
  );
}

abstract class AppTextStyle {
  static var bigTitle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    letterSpacing: 0.5,
  );

  static var title = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static var normal = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static var small = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13,
    letterSpacing: 0.3,
  );
}

abstract class AppShadow {
  static var card = const BoxShadow(
    color: Color(0x00000014),
    blurRadius: 20,
    spreadRadius: 3,
    offset: Offset(0, 3),
  );
}
