import 'dart:developer';
import 'dart:io' as i;

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:quran_app/bricks/my_widgets/my_button.dart';
import 'package:quran_app/bricks/my_widgets/my_circle_avatar.dart';
import 'package:quran_app/bricks/my_widgets/input_text.dart';
import 'package:quran_app/src/home/view/home_page.dart';
import 'package:quran_app/src/profile/controller/user_controller.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

import '../../../helper/global_state.dart';

class ConfirmAccountPage extends StatelessWidget {
  ConfirmAccountPage({Key? key}) : super(key: key);

  final _usernameC = TextEditingController();
  // final userController = Get.put(UserControllerImpl());
  final userController = Get.find<UserControllerImpl>();
  // final _state = Get.put(GlobalState());
  final _state = Get.find<GlobalState>();

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    // _usernameC.selection = TextSelection.fromPosition(
    //   TextPosition(offset: _usernameC.text.length),
    // );
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: ColorPalletes.bgDarkColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Text(
                "Confirm \nYour Account",
                style: AppTextStyle.bigTitle.copyWith(
                  // fontSize: ,
                  color: settingController.isDarkMode.value
                      ? Theme.of(context).primaryColor
                      : ColorPalletes.bgDarkColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Obx(() {
                if (userController.fileImage.value.path.isNotEmpty) {
                  return MyCircleAvatar(
                    primaryColor: primaryColor,
                    image: FileImage(
                      userController.fileImage.value,
                    ),
                  );
                } else if (userController.copiedText.isNotEmpty &&
                    userController.user.photoUrl == null) {
                  // state avatar
                  return Container(
                    width: size.width,
                    height: size.height * 0.25,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ModelViewer(
                        src: userController.copiedText.value,
                        autoRotate: true,
                        cameraControls: true,
                        backgroundColor: Theme.of(context).backgroundColor,
                        alt: "A 3D model of user avatar",
                        ar: true,
                      ),
                    ),
                  );
                } else if (userController.user.avatarUrl == null &&
                    userController.user.photoUrl != null) {
                  // state photo
                  return MyCircleAvatar(
                    primaryColor: primaryColor,
                    image: NetworkImage(
                      userController.user.photoUrl.toString(),
                    ),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.grey,
                    ),
                  );
                }
              }),
              const SizedBox(height: 20),
              Obx(() {
                if (userController.user.name != null &&
                    userController.username.value.isEmpty) {
                  return Text(
                    userController.user.name.toString(),
                    style: AppTextStyle.title.copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  );
                } else if (userController.user.name != null &&
                    userController.username.value.isNotEmpty) {
                  return Text(
                    userController.user.name.toString(),
                    style: AppTextStyle.title.copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  );
                } else {
                  return Text(
                    userController.username.value == ""
                        ? "Hamba Allah"
                        : userController.username.value,
                    style: AppTextStyle.title.copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  );
                }
              }),
              const SizedBox(height: 4),
              Obx(
                () => Text(
                  userController.user.email.toString(),
                  style: AppTextStyle.normal.copyWith(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(),
              const SizedBox(height: 30),
              Text(
                "create your username \nor keep anonymous",
                style: AppTextStyle.normal.copyWith(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              InputText(
                textController: _usernameC,
                hintText: "Username",
                prefixIcon: Icon(
                  IconlyLight.edit,
                  color: primaryColor,
                ),
                maxLength: 25,
                onChanged: (v) {
                  userController.username.value = v;
                  userController.setUsername(v);
                  if (v.isEmpty) {
                    userController.setUsername("Hamba Allah");
                  }
                },
              ),
              const SizedBox(height: 40),
              Obx(
                () => MyButton(
                  text: "Create My Account",
                  isLoading: _state.isLoading.value,
                  onPressed: () => completedCreateAccount(),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void completedCreateAccount() async {
    _state.isLoading.value = true;
    if (userController.fileImage.value.path.isNotEmpty) {
      final res = await userController.uploadPhoto();
      if (!res) {
        _state.isLoading.value = false;
        Get.snackbar("Opps...", "Failed to upload image");
      }
    }

    final result = await userController.updateUser();
    if (result.error != null) {
      _state.isLoading.value = false;
      Get.snackbar("Opps...", "${result.error}");
    } else {
      log("User State : ${userController.user}");

      _state.isLoading.value = false;
      Get.snackbar("Woo hoo..", "Your successfully to create account");
      Get.offAll(HomePage());
      userController.fileImage.value = i.File("");
      userController.copiedText.value = "";
      userController.username.value = "";
    }
  }
}
