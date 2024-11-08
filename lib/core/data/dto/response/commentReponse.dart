// ignore: file_names
class CommentResponse {
  final String commentId;
  final User user;
  final String content;
  final DateTime createdAt;

  CommentResponse({
    required this.commentId,
    required this.user,
    required this.content,
    required this.createdAt,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      commentId: json['commentId'],
      user: User.fromJson(json['user']),
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'user': user.toJson(),
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class User {
  final String uid;
  final String? displayName;
  final String email;
  final String? photoURL;
  final String? creationTime;
  final List<Role> roles;

  User({
    required this.uid,
    this.displayName,
    required this.email,
    this.photoURL,
    this.creationTime,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      photoURL: json['photoURL'],
      creationTime: json['creationTime'],
      roles: (json['roles'] as List<dynamic>)
          .map((role) => Role.fromJson(role))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
      'creationTime': creationTime,
      'roles': roles.map((role) => role.toJson()).toList(),
    };
  }
}

class Role {
  final String name;
  final String description;
  final List<Permission> permissions;

  Role({
    required this.name,
    required this.description,
    required this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      name: json['name'],
      description: json['description'],
      permissions: (json['permissions'] as List<dynamic>)
          .map((perm) => Permission.fromJson(perm))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'permissions': permissions.map((perm) => perm.toJson()).toList(),
    };
  }
}

class Permission {
  final String name;
  final String description;

  Permission({
    required this.name,
    required this.description,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
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
