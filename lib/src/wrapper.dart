import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/bricks/my_widgets/dotted_loading_indicator.dart';
import 'package:quran_app/src/home/view/home_page.dart';
import 'package:quran_app/src/profile/controller/auth_controller.dart';
import 'package:quran_app/src/profile/controller/user_controller.dart';
import 'package:quran_app/src/quran/view/surah_page.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  final _authController = Get.put(AuthControllerImpl());
  final userC = Get.put(UserControllerImpl());

  void _sessionCheck() async {
    await GetStorage.init();
    final box = Get.find<GetStorage>();
    final session = box.read('user');
    log("Session : $session");
    if (session == null || session == "") {
      // Get.off(SignInPage());
      Get.offAll(SurahPage());
    } else {
      final res = await _authController.recoverSession(session);
      await box.write('user', res?.persistSessionString);
      userC.loadUser(res?.user?.email).then((value) {
        log(value.user.toString());
        log(value.error.toString());

        // if (value.user == null && value.error == "Email not registered") {
        //   Get.off(SignUpPage());
        // } else {
        Get.offAll(SurahPage());
        // }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => _sessionCheck(),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [AppShadow.card],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/icon/icon.png",
                  width: 120,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "hiQuran",
              style: AppTextStyle.bigTitle,
            ),
            const Spacer(flex: 2),
            DottedCircularProgressIndicatorFb(
              currentDotColor: Theme.of(context).primaryColor.withOpacity(0.3),
              defaultDotColor: Theme.of(context).primaryColor,
              numDots: 9,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
