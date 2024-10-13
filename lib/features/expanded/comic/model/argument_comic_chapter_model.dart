class ArgumentComicChapterModel {
  final dynamic currentChapter;
  final List<dynamic> listChapter;

  ArgumentComicChapterModel({
    required this.currentChapter,
    required this.listChapter,
  });

  factory ArgumentComicChapterModel.fromJson(Map<String, dynamic> json) {
    return ArgumentComicChapterModel(
      currentChapter: json['currentChapter'] as dynamic,
      listChapter: List<dynamic>.from(json['listChapter']),
    );
  }

  // Phương thức toJson để chuyển đổi sang JSON
  Map<String, dynamic> toJson() {
    return {
      'currentChapter': currentChapter,
      'listChapter': listChapter,
    };
  }
}
