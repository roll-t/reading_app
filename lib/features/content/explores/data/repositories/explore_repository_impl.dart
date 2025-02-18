import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/core/services/api/data/sources/locals/novel_service.dart';
import 'package:reading_app/core/services/api/data/sources/remotes/comic_service.dart';
import 'package:reading_app/features/content/explores/domain/repositories/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ComicApi _comicApi;
  final NovelService _novelService;

  ExploreRepositoryImpl(
    this._comicApi,
    this._novelService,
  );

  @override
  Future<ListComicModel?> fetchComicsByCategorySlug({
    required String slug,
    int page = 1,
  }) async {
    try {
      var result =
          await _comicApi.fetchComicCategoryBySlug(slug: slug, page: page);
      return result.status == Status.success ? result.data : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<ListComicModel?> fetchComicsByStatusAndCategorySlug({
    required String categorySlug,
    required String status,
    int page = 1,
  }) async {
    return null;
  }

  @override
  Future<List<NovelResponse>?> fetchNovelsByCategorySlug({
    required String slug,
    int page = 1,
  }) async {
    try {
      var result =
          await _novelService.fetchListNovelByCategory(statusName: slug);
      return result.status == Status.success ? result.data : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<ListComicModel?> fetchComicsByStatusList({
    required String statusSlug,
    int page = 1,
  }) async {
    try {
      var result = await _comicApi.fetchListBySlug(
        slug: statusSlug,
        page: page,
      );
      return result.status == Status.success ? result.data : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<NovelResponse>?> fetchNovelByCategorySlugAndStatus({
    required String statusSlug,
    required String categorySlug,
    int page = 1,
  }) async {
    try {
      var result = await _novelService.fetchListNovelByCategorySlugAndStatus(
          categorySlug: categorySlug, statusName: statusSlug);
      return result.status == Status.success ? result.data : null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
