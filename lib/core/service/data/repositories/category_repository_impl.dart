import 'package:reading_app/core/service/api/remotes/category_service.dart';
import 'package:reading_app/core/service/data/model/list_category_model.dart';
import 'package:reading_app/core/service/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryService _categoryService;
  CategoryRepositoryImpl(this._categoryService);

  @override
  Future<List<ListCategoryModel>?> fetchCategoryCache() async {
    final cachedCategories = await _categoryService.fetchCategoryCache();
    return cachedCategories;
  }

  @override
  Future<void> setCategoryCache() async {
    await _categoryService.setCategoryCache();
  }

  @override
  Future<void> checkCategoryCache() async {}
}
