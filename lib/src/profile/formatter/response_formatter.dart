import 'package:quran_app/helper/result.dart';
import 'package:quran_app/src/profile/models/user.dart' as model;

class UserResultFormatter extends ResultFormatter {
  final model.User? user;

  UserResultFormatter(this.user, String? error) : super(error);
}

class UploadResultFormatter extends ResultFormatter {
  final String? result;

  UploadResultFormatter(String? error, this.result) : super(error);
}
