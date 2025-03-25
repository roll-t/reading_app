class ChapterNovelModel {
  final String chapterId;
  String chapterName;
  String chapterTitle;
  String chapterContent;
  DateTime createAt;
  String bookDataId;

  // Constructor
  ChapterNovelModel({
    this.chapterId = "",
    this.chapterName = "none",
    this.chapterTitle = "none",
    this.chapterContent = "none",
    DateTime? createAt,
    this.bookDataId = "",
  }) : createAt = createAt ?? DateTime.now();

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
