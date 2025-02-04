import 'package:reading_app/core/services/api/domain/repositories/category_repository.dart';

class SetCategoriesCacheUsecase {
  final CategoryRepository _repository;

  SetCategoriesCacheUsecase(this._repository);

  Future<void> call() async {
    try {
      await _repository.setCategoryCache();
    } catch (e) {
      print(e);
    }
  }
}
