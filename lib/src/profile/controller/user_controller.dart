import 'dart:developer';
import 'dart:io' as i;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';
import 'package:quran_app/src/profile/formatter/response_formatter.dart';
import 'package:quran_app/src/profile/model/user.dart' as model;
import 'package:quran_app/src/profile/repository/user_repository.dart';
import 'package:url_launcher/url_launcher.dart' as url;

abstract class UserController extends GetxController {
  Future<UserResultFormatter> loadUser(String? email);
  Future<UserResultFormatter> updateUser();
}

class UserControllerImpl extends UserController {
  final _user = model.User().obs;
  model.User get user => _user.value;
  setUser(model.User value) {
    _user.value = value;
    log("User: ${_user.value}");
  }

  var username = "".obs;
  void setUsername(String value) {
    _user.value.name = value;
    log("User: ${_user.value}");
  }

  void setPhotoUrl(String value) {
    _user.value.photoUrl = value;
    log("User: ${_user.value}");
  }

  void setAvatarUrl(String value) {
    _user.value.avatarUrl = value;
    log("User: ${_user.value}");
  }

  var fileImage = i.File("").obs;

  Future<bool> createAvatar() async {
    var baseUrl = "https://readyplayer.me/avatar";
    final resp = await url.launch(baseUrl);
    return resp;
  }

  var copiedText = "".obs;
  void getClipboardData() async {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      log("Copied Text: ${value?.text}");
      if (value != null) {
        copiedText.value = value.text.toString();
      }
    });
  }

  void pickImage() async {
    List<Media>? res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
    );

    if (res != null) {
      for (var item in res) {
        fileImage.value = i.File(item.path);
        log(item.path);
      }
    }
  }

  void takePhoto() async {
    List<Media>? res = await ImagesPicker.openCamera(
      pickType: PickType.image,
      maxTime: 30,
      cropOpt: CropOption(),
    );
  }

  pickerFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      result.paths;
      fileImage.value = i.File(result.files.first.path.toString());
    } else {
      // User canceled the picker
      log("kosong");
    }
  }

  Future<void> pickImageFromGalery() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        fileImage.value = i.File(file.path);
      }

      log("File path: ${fileImage.value.path}");
    } on PlatformException catch (e) {
      log(e.message.toString());
    }
  }

  // void pickImageFromCamera() async {
  //   XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (file != null) {
  //     fileImage.value = File(file.path);
  //   }
  // }

  @override
  Future<UserResultFormatter> loadUser(String? email) async {
    final userRepo = UserRepositoryImpl();

    final userResult = await userRepo.fetchUser(email);

    if (userResult.error != null) {
      return UserResultFormatter(null, userResult.error);
    } else {
      _user.value = userResult.user!;
      log("User loaded: $user");
      return UserResultFormatter(userResult.user, null);
    }
  }

  @override
  Future<UserResultFormatter> updateUser() async {
    final userRepo = UserRepositoryImpl();

    final userResult = await userRepo.updateUser(
      _user.value.id,
      {
        "name": user.name,
        "photo_url": user.photoUrl,
        "avatar_url": user.avatarUrl,
      },
    );

    if (userResult.error != null) {
      return UserResultFormatter(null, userResult.error);
    } else {
      _user.value = userResult.user!;
      return UserResultFormatter(userResult.user, null);
    }
  }

  Future<bool> uploadPhoto() async {
    final userRepo = UserRepositoryImpl();

    String name = "avatar";
    if (fileImage.value.path.isNotEmpty) {
      name = fileImage.value.path.split("/").last;
    }
    String fileName = _user.value.id.toString() + "-" + name;

    final res =
        await userRepo.uploadFileImage("public/$fileName", fileImage.value);
    if (res.error != null) {
      return false;
    } else {
      setPhotoUrl(res.result.toString());
      return true;
    }
  }
}
