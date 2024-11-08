import 'package:reading_app/core/data/database/model/result.dart';
import 'package:reading_app/core/data/dto/request/commentRequest.dart';
import 'package:reading_app/core/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/data/service/configs/end_point_setting.dart';
import 'package:reading_app/core/data/service/core_service.dart';

class CommentData extends CoreService {
  CommentData._privateConstructor();

  static final CommentData _instance = CommentData._privateConstructor();

  factory CommentData() {
    return _instance;
  }

  Future<Result<CommentResponse>> addComment(
      {required CommentRequest request, required bookId}) async {
    final body = request.toJson();
    return await postData(
        endpoint: EndPointSetting.addComment(bookId: bookId),
        parse: (data) => CommentResponse.fromJson(data),
        data: body);
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
