import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/src/settings/controller/settings_controller.dart';

abstract class ColorPalletes {
  static var patricksBlue = const Color(0xFF1F2970);
  static var sapphire = const Color(0xFF0D50AB);
  static var mediumPurple = const Color(0xFF7C83FD);
  static var azure = const Color(0xFF1E7AF5);
  static var frenchPink = const Color(0xFFFF5D8F);
  static var goGreen = const Color(0xFF12AE67);
  static var yellowRed = const Color(0xFFFFCA60);
  static var bgColor = const Color(0xFFF7F8F9);
  static var bgDarkColor = const Color(0xFF232931);
  static var primaryDarkColor = const Color(0xFF393E46);
}

final settingController = Get.put(SettingsController());

abstract class AppTheme {
  static final light = ThemeData.light().copyWith(
    backgroundColor: ColorPalletes.bgColor,
    scaffoldBackgroundColor: ColorPalletes.bgColor,
    primaryColor: settingController.primaryColor.value,
    cardColor: Colors.white,
    // iconTheme: IconThemeData(
    //   color: settingController.primaryColor.value,
    // ),
    appBarTheme: AppBarTheme(
      backgroundColor: settingController.primaryColor.value,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: settingController.primaryColor.value,
    ),
  );

  static final dark = ThemeData.dark().copyWith(
    backgroundColor: ColorPalletes.bgDarkColor,
    scaffoldBackgroundColor: ColorPalletes.bgDarkColor,
    primaryColor: Colors.white,
    buttonTheme: ButtonThemeData(buttonColor: ColorPalletes.goGreen),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    cardColor: ColorPalletes.primaryDarkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorPalletes.primaryDarkColor,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorPalletes.goGreen,
      foregroundColor: Colors.white,
    ),
  );
}

abstract class AppTextStyle {
  static var bigTitle = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    letterSpacing: 0.5,
  );

  static var title = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static var normal = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0.5,
  );

  static var small = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
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
