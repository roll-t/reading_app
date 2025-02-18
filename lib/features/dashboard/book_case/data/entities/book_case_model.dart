class BookCaseModel {
  final int? readingBookCaseID;
  final String? bid;
  final String title;
  final String imageUrl;
  final String? subtitle;
  final String? description;
  final DateTime? readDate;
  final String? chapterName;

  BookCaseModel({
    this.readingBookCaseID,
    this.bid,
    required this.title,
    required this.imageUrl,
    this.subtitle,
    this.description,
    this.readDate,
    this.chapterName,
  });

  // Phương thức từ JSON
  factory BookCaseModel.fromJson(Map<String, dynamic> json) {
    return BookCaseModel(
        readingBookCaseID: json["readingBookCaseID"],
        bid: json['bid'],
        title: json['title'],
        imageUrl: json['imageUrl'],
        subtitle: json['subtitle'],
        description: json['description'],
        readDate: json['readDate'],
        chapterName: json['chapterName']);
  }

  // Phương thức sang JSON
  Map<String, dynamic> toJson() {
    return {
      "readingBookCaseID": readingBookCaseID,
      'bid': bid,
      'title': title,
      'imageUrl': imageUrl,
      'subtitle': subtitle,
      'description': description,
      "chapterName": chapterName
    };
  }
}
