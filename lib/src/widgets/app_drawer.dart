import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/bricks/my_widgets/dotted_loading_indicator.dart';
import 'package:quran_app/src/home/view/home_page.dart';
import 'package:quran_app/src/profile/controller/user_controller.dart';
import 'package:quran_app/src/profile/view/profile_page.dart';
import 'package:quran_app/src/quran/view/surah_page.dart';
import 'package:quran_app/src/settings/controller/settings_controller.dart';
import 'package:quran_app/src/settings/settings_page.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_card.dart';
import 'package:unicons/unicons.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);

  final _settingsController = Get.put(SettingsController());
  final _userController = Get.put(UserControllerImpl());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: double.infinity,
          width: _settingsController.isHover.value
              // ignore: dead_code
              ? GetPlatform.isWeb
                  ? MediaQuery.of(context).size.width * 0.4
                  : MediaQuery.of(context).size.width * 0.4
              : GetPlatform.isWeb
                  ? MediaQuery.of(context).size.width * 0.1
                  : MediaQuery.of(context).size.width * 0.17,
          margin: const EdgeInsets.all(20),
          padding: EdgeInsets.all(_settingsController.isHover.value ? 10 : 10),
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
                onHover: (value) => _settingsController.setHovering(value),
                onTap: () {
                  // Get.back();
                  // Get.to(HomePage());
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
                    if (_settingsController.isHover.value == true)
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
                  _settingsController.setHovering(value);
                  // });
                },
                onTap: () {
                  Get.back();
                  Get.to(SurahPage());
                },
                child: AppCard(
                  hMargin: 0,
                  hPadding: _settingsController.isHover.value ? 10 : 0,
                  vPadding: 0,
                  radius: 20,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: _settingsController.isHover.value
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      Icon(
                        UniconsLine.book_open,
                        // size: 30,
                        color:
                            Theme.of(context).iconTheme.color ?? Colors.white,
                      ),
                      if (_settingsController.isHover.value == true)
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
                  _settingsController.setHovering(value);
                  // });
                },
                onTap: () => Get.to(const SettingsPage()),
                child: AppCard(
                  hMargin: 0,
                  hPadding: _settingsController.isHover.value ? 10 : 0,
                  vPadding: 0,
                  radius: 20,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: _settingsController.isHover.value
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      Icon(
                        UniconsLine.setting,
                        // size: 30,
                        color:
                            Theme.of(context).iconTheme.color ?? Colors.white,
                      ),
                      if (_settingsController.isHover.value == true)
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
                onHover: (value) => _settingsController.setHovering(value),
                onTap: () {
                  // Get.back();
                  // Get.to(SignUpPage());
                  Get.to(
                    ProfilePage(),
                    duration: const Duration(milliseconds: 500),
                    routeName: 'profile',
                    transition: Transition.circularReveal,
                  );
                },
                child: AppCard(
                  hMargin: 0,
                  hPadding: _settingsController.isHover.value ? 10 : 0,
                  vPadding: _settingsController.isHover.value ? 6 : 8,
                  radius: 20,
                  color: !_settingsController.isHover.value
                      ? Colors.transparent
                      : null,
                  child: Row(
                    mainAxisAlignment: _settingsController.isHover.value
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: (_userController.user.photoUrl != null)
                            ? Hero(
                                tag: "avatar",
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    _userController.user.photoUrl.toString(),
                                    width: 36,
                                    height: 36,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (ctx, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: SizedBox(
                                          height: 36,
                                          child:
                                              DottedCircularProgressIndicatorFb(
                                            currentDotColor: _settingsController
                                                    .isDarkMode.value
                                                ? Theme.of(context)
                                                    .backgroundColor
                                                    .withOpacity(0.3)
                                                : Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.3),
                                            defaultDotColor: _settingsController
                                                    .isDarkMode.value
                                                ? Theme.of(context)
                                                    .backgroundColor
                                                : Theme.of(context)
                                                    .primaryColor,
                                            numDots: 7,
                                            dotSize: 3,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Hero(
                                tag: "avatarIcon",
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .cardColor
                                        .withOpacity(1),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    // size: 120,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                      ),
                      if (_settingsController.isHover.value)
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Obx(
                              () => _userController.user.name != null
                                  ? Text(
                                      _userController.user.name.toString(),
                                      style: AppTextStyle.normal,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : Text(
                                      "Hamba Allah",
                                      style: AppTextStyle.normal,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  _settingsController.isDarkMode.value
                      ? Get.changeTheme(
                          AppTheme.light.copyWith(
                            primaryColor:
                                _settingsController.primaryColor.value,
                            appBarTheme: AppBarTheme(
                              color: _settingsController.primaryColor.value,
                            ),
                            bottomNavigationBarTheme:
                                BottomNavigationBarThemeData(
                              selectedItemColor:
                                  _settingsController.primaryColor.value,
                            ),
                          ),
                        )
                      : Get.changeTheme(AppTheme.dark);

                  _settingsController
                      .setDarkMode(!_settingsController.isDarkMode.value);
                },
                child: Icon(
                  _settingsController.isDarkMode.value
                      ? UniconsLine.moon
                      : UniconsLine.sun,
                  color: Theme.of(context).iconTheme.color ?? Colors.white,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              IconButton(
                onPressed: () {
                  // setState(() {
                  _settingsController
                      .setHovering(!_settingsController.isHover.value);
                  // settingsController.isHover.value =
                  //     !settingsController.isHover.value;
                  // });
                },
                icon: Icon(
                  _settingsController.isHover.value
                      ? UniconsLine.angle_left_b
                      : UniconsLine.angle_right_b,
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
