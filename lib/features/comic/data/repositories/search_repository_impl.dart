import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/services/entities/models/list_comic_model.dart';
import 'package:reading_app/features/comic/data/sources/comic_service.dart';
import 'package:reading_app/features/comic/domain/repositories/search_repository.dart';
import 'package:reading_app/features/novel/data/sources/novel_service.dart';

class SearchRepositoryImpl implements SearchRepository {
  final ComicApi _comicService;
  final NovelService _novelService;

  SearchRepositoryImpl(
    this._comicService,
    this._novelService,
  );

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
