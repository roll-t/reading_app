import 'package:reading_app/core/services/api/data/entities/dto/request/commentRequest.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/commentReponse.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/network/api_endpoint.dart';
import 'package:reading_app/core/services/network/api_service.dart';

class CommentService extends ApiService {
  CommentService(super.dioConfig, super.cacheService);


  Future<Result<CommentResponse>> addComment(
      {required CommentRequest request, required bookId}) async {
    final body = request.toJson();
    return await post(
        endpoint: EndPointSetting.addComment(bookId: bookId),
        parse: (data) => CommentResponse.fromJson(data),
        data: body);
  }

  Future<Result<List<CommentResponse>>> fetchAllCommentByChapterId(
      {required String chapterId, int page = 0}) async {
    return await get(
      endpoint:
          '${EndPointSetting.getAllCommentByChapterId(chapterId: chapterId)}?page=$page',
      parse: (data) => (data as List<dynamic>)
          .map((item) => CommentResponse.fromJson(item))
          .toList(),
    );
  }

  Future<Result<List<CommentResponse>>> fetchAllComment(
      {required String bookId}) async {
    return await get(
        endpoint: EndPointSetting.getAllCommentByBookId(bookId: bookId),
        parse: (data) => (data as List<dynamic>)
            .map((items) => CommentResponse.fromJson(items))
            .toList());
  }

  Future<Result<bool>> deleteReadingComment({required String commentId}) async {
    return await delete(
        endpoint: EndPointSetting.deleteComment(cmId: commentId),
        parse: (data) => data);
  }
}
