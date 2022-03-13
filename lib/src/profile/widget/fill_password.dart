import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:quran_app/bricks/my_widgets/input_text.dart';
import 'package:quran_app/bricks/my_widgets/my_button.dart';
import 'package:quran_app/src/profile/controller/auth_controller.dart';
import 'package:quran_app/src/profile/controller/user_controller.dart';
import 'package:quran_app/src/profile/model/user.dart';
import 'package:quran_app/src/profile/view/upload_avatar_page.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:unicons/unicons.dart';

import '../../../helper/global_state.dart';

class FillPassword extends StatelessWidget {
  final User? googleUser;
  FillPassword(this.googleUser, {Key? key}) : super(key: key);
  final _textC = TextEditingController();
  final _state = Get.put(GlobalState());
  final _authController = Get.find<AuthControllerImpl>();
  final _userController = Get.find<UserControllerImpl>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              UniconsLine.lock_access,
              size: 90,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Create your password to \nsecure your account",
            style: AppTextStyle.normal.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Obx(
            () => InputText(
              textController: _textC,
              hintText: "Fill your password",
              errorText: _state.passwordError.isNotEmpty
                  ? _state.passwordError.value
                  : null,
              prefixIcon: Icon(
                IconlyLight.password,
                color: Theme.of(context).primaryColor,
              ),
              suffixIcon: IconButton(
                onPressed: () => _state.isObscure(!_state.isObscure.value),
                icon: Icon(
                  _state.isObscure.isTrue ? IconlyLight.hide : IconlyLight.show,
                  color: Colors.grey,
                ),
              ),
              obsureText: _state.isObscure.value,
              onChanged: (v) {
                if (v.isEmpty) {
                  _state.passwordError("");
                }
                _state.passwordText(v);
              },
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => MyButton(
              text: "Continue",
              width: MediaQuery.of(context).size.width,
              isLoading: _state.isLoadingGoogle.value,
              onPressed: _state.passwordText.value.isEmpty
                  ? null
                  : () {
                      final pass = _state.validatePassword();
                      if (pass == null) {
                        if (_state.passwordText.value.isNotEmpty) {
                          log("Password Text betul kosong? : ${_state.passwordText.value.isEmpty}");
                          signUp();
                        }
                      }
                    },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  signUp() async {
    _state.isLoadingGoogle(true);

    final newUser = await _authController.signUp(
      googleUser!.email.toString(),
      _state.passwordText.value,
      name: googleUser?.name,
      photoUrl: googleUser?.photoUrl,
    );

    if (newUser.error != null) {
      _state.isLoadingGoogle(false);
      Get.back();
      Get.snackbar("Opps...", newUser.error.toString());
    } else {
      _userController.loadUser(newUser.user?.email).then((value) {
        _state.isLoadingGoogle(false);
        Get.offAll(UploadAvatarPage());
      });
    }
  }
}
