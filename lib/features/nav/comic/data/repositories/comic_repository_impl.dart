import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/service/api/remotes/comic_service.dart';
import 'package:reading_app/core/service/data/model/comic_model.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/features/nav/comic/domain/repositories/comic_repository.dart';

class ComicRepositoryImpl implements ComicRepository {
  final ComicApi _comicApi;

  ComicRepositoryImpl(this._comicApi);

  @override
  Future<ListComicModel?> fetchHomeData() async {
    final response = await _comicApi.fetchHomeData();
    if (response.status == Status.success) {
      return response.data;
    }
    return null;
  }

  @override
  Future<ComicModel?> fetchListComplete() async {
    final response =
        await _comicApi.fetchListBySlug(page: 1, slug: 'hoan-thanh');
    if (response.status == Status.success) {
      return response.data as Future<ComicModel?>;
    }
    return null;
  }

  @override
  Future<ListComicModel?> fetchComicsByCategorySlug(String slug) async {
    final result =
        await _comicApi.fetchComicCategoryBySlug(slug: slug, page: 1);
    if (result.status == Status.success) {
      return result.data;
    }
    return null;
  }

  @override
  Future<ComicModel?> fetchComicsByChangeCategory(String slug) async {
    final result =
        await _comicApi.fetchComicCategoryBySlug(slug: slug, page: 1);
    if (result.status == Status.success) {
      return result.data as Future<ComicModel?>;
    }
    return null;
  }

  @override
  String? getSlugByCategoryTitle(String title) {
    return null;
  }

  @override
  Future<ListComicModel?> fetchListByStatus(String status) async {
    final response = await _comicApi.fetchListBySlug(page: 1, slug: status);
    if (response.status == Status.success) {
      return response.data;
    }
    return null;
  }
  
}
