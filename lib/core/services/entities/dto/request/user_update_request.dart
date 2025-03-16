class UserUpdateRequest {
  String? displayName;
  String? password;
  String? photoURL;
  List<String>? roles;

  UserUpdateRequest({
    this.displayName,
    this.password,
    this.photoURL,
    List<String>? roles,
  }) : roles = roles ?? ['USER'];


  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) {
    return UserUpdateRequest(
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
