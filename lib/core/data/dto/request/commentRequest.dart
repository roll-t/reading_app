// ignore: file_names
class CommentRequest {
  final String userId;
  final String content;

  CommentRequest({
    required this.userId,
    required this.content,
  });

  // Chuyển đổi từ JSON sang CommentRequest
  factory CommentRequest.fromJson(Map<String, dynamic> json) {
    return CommentRequest(
      userId: json['userId'],
      content: json['content'],
    );
  }

  // Chuyển đổi từ CommentRequest sang JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'content': content,
    };
  }
}
