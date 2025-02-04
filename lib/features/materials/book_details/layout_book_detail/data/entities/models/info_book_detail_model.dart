class InfoBookDetailModel {
  final String bookTitle;
  final String thumbImage;
  final double? rating;
  final int? view;
  final String? description;
  final int countChapter;

  InfoBookDetailModel({
    required this.bookTitle,
    required this.thumbImage,
    this.rating,
    this.view,
    this.description,
    required this.countChapter,
  });
}
