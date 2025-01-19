import 'package:reading_app/core/service/data/dto/response/novel_response.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/core/service/data/model/user_model.dart';

abstract class HomeRepository {
  Future<List<NovelResponse>> fetchListNovel();
  Future<List<NovelResponse>> fetchListSlider();
  Future<ListComicModel?> fetchUpcomingComics();
  Future<UserModel?> fetchUser();
}
