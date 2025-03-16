import 'package:reading_app/core/services/entities/models/category_model.dart';
import 'package:reading_app/features/category/data/sources/category_comic_service.dart';
import 'package:reading_app/features/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryComicService _categoryService;
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
