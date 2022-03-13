import 'package:equatable/equatable.dart';

class User extends Equatable {
  int? id;
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  String? avatarUrl;
  String? bio;

  User(
      {this.uid,
      this.id,
      this.name,
      this.email,
      this.photoUrl,
      this.avatarUrl,
      this.bio});

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        photoUrl,
        avatarUrl,
        bio,
        uid,
      ];

  factory User.fromJson(Map<String, dynamic> json) {
    var user = User();
    user.id = json['id'];
    user.uid = json['uuid'];
    user.name = json['name'];
    user.email = json['email'];
    user.photoUrl = json['photo_url'];
    user.avatarUrl = json['avatar_url'];
    user.bio = json['bio'];
    return user;
  }
}
