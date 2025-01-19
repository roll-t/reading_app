import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/features/nav/home/domain/repositories/home_repository.dart';

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
