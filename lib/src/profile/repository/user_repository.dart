import 'dart:developer';
// import 'dart:io' as i;
import 'package:universal_io/io.dart' as i;

import 'package:quran_app/src/profile/formatter/response_formatter.dart';
import 'package:quran_app/src/profile/model/user.dart' as model;
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserRepository {
  Future<UserResultFormatter> createUser(dynamic body);
  Future<UserResultFormatter> fetchUser(String? email);
  Future<UserResultFormatter> updateUser(int? id, dynamic body);
  Future<UserResultFormatter> deleteUser(int? id);
  Future<UploadResultFormatter> uploadFileImage(
      String fileName, i.File fileImage);
}

class UserRepositoryImpl implements UserRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<UserResultFormatter> createUser(body) async {
    final res = await supabase.from('Users').insert(body).execute();
    if (res.error != null) {
      return UserResultFormatter(null, res.error?.message);
    }

    Map<String, dynamic> data = res.data[0];
    var user = model.User.fromJson(data);

    return UserResultFormatter(user, null);
  }

  @override
  Future<UserResultFormatter> deleteUser(int? id) async {
    final res = await supabase.from('Users').delete().match(
      {
        'id': id,
      },
    ).execute();

    if (res.error != null) {
      return UserResultFormatter(null, res.error?.message);
    }

    return UserResultFormatter(res.data, null);
  }

  @override
  Future<UserResultFormatter> fetchUser(String? email) async {
    final res =
        await supabase.from('Users').select('*').eq('email', email).execute();
    if (res.error != null) {
      return UserResultFormatter(null, res.error?.message);
    }

    List data = res.data;
    log("User: $data");
    var user = model.User();

    if (data.isEmpty) {
      return UserResultFormatter(null, "Email not registered");
    }

    for (var json in data) {
      user = model.User.fromJson(json);
    }

    return UserResultFormatter(user, null);
  }

  @override
  Future<UserResultFormatter> updateUser(int? id, body) async {
    final res =
        await supabase.from('Users').update(body).match({'id': id}).execute();

    if (res.error != null) {
      return UserResultFormatter(null, res.error?.message);
    }

    var data = res.data;
    log("User: $data");
    var user = model.User();
    for (var json in (data as List)) {
      user = model.User.fromJson(json);
    }

    return UserResultFormatter(user, null);
  }

  @override
  Future<UploadResultFormatter> uploadFileImage(
      String fileName, i.File fileImage) async {
    final res = await supabase.storage.from('assets').upload(
          fileName,
          fileImage,
        );

    if (res.error != null) {
      return UploadResultFormatter(res.error?.message, null);
    }

    // final result =
    //     supabase.storage.from('assets').getPublicUrl(res.data.toString());

    final result = await supabase.storage
        .from('assets')
        .createSignedUrl(fileName, 31557600);

    final signedUrl = result.data;
    log("Signed Bucket Url: $signedUrl");

    if (result.error != null) {
      return UploadResultFormatter(result.error?.message, null);
    }

    return UploadResultFormatter(null, signedUrl);
  }
}
