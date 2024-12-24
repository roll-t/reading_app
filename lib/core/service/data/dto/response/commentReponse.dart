// ignore: file_names
import 'package:reading_app/core/service/data/model/user_model.dart';

class CommentResponse {
  final String commentId;
  final UserModel user;
  final String content;
  final DateTime createdAt;
  final Chapter? chapter; // Thêm thuộc tính chapter, có thể null

  CommentResponse({
    required this.commentId,
    required this.user,
    required this.content,
    required this.createdAt,
    this.chapter,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      commentId: json['commentId'],
      user: UserModel.fromJson(json['user']),
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      chapter:
          json['chapter'] != null ? Chapter.fromJson(json['chapter']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'user': user.toJson(),
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'chapter': chapter?.toJson(),
    };
  }
}

// Thêm lớp Chapter để xử lý thông tin về chapter
class Chapter {
  final String chapterId;
  final String chapterName;
  final String chapterTitle;
  final String chapterContent;
  final DateTime createAt;
  final String? bookDataId;

  Chapter({
    required this.chapterId,
    required this.chapterName,
    required this.chapterTitle,
    required this.chapterContent,
    required this.createAt,
    this.bookDataId,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      chapterId: json['chapterId'],
      chapterName: json['chapterName'],
      chapterTitle: json['chapterTitle'],
      chapterContent: json['chapterContent'],
      createAt: DateTime.parse(json['createAt']),
      bookDataId: json['bookDataId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chapterId': chapterId,
      'chapterName': chapterName,
      'chapterTitle': chapterTitle,
      'chapterContent': chapterContent,
      'createAt': createAt.toIso8601String(),
      'bookDataId': bookDataId,
    };
  }
}
