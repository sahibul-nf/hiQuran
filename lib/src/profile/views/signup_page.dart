import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:quran_app/bricks/my_widgets/google_button_1.dart';
import 'package:quran_app/bricks/my_widgets/my_button.dart';
import 'package:quran_app/bricks/my_widgets/input_text.dart';
import 'package:quran_app/src/profile/controllers/auth_controller.dart';
import 'package:quran_app/src/profile/controllers/user_controller.dart';
import 'package:quran_app/src/profile/formatter/response_formatter.dart';
import 'package:quran_app/src/profile/views/signin_page.dart';
import 'package:quran_app/src/profile/views/upload_avatar_page.dart';
import 'package:quran_app/src/profile/widgets/fill_password.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

import '../../../helper/global_state.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();
  final authController = Get.put(AuthControllerImpl());
  final userController = Get.put(UserControllerImpl());
  final _state = Get.put(GlobalState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "hiQuran",
          style: AppTextStyle.bigTitle,
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                "Let's go!",
                style: AppTextStyle.bigTitle.copyWith(
                  fontSize: 28,
                  color: settingController.isDarkMode.value
                      ? Theme.of(context).primaryColor
                      : ColorPalletes.bgDarkColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Create your account and get \ninteresting insigh your activity \non this app",
                style: AppTextStyle.normal.copyWith(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              InputText(
                textController: _emailC,
                hintText: "Email",
                // errorText:
                //     _state.isSubmitted.value ? _state.emailError.value : null,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  IconlyLight.message,
                  color: Theme.of(context).primaryColor,
                ),
                onChanged: (v) {
                  _state.emailText(v);
                },
              ),
              const SizedBox(height: 10),
              Obx(
                () => InputText(
                  textController: _passwordC,
                  hintText: "Password",
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
                      _state.isObscure.isTrue
                          ? IconlyLight.hide
                          : IconlyLight.show,
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
              const SizedBox(height: 30),
              Obx(
                () => MyButton(
                  width: MediaQuery.of(context).size.width,
                  text: "Sign Up",
                  isLoading: _state.isLoading.value,
                  onPressed: () => signUp(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "other options",
                style: AppTextStyle.normal.copyWith(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Obx(
                () => GoogleBtn1(
                  text: "Sign Up",
                  isLoading: _state.isLoadingGoogle.value,
                  onPressed: () => signUpWithGoogle(),
                ),
              ),
              const SizedBox(height: 70),
              Text(
                "Already have an account?",
                style: AppTextStyle.normal.copyWith(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              InkWell(
                onTap: () => Get.off(SignInPage()),
                child: Text(
                  "Sign In Now!",
                  style: AppTextStyle.normal.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    _state.isSubmitted(true);
    final email = _state.validateEmail();
    final pass = _state.validatePassword();
    if (email != null) {
      Get.snackbar("Opps...", email);
      _state.isSubmitted(false);
    } else if (pass != null) {
      Get.snackbar("Opps...", pass);
      _state.isSubmitted(false);
    } else {
      _state.isSubmitted(false);

      _state.isLoading(true);
      authController.signUp(_emailC.text, _passwordC.text).then((value) {
        if (value.error != null) {
          _state.isLoading(false);

          Get.snackbar("Opps...", value.error.toString());
        } else {
          userController.loadUser(value.user?.email).then((value) {
            _state.isLoading(false);
            Get.to(UploadAvatarPage());
          });
        }
      });
    }
  }

  void signUpWithGoogle() async {
    _state.isLoadingGoogle(true);
    UserResultFormatter googleUser = await authController.signInWithGoogle();
    if (googleUser.error != null) {
      _state.isLoadingGoogle(false);
      Get.snackbar("Opps...", googleUser.error.toString());
    } else {
      _state.isLoadingGoogle(false);
      _state.passwordText("");
      Get.bottomSheet(
        FillPassword(googleUser.user),
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
      );
    }
  }
}
