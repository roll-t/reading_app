import 'package:reading_app/core/services/api/data/entities/dto/request/comment_comic_request.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/commentReponse.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/network/api_endpoint.dart';
import 'package:reading_app/core/services/network/api_service.dart';

class CommentComicService extends ApiService {
  CommentComicService(super.dioConfig, super.cacheService);


  Future<Result<CommentResponse>> addComment(
      {required CommentComicRequest request}) async {
    final body = request.toJson();
    return await post(
        endpoint: EndPointSetting.addCommentComic,
        parse: (data) => CommentResponse.fromJson(data),
        data: body);
  }

  Future<Result<List<CommentResponse>>> fetchAllComment(
      {required String bookId}) async {
    return await get(
        endpoint: EndPointSetting.getAllCommentComicByBookId(bookId: bookId),
        parse: (data) => (data as List<dynamic>)
            .map((items) => CommentResponse.fromJson(items))
            .toList());
  }

  Future<Result<bool>> deleteReadingComment({required String commentId}) async {
    return await delete(
        endpoint: EndPointSetting.deleteCommentComic(cmId: commentId),
        parse: (data) => data);
  }
}
