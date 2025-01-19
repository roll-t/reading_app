import 'package:reading_app/core/service/data/model/list_category_model.dart';
import 'package:reading_app/core/service/domain/repositories/category_repository.dart';

class FetchCategoriesCacheUsecase {
  final CategoryRepository _repository;

  FetchCategoriesCacheUsecase(this._repository);

  Future<List<ListCategoryModel>?> call() async {
    try {
      return await _repository.fetchCategoryCache();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
