import 'package:get/get.dart';

class GlobalState extends GetxController {
  var isLoading = false.obs;
  var isLoadingGoogle = false.obs;
  var isSubmitted = false.obs;
  var isObscure = true.obs;
  var isOpen = false.obs;

  var emailError = "".obs;
  var passwordError = "".obs;
  var emailText = "".obs;
  var passwordText = "".obs;

  String? validateEmail() {
    final text = emailText.value;
    if (text.isEmpty) {
      emailError("Email can't be empty");
      return emailError.value;
    }

    if (!GetUtils.isEmail(text)) {
      emailError("Email is not valid");
      return emailError.value;
    }

    return null;
  }

  String? validatePassword() {
    final text = passwordText.value;
    if (text.isEmpty) {
      passwordError("Password can't be empty");
      return passwordError.value;
    }

    if (text.length < 6) {
      passwordError("Password too short, at least 6 characters");
      return passwordError.value;
    }

    passwordError("");
    return null;
  }
}
