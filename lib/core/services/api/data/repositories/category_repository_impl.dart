import 'package:reading_app/core/services/api/data/entities/models/category_model.dart';
import 'package:reading_app/core/services/api/data/sources/remotes/category_service.dart';
import 'package:reading_app/core/services/api/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryService _categoryService;
  CategoryRepositoryImpl(this._categoryService);

  @override
  Future<List<CategoryModel>?> fetchCategoryCache() async {
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
