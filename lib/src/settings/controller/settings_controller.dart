import 'package:get/get.dart';

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

}
