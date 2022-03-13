import 'package:quran_app/src/profile/model/user.dart' as model;

abstract class ResultFormatter {
  final String? error;

  ResultFormatter(this.error);
}

class UserResultFormatter extends ResultFormatter {
  final model.User? user;

  UserResultFormatter(this.user, String? error) : super(error);
}

class UploadResultFormatter extends ResultFormatter {
  final String? result;

  UploadResultFormatter(String? error, this.result) : super(error);
}
