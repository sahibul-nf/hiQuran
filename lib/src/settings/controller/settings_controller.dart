import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class SettingsController extends GetxController {
  // for state of darkMode
  var isDarkMode = false.obs;
  void setDarkMode(bool value) {
    isDarkMode.value = value;
  }

  // for state of Drawer
  var isHover = false.obs;
  void setHovering(bool value) {
    isHover.value = value;
  }

  var primaryColor = ColorPalletes.goGreen.obs;
  void setPrimaryColor(Color value) {
    primaryColor.value = value;
  }

  void setThemePrimaryColor(Color value) {
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
  }
}
