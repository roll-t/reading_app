import 'package:reading_app/core/services/api/data/entities/dto/response/category_response.dart';
import 'package:reading_app/features/content/book_details/novel_detail/domain/repositories/novel_detail_repository.dart';

class FetchAllCategoryUsecase {
  final NovelDetailRepository _repository;
  FetchAllCategoryUsecase(this._repository);

  Future<List<CategoryResponse>?> call() async {
    return await _repository.fetchAllCategory();
  }
}
