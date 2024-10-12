class IntrospectRequest {
  final String token;

  IntrospectRequest({required this.token});

  Map<String, dynamic> toJson() {
    return {"token": token};
  }
}
