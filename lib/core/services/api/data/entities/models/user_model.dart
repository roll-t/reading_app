import 'package:reading_app/core/services/api/data/entities/models/role_model.dart';

class UserModel {
  String? uid;
  String? displayName;
  String email;
  String? password;
  String? photoURL;
  DateTime? creationTime;
  List<RoleModel>? roles;

  UserModel({
    this.uid,
    this.displayName,
    required this.email,
    this.password,
    this.photoURL,
    this.creationTime,
    this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String,
      password: json['password'] as String?,
      photoURL: json['photoURL'] as String?,
      creationTime: json['creationTime'] != null
          ? DateTime.parse(json['creationTime'] as String)
          : null,
      roles: json['roles'] != null
          ? (json['roles'] as List<dynamic>)
              .map((item) => RoleModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'password': password,
      'photoURL': photoURL,
      'creationTime': creationTime?.toIso8601String(),
      'roles': roles?.map((role) => role.toJson()).toList(),
    };
  }
}

