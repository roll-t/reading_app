import 'package:reading_app/core/configs/end_point_config.dart';
import 'package:reading_app/core/service/api/api_service.dart';
import 'package:reading_app/core/service/data/dto/request/comment_comic_request.dart';
import 'package:reading_app/core/service/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/service/data/model/result.dart';

class CommentComicService extends ApiService {
  CommentComicService(super.dioConfig, super.cacheService);


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
