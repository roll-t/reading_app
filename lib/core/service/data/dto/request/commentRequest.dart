// ignore: file_names
class CommentRequest {
  final String userId;
  final String content;
  String? chapterId;

  CommentRequest({required this.userId, required this.content, this.chapterId});

  // Chuyển đổi từ JSON sang CommentRequest
  factory CommentRequest.fromJson(Map<String, dynamic> json) {
    return CommentRequest(
        userId: json['userId'],
        content: json['content'],
        chapterId: json["chapterId"]);
  }

  // Chuyển đổi từ CommentRequest sang JSON
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'content': content, "chapterId": chapterId};
  }
}
