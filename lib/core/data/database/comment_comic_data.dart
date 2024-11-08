import 'package:reading_app/core/data/database/model/result.dart';
import 'package:reading_app/core/data/dto/request/comment_comic_request.dart';
import 'package:reading_app/core/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/data/service/configs/end_point_setting.dart';
import 'package:reading_app/core/data/service/core_service.dart';

class CommentComicData extends CoreService {
  CommentComicData._privateConstructor();
  static final CommentComicData _instance =
      CommentComicData._privateConstructor();
  factory CommentComicData() {
    return _instance;
  }

  Future<Result<CommentResponse>> addComment(
      {required CommentComicRequest request}) async {
    final body = request.toJson();
    return await postData(
        endpoint: EndPointSetting.addCommentComic,
        parse: (data) => CommentResponse.fromJson(data),
        data: body);
  }

  Future<Result<List<CommentResponse>>> fetchAllComment(
      {required String bookId}) async {
    return await fetchData(
        endpoint: EndPointSetting.getAllCommentComicByBookId(bookId: bookId),
        parse: (data) => (data as List<dynamic>)
            .map((items) => CommentResponse.fromJson(items))
            .toList());
  }

  Future<Result<bool>> deleteReadingComment({required String commentId}) async {
    return await deleteData(
        endpoint: EndPointSetting.deleteCommentComic(cmId: commentId),
        parse: (data) => data);
  }
}
