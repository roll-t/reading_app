import 'package:reading_app/core/service/data/model/chapter_novel_model.dart';

class NovelArgumentModel {
  final String bookId;
  final double? positionReading;
  final ChapterNovelModel chapterCurrent;
  final List<ChapterNovelModel> listChapter;

  NovelArgumentModel({
    required this.bookId,
    required this.chapterCurrent,
    required this.listChapter,
    this.positionReading,
  });

  /// Converts a JSON object to a [NovelArgumentModel] instance.
  factory NovelArgumentModel.fromJson(Map<String, dynamic> json) {
    return NovelArgumentModel(
      bookId: json['bookId'] as String,
      chapterCurrent: ChapterNovelModel.fromJson(json['chapterCurrent']),
      listChapter: (json['listChapter'] as List<dynamic>?)
              ?.map((chapter) => ChapterNovelModel.fromJson(chapter))
              .toList() ??
          [],
    );
  }

  /// Converts the [NovelArgumentModel] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'chapterCurrent': chapterCurrent.toJson(),
      'listChapter': listChapter.map((chapter) => chapter.toJson()).toList(),
    };
  }

  /// Creates a copy of the current instance with optional updated fields.
  NovelArgumentModel copyWith({
    String? bookId,
    double? positionReading,
    ChapterNovelModel? chapterCurrent,
    List<ChapterNovelModel>? listChapter,
  }) {
    return NovelArgumentModel(
      bookId: bookId ?? this.bookId,
      positionReading: positionReading ?? this.positionReading,
      chapterCurrent: chapterCurrent ?? this.chapterCurrent,
      listChapter: listChapter ?? this.listChapter,
    );
  }

  /// Returns a string representation of the model.
  @override
  String toString() {
    return 'NovelArgumentModel(bookId: $bookId, positionReading: $positionReading, chapterCurrent: $chapterCurrent, listChapter: $listChapter)';
  }
}
