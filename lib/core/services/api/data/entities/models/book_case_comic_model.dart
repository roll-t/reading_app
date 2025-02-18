// Model cho tủ sách
class BookCaseComicModel {
  final String slug;
  final String thumb;
  final String title;
  final double position; // Vị trí đọc
  final DateTime readingDate; // Ngày đọc
  final String chapterRead; // Chương đọc

  BookCaseComicModel({
    required this.slug,
    required this.thumb,
    required this.title,
    required this.position,
    required this.readingDate,
    required this.chapterRead,
  });

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'thumb': thumb,
      'title': title,
      'position': position,
      'readingDate': readingDate.toIso8601String(),
      'chapterRead': chapterRead,
    };
  }

  factory BookCaseComicModel.fromJson(Map<String, dynamic> json) {
    return BookCaseComicModel(
      slug: json['slug'],
      thumb: json['thumb'],
      title: json['title'],
      position: json['position'],
      readingDate: DateTime.parse(json['readingDate']),
      chapterRead: json['chapterRead'],
    );
  }
}
