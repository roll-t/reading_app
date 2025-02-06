import 'package:reading_app/core/extensions/date_time_custom.dart';

class UserRequest {
  String? uid;
  String? displayName;
  String email;
  String ? photoURL;
  String password;
  String creationTime;
  List<String> roles;
  UserRequest({
    this.uid,
    this.displayName,
    required this.email,
    this.password = "0123456",
    this.photoURL,
    this.creationTime = "",
    this.roles = const ["USER"],
  }) {
    if (creationTime.isEmpty) {
      creationTime = DateTimeCustom.currentTime();
    }
  }

  factory UserRequest.fromJson(Map<String, dynamic> json) {
    return UserRequest(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      password: json['password'],
      photoURL: json['photoURL'],
      creationTime: json['creationTime'] ?? DateTimeCustom.currentTime(),
      roles: List<String>.from(json['roles'] ?? ["USER"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'password': password,
      'photoURL': photoURL,
      'creationTime': creationTime,
      'roles': roles,
    };
  }
}
