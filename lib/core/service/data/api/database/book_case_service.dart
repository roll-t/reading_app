import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/service/configs/end_point_config.dart';
import 'package:reading_app/core/service/core_service.dart';
import 'package:reading_app/core/service/data/dto/request/favorite_request.dart';
import 'package:reading_app/core/service/data/dto/request/reading_book_case_request.dart';
import 'package:reading_app/core/service/data/dto/response/favorite_response.dart';
import 'package:reading_app/core/service/data/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/service/data/model/result.dart';

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

  // Add method to like a book
  Future<Result<FavoriteResponse>> likeBook(
      {required FavoriteRequest request}) async {
    final body = request.toJson();
    return await postData(
        endpoint: EndPointSetting
            .likeBook, // Assuming endpoint exists in EndPointSetting
        parse: (data) => FavoriteResponse.fromJson(data),
        data: body);
  }

  // Add method to unlike a book
  Future<Result<bool>> unlikeBook(
      {required String bookDataId, required String userId}) async {
    return await deleteData(
        endpoint: EndPointSetting.unlikeBook(
            bookDataId: bookDataId, userId: userId),
        parse: (data) => data);
  }

  Future<Result<List<FavoriteResponse>>> fetchAllFavoriteBooks(
      {required String userId}) async {
    return await fetchData(
        endpoint: EndPointSetting.getAllFavoriteBooks(userId: userId),
        parse: (data) => (data as List<dynamic>)
            .map((item) => FavoriteResponse.fromJson(item))
            .toList());
  }

  Future<Result<FavoriteResponse>?> toggleLikeBook({
    required String bookDataId,
    required String userId,
  }) async {
    // Check if the user has already liked the book
    final likeCheckResult =
        await checkIfBookLiked(bookDataId: bookDataId, userId: userId);

    if (likeCheckResult.status == Status.success) {
      final isLiked = likeCheckResult.data;

      if (isLiked ?? false) {
        await unlikeBook(bookDataId: bookDataId, userId: userId);
      } else {
        final favoriteRequest =
            FavoriteRequest(bookDataId: bookDataId, userId: userId);
        return await likeBook(request: favoriteRequest);
      }
    } else {
      // If the check fails, handle the error (e.g., show a message or log the error)
      return Result.error(ApiError.badRequest);
    }
    return null;
  }

  // Add method to check if a user has liked a particular book
  Future<Result<bool>> checkIfBookLiked(
      {required String bookDataId, required String userId}) async {
    return await fetchData(
        endpoint: EndPointSetting.checkIfBookLiked(
            bookDataId: bookDataId, userId: userId),
        parse: (data) => data); // Assuming the response is a boolean
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
