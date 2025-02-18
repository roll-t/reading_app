import 'package:reading_app/core/services/api/data/entities/models/user_model.dart';

class CommentBottomSheetModel {
  UserModel? userModel;
  String? commentContent;
  String? bookTitle;
  String? chapterName;
  DateTime? commentTime;
  String? photoUrl;

  // Constructor
  CommentBottomSheetModel(
      {this.userModel,
      this.commentContent,
      this.bookTitle,
      this.chapterName,
      this.commentTime,
      this.photoUrl});

  // fromJson factory method
  factory CommentBottomSheetModel.fromJson(Map<String, dynamic> json) {
    return CommentBottomSheetModel(
      userModel: json['userModel'] != null
          ? UserModel.fromJson(json['userModel'])
          : null,
      commentContent: json['commentContent'] as String?,
      bookTitle: json['bookTitle'] as String?,
      chapterName: json['chapterName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      commentTime: json['commentTime'] != null
          ? DateTime.parse(json['commentTime'] as String)
          : null,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'userModel': userModel?.toJson(),
      'commentContent': commentContent,
      'bookTitle': bookTitle,
      'chapterName': chapterName,
      'photoUrl': photoUrl,
      'commentTime': commentTime?.toIso8601String(),
    };
  }
}
