
class ChapterNovelModel {
  final String chapterId;
  final String chapterName;
  final String chapterTitle;
  final String chapterContent;
  final DateTime createAt;
  final String bookDataId;

  // Constructor
  ChapterNovelModel({
    required this.chapterId,
    required this.chapterName,
    required this.chapterTitle,
    required this.chapterContent,
    required this.createAt,
    required this.bookDataId,
  });

  // Factory constructor để chuyển đổi từ JSON
  factory ChapterNovelModel.fromJson(Map<String, dynamic> json) {
    return ChapterNovelModel(
      chapterId: json['chapterId'] as String,
      chapterName: json['chapterName'] as String,
      chapterTitle: json['chapterTitle'] as String,
      chapterContent: json['chapterContent'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
      bookDataId: json['bookDataId'] as String,
    );
  }

  // Phương thức để chuyển đổi sang JSON
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
