import 'package:reading_app/core/configs/end_point_config.dart';
import 'package:reading_app/core/service/api/api_service.dart';
import 'package:reading_app/core/service/data/dto/request/commentRequest.dart';
import 'package:reading_app/core/service/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/service/data/model/result.dart';

class CommentService extends ApiService {
  CommentService(super.dioConfig, super.cacheService);


  Future<Result<CommentResponse>> addComment(
      {required CommentRequest request, required bookId}) async {
    final body = request.toJson();
    return await postData(
        endpoint: EndPointSetting.addComment(bookId: bookId),
        parse: (data) => CommentResponse.fromJson(data),
        data: body);
  }

  Future<Result<List<CommentResponse>>> fetchAllCommentByChapterId(
      {required String chapterId, int page = 0}) async {
    return await fetchData(
      endpoint:
          '${EndPointSetting.getAllCommentByChapterId(chapterId: chapterId)}?page=$page',
      parse: (data) => (data as List<dynamic>)
          .map((item) => CommentResponse.fromJson(item))
          .toList(),
    );
  }

  Future<Result<List<CommentResponse>>> fetchAllComment(
      {required String bookId}) async {
    return await fetchData(
        endpoint: EndPointSetting.getAllCommentByBookId(bookId: bookId),
        parse: (data) => (data as List<dynamic>)
            .map((items) => CommentResponse.fromJson(items))
            .toList());
  }

  Future<Result<bool>> deleteReadingComment({required String commentId}) async {
    return await deleteData(
        endpoint: EndPointSetting.deleteComment(cmId: commentId),
        parse: (data) => data);
  }
}
