
class IntrospectResponse {
  final bool valid;

  IntrospectResponse({
    required this.valid,
  });

  // Phương thức tạo đối tượng từ JSON
  factory IntrospectResponse.fromJson(Map<String, dynamic> json) {
    return IntrospectResponse(
      valid: json['valid'] as bool,
    );
  }

  // Phương thức chuyển đối tượng sang JSON
  Map<String, dynamic> toJson() {
    return {
      'valid': valid,
    };
  }
}
