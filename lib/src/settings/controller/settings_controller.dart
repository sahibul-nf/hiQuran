import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class SettingsController extends GetxController {
  // for state of darkMode
  var isDarkMode = false.obs;
  void setDarkMode(bool value) {
    isDarkMode.value = value;

    if (isDarkMode.value) {
      Get.changeTheme(AppTheme.dark);

      final box = Get.find<GetStorage>();
      box.write('themeColor', kDarkMode);
    }
  }

  // for state of Drawer
  var isHover = false.obs;
  void setHovering(bool value) {
    isHover.value = value;
  }

  var kAzure = "Azure";
  var kGoGreen = "Go Green";
  var kSapphire = "Sapphire";
  var kMediumPupple = "Medium Pupple";
  var kFrenchPink = "French Pink";
  var kDarkMode = "Dark";

  List<String> listColorName = [
    "Azure",
    "Go Green",
    "Sapphire",
    "Medium Pupple",
    "French Pink"
  ];

  List<Color> listColor = [
    ColorPalletes.azure,
    ColorPalletes.goGreen,
    ColorPalletes.sapphire,
    ColorPalletes.mediumPurple,
    ColorPalletes.frenchPink
  ];

  var primaryColor = ColorPalletes.goGreen.obs;
  void setPrimaryColor(Color value, String key) {
    primaryColor.value = value;

    final box = Get.find<GetStorage>();
    box.write('primaryColor', key);
    final color = box.read('primaryColor');
    final theme = box.read('themeColor');
    log("Primary Color : $color");
    log("Theme Color : $theme");
  }

  void setThemePrimaryColor(Color value, {String? key}) {
    Get.changeTheme(
      AppTheme.light.copyWith(
        primaryColor: value,
        appBarTheme: AppBarTheme(
          color: value,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: value,
        ),
      ),
    );

    if (isDarkMode.value) {
      setDarkMode(false);
    }

    if (key != null) {
      final box = Get.find<GetStorage>();
      box.write('themeColor', key);
      box.write('primaryColor', key);
    }
  }

  setTheme(var themeColor) {
    if (themeColor == kDarkMode) {
      setDarkMode(true);
    }

    if (themeColor == kAzure) {
      setPrimaryColor(ColorPalletes.azure, kAzure);
      setThemePrimaryColor(ColorPalletes.azure, key: kAzure);
    }
    if (themeColor == kFrenchPink) {
      setPrimaryColor(ColorPalletes.frenchPink, kFrenchPink);
      setThemePrimaryColor(ColorPalletes.frenchPink, key: kFrenchPink);
    }
    if (themeColor == kGoGreen) {
      setPrimaryColor(ColorPalletes.goGreen, kGoGreen);
      setThemePrimaryColor(ColorPalletes.goGreen, key: kGoGreen);
    }
    if (themeColor == kMediumPupple) {
      setPrimaryColor(ColorPalletes.mediumPurple, kMediumPupple);
      setThemePrimaryColor(ColorPalletes.mediumPurple, key: kMediumPupple);
    }
    if (themeColor == kSapphire) {
      setPrimaryColor(ColorPalletes.sapphire, kSapphire);
      setThemePrimaryColor(ColorPalletes.sapphire, key: kSapphire);
    }
  }

}
