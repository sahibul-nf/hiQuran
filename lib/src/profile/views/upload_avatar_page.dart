import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:quran_app/bricks/my_widgets/dotted_loading_indicator.dart';
import 'package:quran_app/bricks/my_widgets/my_button.dart';
import 'package:quran_app/bricks/my_widgets/my_circle_avatar.dart';
import 'package:quran_app/bricks/my_widgets/my_outline_button.dart';
import 'package:quran_app/src/profile/controllers/user_controller.dart';
import 'package:quran_app/src/profile/views/confirm_account_page.dart';
import 'package:quran_app/src/profile/widgets/paste_avatarurl.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:unicons/unicons.dart';

import '../../../helper/global_state.dart';

class UploadAvatarPage extends StatelessWidget {
  UploadAvatarPage({Key? key}) : super(key: key);

  final userController = Get.put(UserControllerImpl());
  final _state = Get.put(GlobalState());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                "Pick a photo or Create a avatar \nto get better experience",
                style: AppTextStyle.normal.copyWith(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),

              Obx(
                () {
                  if (_state.isLoading.value) {
                    return DottedCircularProgressIndicatorFb(
                      currentDotColor: Theme.of(context).primaryColor,
                      defaultDotColor: Colors.grey,
                      numDots: 9,
                      dotSize: 4,
                    );
                  } else {
                    if (userController.user.photoUrl == null &&
                        userController.copiedText.isNotEmpty) {
                      log(userController.copiedText.value);
                      // state used avatar
                      return Column(
                        children: [
                          Container(
                            width: size.width,
                            height: size.height * 0.4,
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: ModelViewer(
                                src: userController.copiedText.value,
                                // src: userController.copiedText.value,
                                autoRotate: true,
                                cameraControls: true,
                                // backgroundColor: theme.primaryColor,
                                alt: "A 3D model of user avatar",
                                // ar: true,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              userController.pickImage();
                            },
                            child: Text(
                              "Change photo",
                              style: AppTextStyle.small,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    } else if (userController.user.avatarUrl == null &&
                        userController.user.photoUrl != null) {
                      // state photo available
                      if (userController.fileImage.value.path.isNotEmpty ||
                          userController.copiedText.value.isNotEmpty) {
                        return Column(
                          children: [
                            MyCircleAvatar(
                              primaryColor: theme.primaryColor,
                              image: FileImage(
                                userController.fileImage.value,
                              ),
                            ),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () {
                                userController.pickImage();
                              },
                              child: Text(
                                "Change photo",
                                style: AppTextStyle.small,
                              ),
                            )
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            MyCircleAvatar(
                              primaryColor: theme.primaryColor,
                              image: NetworkImage(
                                userController.user.photoUrl.toString(),
                              ),
                            ),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () => userController.pickImage(),
                              child: Text(
                                "Change photo",
                                style: AppTextStyle.small,
                              ),
                            )
                          ],
                        );
                      }
                    } else if (userController.user.avatarUrl == null &&
                        userController.user.photoUrl == null &&
                        userController.fileImage.value.path.isNotEmpty) {
                      return Column(
                        children: [
                          MyCircleAvatar(
                            primaryColor: theme.primaryColor,
                            image: FileImage(
                              userController.fileImage.value,
                            ),
                          ),
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              userController.pickImage();
                            },
                            child: Text(
                              "Change photo",
                              style: AppTextStyle.small,
                            ),
                          )
                        ],
                      );
                    } else {
                      // state photo no available or before taken
                      return InkWell(
                        onTap: () {
                          userController.pickImage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: RDottedLineBorder.all(
                              color: Colors.grey,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 30,
                          ),
                          width: size.width * 0.5,
                          child: Column(
                            children: [
                              const Icon(
                                UniconsLine.image_upload,
                                size: 28,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Pick your photo",
                                style: AppTextStyle.small,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                },
              ),

              const Spacer(),

              MyButton(
                width: size.width,
                text: "Take a photo",
                onPressed: () {
                  userController.takePhoto();
                },
              ),
              const SizedBox(height: 10),
              MyButton(
                width: size.width,
                text: "Create avatar",
                onPressed: () {
                  userController.createAvatar().then((value) => Get.bottomSheet(
                        PasteAvatarUrl(),
                      ));
                },
              ),
              // const Spacer(),
              const SizedBox(height: 40),

              Obx(
                () => MyOutlinedButton(
                  width: size.width,
                  text: (userController.user.photoUrl != null ||
                          userController.user.avatarUrl != null ||
                          userController.fileImage.value.path != "" ||
                          userController.copiedText.isNotEmpty)
                      ? "Continue"
                      : "Skip",
                  onPressed: () {
                    // userController.uploadPhoto();
                    log("User State : ${userController.user}");
                    Get.to(ConfirmAccountPage());
                  },
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
