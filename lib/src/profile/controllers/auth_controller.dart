import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quran_app/src/home/view/home_page.dart';
import 'package:quran_app/src/profile/formatter/response_formatter.dart';
import 'package:quran_app/src/profile/models/user.dart' as model;
import 'package:quran_app/src/profile/repositories/user_repository.dart';
import 'package:quran_app/src/profile/views/signin_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../quran/view/surah_page.dart';

abstract class AuthController extends GetxController {
  Future<UserResultFormatter> signUp(
    String email,
    String password, {
    String? name,
    String? photoUrl,
    String? avatarUrl,
  });
  Future<UserResultFormatter> signInWithGoogle();
  Future<Session?> recoverSession(String session);
  Future<UserResultFormatter> signIn(String email, {String? password});
  Future<bool> signOut();
}

class AuthControllerImpl extends AuthController {
  final _supabase = Supabase.instance.client;
  final _userRepo = UserRepositoryImpl();

  // signIn with google
  // get user info like email and name
  // signUp to supabase
  // await supabase.auth.signUp(email, password)
  // save user to db supabase
  @override
  Future<UserResultFormatter> signInWithGoogle() async {
    try {
      var user = model.User();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return UserResultFormatter(null, "Google authentication is canceled");
      } else {
        user.email = googleUser.email;
        user.name = googleUser.displayName;
        user.photoUrl = googleUser.photoUrl;
      }

      return UserResultFormatter(user, null);
    } on PlatformException catch (e) {
      return UserResultFormatter(null, e.message.toString());
    }
  }

  @override
  Future<UserResultFormatter> signUp(String email, String password,
      {String? name, String? photoUrl, String? avatarUrl}) async {
    try {
      final box = Get.find<GetStorage>();

      final res = await _supabase.auth.signUp(email, password);

      if (res.error != null) {
        log("Sign up error: ${res.error}");
        return UserResultFormatter(null, res.error?.message);
      }
      box.write('user', res.data?.persistSessionString);

      final result = await _userRepo.createUser({
        "uuid": res.data?.user!.id,
        "name": name,
        "email": email,
        "photo_url": photoUrl,
        "avatar_url": avatarUrl,
      });

      log("Sign up is successful for user ID: ${result.user?.id}");
      return result;
    } catch (e) {
      log("Sign up error: $e");
      return UserResultFormatter(null, e.toString());
    }
  }

  @override
  Future<Session?> recoverSession(String session) async {
    final res = await _supabase.auth.recoverSession(session);
    if (res.error != null) {
      log("An error occured: ${res.error}");
      return null;
    }

    // TODO: handle this finishing result
    return res.data;
  }

  authStateNow() {
    _supabase.auth.onAuthStateChange((event, session) {
      switch (event) {
        case AuthChangeEvent.signedIn:
          Get.offAll(SurahPage());
          break;
        case AuthChangeEvent.signedOut:
          Get.offAll(SignInPage());
          break;
        default:
      }
    });
  }

  @override
  Future<UserResultFormatter> signIn(String email, {String? password}) async {
    try {
      final res = await _supabase.auth.signIn(email: email, password: password);

      if (res.error != null) {
        log("Sign in error: ${res.error}");
        return UserResultFormatter(null, res.error?.message);
      }

      var loggedInUser = res.data?.user;
      var user = model.User();
      user.email = loggedInUser?.email;
      user.uid = loggedInUser?.id;

      final box = Get.find<GetStorage>();
      box.write('user', res.data?.persistSessionString);

      log("Sign in is successful for user ID: ${res.user?.id}");
      return UserResultFormatter(user, null);
    } catch (e) {
      log("Sign in error: $e");
      return UserResultFormatter(null, e.toString());
    }
  }

  @override
  Future<bool> signOut() async {
    final res = await _supabase.auth.signOut();
    if (res.error != null) {
      log('Log out error: ${res.error!.message}');
      return false;
    }

    final box = Get.find<GetStorage>();

    await box.remove('user');
    await box.erase();
    final session = box.read('user');
    log("Session : $session");

    log('Successfully logged out; clearing session string');
    return true;
  }
}
