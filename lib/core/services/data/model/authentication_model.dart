import 'dart:convert';

class AuthenticationModel {
  final String token;
  final bool authenticated;

  AuthenticationModel({
    required this.token,
    required this.authenticated,
  });

  // Tạo một đối tượng AuthenticationModel từ một JSON Map
  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      token: json['token'] as String,
      authenticated: json['authenticated'] as bool,
    );
  }

  // Chuyển đổi AuthenticationModel thành JSON Map
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