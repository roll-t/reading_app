import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/features/dashboard/home/domain/repositories/home_repository.dart';

class FetchUpComingComicsUsecase {
  final HomeRepository _repository;
  FetchUpComingComicsUsecase(this._repository);

  Future<ListComicModel?> call() async {
    try {
      return _repository.fetchUpcomingComics();
    } catch (e) {
      print(e);
    }
    return ListComicModel(domainImage: "", titlePage: '', items: []);
  }
}
