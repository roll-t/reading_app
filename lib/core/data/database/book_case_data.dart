import 'package:reading_app/core/data/database/model/result.dart';
import 'package:reading_app/core/data/dto/request/reading_book_case_request.dart';
import 'package:reading_app/core/data/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/data/service/configs/end_point_setting.dart';
import 'package:reading_app/core/data/service/core_service.dart';

class BookCaseData extends CoreService {
  BookCaseData._privateConstructor();

  static final BookCaseData _instance = BookCaseData._privateConstructor();

  factory BookCaseData() {
    return _instance;
  }

  Future<Result<ReadingBookCaseResponse>> postReadingBookCase(
      {required ReadingBookCaseRequest request}) async {
    final body = request.toJson();
    return await postData(
        endpoint: EndPointSetting.addReadingBookCase,
        parse: (data) => ReadingBookCaseResponse.fromJson(data),
        data: body);
  }

  Future<Result<List<ReadingBookCaseResponse>>> fetchAllReadingBookCase(
      {required String uid}) async {
    return await fetchData(
        endpoint: EndPointSetting.getReadingBookCaseWithId(uid: uid),
        parse: (data) => (data as List<dynamic>)
            .map((items) => ReadingBookCaseResponse.fromJson(items))
            .toList());
  }

  Future<Result<bool>> deleteReadingBookCase({required String bcId}) async {
    return await deleteData(
        endpoint: EndPointSetting.deleteBookCase(bcId: bcId),
        parse: (data) => data);
  }

  static Future<Result<ReadingBookCaseResponse>> addReadingBookCase(
      {required ReadingBookCaseRequest request}) {
    return BookCaseData().postReadingBookCase(request: request);
  }

  static Future<Result<List<ReadingBookCaseResponse>>> getAllReadingBookCase(
      {required String uid}) {
    return BookCaseData().fetchAllReadingBookCase(uid: uid);
  }

  static Future<Result<bool>> handleDeleReadingBookCase(
      {required String bcId}) {
    return BookCaseData().deleteReadingBookCase(bcId: bcId);
  }
}
