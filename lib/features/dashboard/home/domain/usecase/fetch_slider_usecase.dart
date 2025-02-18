import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/features/dashboard/home/domain/repositories/home_repository.dart';

class FetchSliderUsecase {
  final HomeRepository _repository;
  FetchSliderUsecase(this._repository);

  Future<List<NovelResponse>?> call() async {
    try {
      return await _repository.fetchListSlider();
    } catch (e) {
      print("Error fetching list novel: $e");
    }
    return null;
  }
}
