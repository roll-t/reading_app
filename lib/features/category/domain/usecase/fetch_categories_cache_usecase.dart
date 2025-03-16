import 'package:reading_app/core/services/entities/models/category_model.dart';
import 'package:reading_app/features/category/domain/repositories/category_repository.dart';

class FetchCategoriesCacheUsecase {
  final CategoryRepository _repository;

  FetchCategoriesCacheUsecase(this._repository);

  Future<List<CategoryModel>?> call() async {
    try {
      return await _repository.fetchCategoryCache();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
