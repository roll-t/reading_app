import 'dart:convert';

class RoleModel {
  final String token;
  final bool authenticated;

  RoleModel({
    required this.token,
    required this.authenticated,
  });

  // Tạo một đối tượng RoleModel từ một JSON Map
  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      token: json['token'] as String,
      authenticated: json['authenticated'] as bool,
    );
  }

  // Chuyển đổi RoleModel thành JSON Map
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'authenticated': authenticated,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}