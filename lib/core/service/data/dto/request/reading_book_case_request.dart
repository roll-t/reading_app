class ReadingBookCaseRequest {
  String bookDataId;
  String uid;
  String chapterName;
  DateTime readingDate;
  double positionReading;

  ReadingBookCaseRequest({
    required this.bookDataId,
    required this.uid,
    required this.chapterName,
    required this.readingDate,
    required this.positionReading,
  });

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
