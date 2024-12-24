class UserUpdateRequestModel {
  String? displayName;
  String? password;
  String? photoURL;
  List<String>? roles;

  UserUpdateRequestModel({
    this.displayName,
    this.password,
    this.photoURL,
    List<String>? roles,
  }) : roles = roles ?? ['USER'];


  factory UserUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    return UserUpdateRequestModel(
      displayName: json['displayName'],
      password: json['password'],
      photoURL: json['photoURL'],
      roles: json['roles'] != null
          ? List<String>.from(json['roles'])
          : ['USER'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'password': password,
      'photoURL': photoURL,
      'roles': roles,
    };
  }
}
