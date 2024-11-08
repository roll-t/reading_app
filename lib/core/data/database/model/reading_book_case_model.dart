import 'package:uuid/uuid.dart';

class ReadingComicBookCaseModel {
  String id;  // Change id to String to store UUIDs
  String bookDataId;
  String slug;
  String uid;
  String chapterName;
  String chapterApiData;
  String readingDate;
  double positionReading;
  String thumbUrl;
  String comicName;

  // Constructor
  ReadingComicBookCaseModel({
    String? id,
    required this.bookDataId,
    required this.slug,
    required this.uid,
    required this.chapterName,
    required this.chapterApiData,
    required this.readingDate,
    required this.positionReading,
    required this.thumbUrl,
    required this.comicName,
  }) : id = id ?? const Uuid().v4();  // Generate a new UUID if id is not provided

  // Convert the model to a Map for inserting into the database
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookDataId': bookDataId,
      'slug': slug,
      'uid': uid,
      'chapterName': chapterName,
      'chapterApiData': chapterApiData,
      'readingDate': readingDate,
      'positionReading': positionReading,
      'thumbUrl': thumbUrl,
      'comicName': comicName,
    };
  }

  // Create a ReadingComicBookCaseModel from a Map
  factory ReadingComicBookCaseModel.fromMap(Map<String, dynamic> map) {
    return ReadingComicBookCaseModel(
      id: map['id'],
      bookDataId: map['bookDataId'],
      slug: map['slug'],
      uid: map['uid'],
      chapterName: map['chapterName'],
      chapterApiData: map['chapterApiData'],
      readingDate: map['readingDate'],
      positionReading: map['positionReading'],
      thumbUrl: map['thumbUrl'],
      comicName: map['comicName'],
    );
  }
}
