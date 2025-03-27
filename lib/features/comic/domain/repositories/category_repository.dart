import 'package:reading_app/core/services/entities/models/category_model.dart';

abstract class CategoryRepository {
  Future<void> setCategoryCache();
  Future<List<CategoryModel>?> fetchCategoryCache();
  Future<void> checkCategoryCache();
}
