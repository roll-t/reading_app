


class CommentComicResponse {
  final String commentId;
  final String comicId;
  final String userId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  CommentComicResponse({
    required this.commentId,
    required this.comicId,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a CommentComicResponse instance from JSON
  factory CommentComicResponse.fromJson(Map<String, dynamic> json) {
    return CommentComicResponse(
      commentId: json['commentId'] as String,
      comicId: json['comicId'] as String,
      userId: json['userId'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Method to convert CommentComicResponse instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'comicId': comicId,
      'userId': userId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
