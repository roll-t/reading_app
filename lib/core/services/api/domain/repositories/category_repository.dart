import 'package:reading_app/core/services/api/data/entities/models/list_category_model.dart';

abstract class CategoryRepository {
  Future<void> setCategoryCache();
  Future<List<ListCategoryModel>?> fetchCategoryCache();
  Future<void> checkCategoryCache();
}
