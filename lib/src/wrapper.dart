import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/src/app.dart';
import 'package:quran_app/src/profile/controllers/auth_controller.dart';
import 'package:quran_app/src/profile/controllers/user_controller.dart';
import 'package:quran_app/src/settings/controller/settings_controller.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  final _authController = Get.put(AuthControllerImpl());
  final _settingC = Get.put(SettingsController());
  final userC = Get.put(UserControllerImpl());

  Future<void> _sessionCheck() async {
    await GetStorage.init();
    final box = Get.find<GetStorage>();

    final themeColor = box.read('themeColor');

    log("Theme Color : $themeColor");
    if (themeColor != null) {
      _settingC.setTheme(themeColor);
    }

    await Future.delayed(const Duration(seconds: 2));

    final session = box.read('user');
    log("Session : $session");
    if (session == null || session == "") {
      // Get.off(() => SurahPage());
      Get.off(() => const MainPage());
    } else {
      final res = await _authController.recoverSession(session);
      await box.write('user', res?.persistSessionString);
      userC.loadUser(res?.user?.email).then((value) {
        log(value.user.toString());
        log(value.error.toString());

        // if (value.user == null && value.error == "Email not registered") {
        //   Get.off(SignUpPage());
        // } else {
        // Get.off(SurahPage());
        Get.off(() => const MainPage());

        // }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.wait([_sessionCheck()]);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(flex: 3),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [AppShadow.card],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/icon/icon.png",
                  width: 100,
                ),
              ),
            ),
            // const SizedBox(height: 20),
            const Spacer(flex: 3),
            Text(
              "hiQuran",
              style: AppTextStyle.bigTitle,
            ),
            // DottedCircularProgressIndicatorFb(
            //   currentDotColor:
            //       Theme.of(context).primaryColor.withOpacity(0.3),
            //   defaultDotColor: Theme.of(context).primaryColor,
            //   numDots: 9,
            // ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
