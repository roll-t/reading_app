class CommentComicRequest {
  final String comicId;
  final String userId;
  final String content;

  CommentComicRequest({
    required this.comicId,
    required this.userId,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'comicId': comicId,
      'userId': userId,
      'content': content,
    };
  }
}
