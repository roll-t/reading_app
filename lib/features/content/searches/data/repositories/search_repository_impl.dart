import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/core/services/api/data/sources/locals/novel_service.dart';
import 'package:reading_app/core/services/api/data/sources/remotes/comic_service.dart';
import 'package:reading_app/features/content/searches/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final ComicApi _comicService;
  final NovelService _novelService;

  SearchRepositoryImpl(
    this._comicService,
    this._novelService,
  );

  @override
  Future<ListComicModel?> fetchComicsDefaultSearch() async {
    try {
      var result = await _comicService.fetchListBySlug(slug: "Rồng", page: 1);
      return result.status == Status.success ? result.data : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<ListComicModel?> fetchComicsSearch({
    required String contentSearch,
    int page = 1,
  }) async {
    try {
      var result = await _comicService.fetchListSearchBySlug(
          slug: contentSearch, page: page);
      return result.status == Status.success ? result.data : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<NovelResponse>?> fetchNovelsSearch({
    required String contentSearch,
    int page = 1,
  }) async {
    try {
      var result =
          await _novelService.searchNovelByNameOrSlug(text: contentSearch);
      return result.status == Status.success ? result.data : null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
