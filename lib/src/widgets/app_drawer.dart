import 'package:flutter/material.dart';
import 'package:flutter_unicons/flutter_unicons.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/settings/controller/settings_controller.dart';
import 'package:quran_app/src/settings/settings_page.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);

  final settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: double.infinity,
          width: settingsController.isHover.value
              // ignore: dead_code
              ? GetPlatform.isWeb
                  ? MediaQuery.of(context).size.width * 0.4
                  : MediaQuery.of(context).size.width * 0.4
              : GetPlatform.isWeb
                  ? MediaQuery.of(context).size.width * 0.1
                  : MediaQuery.of(context).size.width * 0.15,
          margin: const EdgeInsets.all(20),
          padding: EdgeInsets.all(settingsController.isHover.value ? 20 : 10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onHover: (value) {
                  // setState(() {
                  // settingsController.isHover.value = value;
                  settingsController.setHovering(value);
                  // });
                },
                onTap: () => Get.back(),
                child: Row(
                  mainAxisAlignment: settingsController.isHover.value
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    Unicon(
                      Unicons.uniBookOpen,
                      size: 30,
                      color: Theme.of(context).iconTheme.color ?? Colors.white,
                    ),
                    if (settingsController.isHover.value == true)
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: FittedBox(
                            child: Text(
                              "Quran",
                              style: AppTextStyle.normal,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              const Spacer(),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onHover: (value) {
                  // setState(() {
                  // settingsController.isHover.value = value;
                  settingsController.setHovering(value);
                  // });
                },
                onTap: () => Get.to(const SettingsPage()),
                child: Row(
                  mainAxisAlignment: settingsController.isHover.value
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    Unicon(
                      Unicons.uniSetting,
                      size: 30,
                      color: Theme.of(context).iconTheme.color ?? Colors.white,
                    ),
                    if (settingsController.isHover.value == true)
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: FittedBox(
                            child: Text(
                              "Settings",
                              style: AppTextStyle.normal,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              IconButton(
                onPressed: () {
                  settingsController.isDarkMode.value
                      ? Get.changeTheme(AppTheme.light)
                      : Get.changeTheme(AppTheme.dark);

                  settingsController
                      .setDarkMode(!settingsController.isDarkMode.value);
                  // isDarkMode = !isDarkMode;
                },
                icon: Unicon(
                  settingsController.isDarkMode.value
                      ? Unicons.uniSun
                      : Unicons.uniMoon,
                  size: 22,
                  color: Theme.of(context).iconTheme.color ?? Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  // setState(() {
                  settingsController
                      .setHovering(!settingsController.isHover.value);
                  // settingsController.isHover.value =
                  //     !settingsController.isHover.value;
                  // });
                },
                icon: Unicon(
                  settingsController.isHover.value
                      ? Unicons.uniAngleLeftB
                      : Unicons.uniAngleRightB,
                  size: 22,
                  color: Theme.of(context).iconTheme.color ?? Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
