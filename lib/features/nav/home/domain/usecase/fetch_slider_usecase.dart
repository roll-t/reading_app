import 'package:reading_app/core/service/data/dto/response/novel_response.dart';
import 'package:reading_app/features/nav/home/domain/repositories/home_repository.dart';

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
