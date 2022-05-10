import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:quran_app/bricks/my_widgets/my_button.dart';
import 'package:quran_app/bricks/my_widgets/my_circle_avatar.dart';
import 'package:quran_app/bricks/my_widgets/my_outline_button.dart';
import 'package:quran_app/src/profile/controllers/auth_controller.dart';
import 'package:quran_app/src/profile/controllers/user_controller.dart';
import 'package:quran_app/src/profile/models/user.dart';
import 'package:quran_app/src/profile/views/signin_page.dart';
import 'package:quran_app/src/settings/controller/settings_controller.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_card.dart';
import 'package:quran_app/src/widgets/coming_soon_card.dart';
import 'package:quran_app/src/wrapper.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unicons/unicons.dart';
import 'package:wiredash/wiredash.dart';

import '../../../helper/global_state.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final _settingController = Get.put(SettingsController());
  final _authController = Get.put(AuthControllerImpl());
  final _userController = Get.put(UserControllerImpl());
  final _state = Get.put(GlobalState());

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    // if (_settingController.isDarkMode.value) {
    //   primaryColor = Theme.of(context).scaffoldBackgroundColor;
    // }
    if (Get.isDarkMode) {
      primaryColor = Theme.of(context).appBarTheme.backgroundColor!;
    }
    final size = MediaQuery.of(context).size;

    final box = Get.find<GetStorage>();
    final session = box.read('user');
    log("Session : $session");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: AppTextStyle.bigTitle,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: size.height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          children: [
            Obx(() {
              if (_userController.user.avatarUrl != null) {
                return Container(
                  color: primaryColor,
                  width: size.width,
                  height: size.height * 0.5,
                  child: Hero(
                    tag: "avatar",
                    child: ModelViewer(
                      src: _userController.user.avatarUrl.toString(),
                      autoRotate: true,
                      cameraControls: true,
                      backgroundColor: primaryColor,
                      alt: "A 3D model of user avatar",
                      ar: true,
                    ),
                  ),
                );
              } else if (_userController.user.photoUrl != null) {
                return Container(
                  color: primaryColor,
                  width: size.width,
                  height: size.height * 0.5,
                  padding: const EdgeInsets.only(bottom: 90),
                  child: Hero(
                    tag: "avatar",
                    child: MyCircleAvatar(
                      primaryColor: _settingController.isDarkMode.value
                          ? Theme.of(context).backgroundColor
                          : Theme.of(context).cardColor,
                      image: NetworkImage(
                        _userController.user.photoUrl.toString(),
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  color: _settingController.isDarkMode.value
                      ? Theme.of(context).cardColor
                      : primaryColor,
                  height: size.height * 0.5,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: "avatarIcon",
                      child: Container(
                        margin: const EdgeInsets.only(top: 90),
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: _settingController.isDarkMode.value
                              ? Colors.grey.withOpacity(0.3)
                              : Theme.of(context).cardColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 70,
                          color: _settingController.isDarkMode.value
                              ? Colors.grey
                              : Theme.of(context).cardColor,
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              maxChildSize: 0.65,
              minChildSize: 0.5,
              snap: true,
              builder: (context, controller) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                    color: _settingController.isDarkMode.value
                        ? Theme.of(context).backgroundColor
                        : Theme.of(context).cardColor,
                    boxShadow: [AppShadow.card],
                  ),
                  child: ListView(
                    controller: controller,
                    children: [
                      const SizedBox(height: 40),
                      Obx(
                        () => Text(
                          _userController.user.name ?? "Hamba Allah",
                          style: AppTextStyle.title.copyWith(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => Text(
                          _userController.user.email ?? "hambaallah@gmail.com",
                          style: AppTextStyle.normal.copyWith(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => Text(
                          _userController.user.bio ?? "Better than yesterday",
                          style: AppTextStyle.small.copyWith(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (_userController.user.email != null)
                        ProfileItem(
                          icon: UniconsLine.edit_alt,
                          title: "Edit Profile",
                          onPressed: () {
                            Get.bottomSheet(const ComingSoonCard());
                          },
                        ),
                      const SizedBox(height: 16),
                      ProfileItem(
                        icon: UniconsLine.share_alt,
                        title: "Share hiQuran",
                        onPressed: () {
                          Share.share(
                            "Aplikasi Quran yang luar biasa dengan desain yang indah, mudah digunakan dan banyak fitur. \n🚀 Install hiQuran dengan klik link berikut, \nhttps://s.id/hiQuran",
                            subject: "hiQuran App",
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      ProfileItem(
                        icon: UniconsLine.feedback,
                        title: "Give Feedback",
                        onPressed: () {
                          Wiredash.of(context)?.show();
                        },
                      ),
                      const SizedBox(height: 40),
                      if (_userController.user.email == null)
                        MyButton(
                          width: MediaQuery.of(context).size.width,
                          text: "Sign In",
                          onPressed: () => Get.to(SignInPage()),
                        )
                      else
                        MyOutlinedButton(
                          text: "Sign Out",
                          isLoading: _state.isLoading.value,
                          onPressed: () {
                            _state.isLoading(true);
                            _authController.signOut().then((value) {
                              _userController.setUser(User());
                              _state.isLoading(false);

                              Get.snackbar(
                                "Waah",
                                "You are logout",
                                duration: const Duration(seconds: 1),
                              );
                              Future.delayed(
                                const Duration(seconds: 1),
                                () => Get.offAll(Wrapper()),
                              );
                            });
                          },
                        ),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onPressed;
  const ProfileItem(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: AppCard(
        hMargin: 0,
        vPadding: 10,
        radius: 15,
        color: settingController.isDarkMode.value
            ? Theme.of(context).cardColor
            : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: AppTextStyle.normal,
            ),
            const Spacer(),
            Icon(
              UniconsLine.arrow_right,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
