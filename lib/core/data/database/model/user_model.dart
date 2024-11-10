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

class RoleModel {
  final String name;
  final String description;
  final List<PermissionModel> permissions;

  RoleModel({
    required this.name,
    required this.description,
    required this.permissions,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      name: json['name'],
      description: json['description'],
      permissions: (json['permissions'] as List<dynamic>)
          .map((item) => PermissionModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'permissions': permissions.map((e) => e.toJson()).toList(),
    };
  }
}

class PermissionModel {
  final String name;
  final String description;

  PermissionModel({
    required this.name,
    required this.description,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}
