import 'package:reading_app/core/services/entities/dto/response/reading_book_case_response.dart';
import 'package:reading_app/features/bookcase/domain/repositories/book_case_repository.dart';

class FetchNovelsBookcaseUsecase {
  final BookCaseRepository _repository;

  FetchNovelsBookcaseUsecase(this._repository);

  Future<List<ReadingBookCaseResponse>?> call({required String uid}) async {
    return await _repository.fetchNovelsBookcase(uid: uid);
  }
}
