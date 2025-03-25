import 'package:reading_app/core/services/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/services/entities/models/list_comic_model.dart';
import 'package:reading_app/core/services/entities/models/user_model.dart';

abstract class HomeRepository {
  Future<List<NovelResponse>> fetchListNovel();
  Future<List<NovelResponse>> fetchListSlider();
  Future<ListComicModel?> fetchUpcomingComics();
  Future<UserModel?> fetchUser();
}
