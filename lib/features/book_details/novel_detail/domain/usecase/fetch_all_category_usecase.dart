import 'package:reading_app/core/services/entities/dto/response/category_response.dart';
import 'package:reading_app/features/book_details/novel_detail/domain/repositories/novel_detail_repository.dart';

class FetchAllCategoryUsecase {
  final NovelDetailRepository _repository;
  FetchAllCategoryUsecase(this._repository);

  Future<List<CategoryResponse>?> call() async {
    return await _repository.fetchAllCategory();
  }
}
