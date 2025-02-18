class ReadingBookCaseRequest {
  String bookDataId;
  String uid;
  String chapterName;
  DateTime readingDate;
  double positionReading;

  ReadingBookCaseRequest({
    this.bookDataId = "",
    this.uid = "",
    this.chapterName = "",
    DateTime? readingDate,
    this.positionReading = 0.0,
  }) : readingDate = readingDate ?? DateTime.now();

  factory ReadingBookCaseRequest.fromJson(Map<String, dynamic> json) {
    return ReadingBookCaseRequest(
      bookDataId: json['bookDataId'] as String,
      uid: json['uid'] as String,
      chapterName: json['chapterName'] as String,
      readingDate: DateTime.parse(json['readingDate'] as String),
      positionReading: (json['positionReading'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookDataId': bookDataId,
      'uid': uid,
      'chapterName': chapterName,
      'readingDate': readingDate.toIso8601String(),
      'positionReading': positionReading,
    };
  }
}
