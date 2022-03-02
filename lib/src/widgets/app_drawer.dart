import 'package:flutter/material.dart';
import 'package:flutter_unicons/flutter_unicons.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/home/view/home_page.dart';
import 'package:quran_app/src/profile/view/profile_page.dart';
import 'package:quran_app/src/quran/view/surah_page.dart';
import 'package:quran_app/src/settings/controller/settings_controller.dart';
import 'package:quran_app/src/settings/settings_page.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_card.dart';

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
                  : MediaQuery.of(context).size.width * 0.17,
          margin: const EdgeInsets.all(20),
          padding: EdgeInsets.all(settingsController.isHover.value ? 10 : 10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onHover: (value) => settingsController.setHovering(value),
                onTap: () {
                  Get.back();
                  Get.to(HomePage());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        "assets/icon/icon.png",
                        height: 36,
                      ),
                    ),
                    if (settingsController.isHover.value == true)
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: FittedBox(
                            child: Text(
                              "hiQuran",
                              style: AppTextStyle.title,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              InkWell(
                onHover: (value) {
                  // setState(() {
                  // settingsController.isHover.value = value;
                  settingsController.setHovering(value);
                  // });
                },
                onTap: () {
                  Get.back();
                  Get.to(SurahPage());
                },
                child: AppCard(
                  hMargin: 0,
                  hPadding: settingsController.isHover.value ? 10 : 0,
                  vPadding: 0,
                  radius: 20,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: settingsController.isHover.value
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      Unicon(
                        Unicons.uniBookOpen,
                        // size: 30,
                        color:
                            Theme.of(context).iconTheme.color ?? Colors.white,
                      ),
                      if (settingsController.isHover.value == true)
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
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
                child: AppCard(
                  hMargin: 0,
                  hPadding: settingsController.isHover.value ? 10 : 0,
                  vPadding: 0,
                  radius: 20,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: settingsController.isHover.value
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      Unicon(
                        Unicons.uniSetting,
                        // size: 30,
                        color:
                            Theme.of(context).iconTheme.color ?? Colors.white,
                      ),
                      if (settingsController.isHover.value == true)
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
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
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onHover: (value) => settingsController.setHovering(value),
                onTap: () {
                  Get.back();
                  Get.to(const ProfilePage());
                },
                child: AppCard(
                  hMargin: 0,
                  hPadding: settingsController.isHover.value ? 10 : 0,
                  vPadding: settingsController.isHover.value ? 10 : 8,
                  radius: 20,
                  color: !settingsController.isHover.value
                      ? Colors.transparent
                      : null,
                  child: Row(
                    mainAxisAlignment: settingsController.isHover.value
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Image.asset(
                          "assets/memojiBoy.png",
                          height: 36,
                        ),
                      ),
                      if (settingsController.isHover.value)
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Sahibul Nuzul Firdaus",
                              style: AppTextStyle.normal,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  settingsController.isDarkMode.value
                      ? Get.changeTheme(
                          AppTheme.light.copyWith(
                            primaryColor: settingsController.primaryColor.value,
                            appBarTheme: AppBarTheme(
                              color: settingsController.primaryColor.value,
                            ),
                            bottomNavigationBarTheme:
                                BottomNavigationBarThemeData(
                              selectedItemColor:
                                  settingsController.primaryColor.value,
                            ),
                          ),
                        )
                      : Get.changeTheme(AppTheme.dark);

                  settingsController
                      .setDarkMode(!settingsController.isDarkMode.value);
                },
                child: Unicon(
                  settingsController.isDarkMode.value
                      ? Unicons.uniMoon
                      : Unicons.uniSun,
                  color: Theme.of(context).iconTheme.color ?? Colors.white,
                ),
              ),
              const SizedBox(
                height: 8,
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
