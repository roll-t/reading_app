import 'dart:async';

import 'package:dio/dio.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/service/configs/end_point_config.dart';
import 'package:reading_app/core/service/core_service.dart';
import 'package:reading_app/core/service/data/dto/response/response_comic_api.dart';
import 'package:reading_app/core/service/data/model/chapter_model.dart';
import 'package:reading_app/core/service/data/model/comic_model.dart';
import 'package:reading_app/core/service/data/model/list_category_model.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/core/service/data/model/result.dart';
import 'package:reading_app/core/storage/use_case/use_case_category.dart';

class ComicApi extends CoreService {
  static final ComicApi _instance = ComicApi._internal();
  ComicApi._internal();
  factory ComicApi() {
    return _instance;
  }

  Future<Result<ComicModel>> fetchBookBySlug({required String slug}) async {
    return await fetchData(
      endpoint: EndPointSetting.comicDetailEndpoint(slug: slug),
      parse: (data) => ComicModel.fromJson(data),
      apiSource: ApiSource.comic,
      useCache: true,
    );
  }

  Future<Result<ListComicModel>> fetchHomeData() async {
    return await fetchData(
      endpoint: EndPointSetting.comicHomeEndpoint(),
      parse: (data) => ResponseComicApi.handleResponseData(
        200,
        data: data,
      ).data!,
      apiSource: ApiSource.comic,
      useCache: true,
    );
  }

  Future<Result<ListComicModel>> fetchListBySlug(
      {required String slug, required int page}) async {
    return await fetchData(
        endpoint: EndPointSetting.listByTypeEndpoint(slug: slug, page: page),
        parse: (data) => ResponseComicApi.handleResponseData(
              200,
              data: data,
            ).data!,
        apiSource: ApiSource.comic,
        useCache: true);
  }

  Future<Result<ListComicModel>> fetchListSearchBySlug(
      {required String slug, required int page}) async {
    return await fetchData(
      endpoint: EndPointSetting.searchBySlugEndpoint(slug: slug, page: page),
      parse: (data) => ResponseComicApi.handleResponseData(
        200,
        data: data,
      ).data!,
      apiSource: ApiSource.comic,
      useCache: true,
    );
  }

  Future<Result<List<ListCategoryModel>>> fetchCategories() async {
    try {
      final response =
          await dioService.dio.get(EndPointSetting.categoriesEndpoint());
      final apiResponse = response.data;
      return ResponseComicApi.handleResponseCategories(
          response.statusCode ?? 500,
          data: apiResponse);
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          return Result.error(ApiError.unauthorized);
        }
      }
      return Result.error(ApiError.unknown);
    }
  }

  Future<Result<ListComicModel>> fetchComicCategoryBySlug(
      {required String slug, required int page}) async {
    return await fetchData(
      endpoint:
          EndPointSetting.categoriesBySlugEndpoint(slug: slug, page: page),
      parse: (data) => ResponseComicApi.handleResponseData(
        200,
        data: data,
      ).data!,
      apiSource: ApiSource.comic,
      useCache: true,
    );
  }

  Future<Result<ChapterModel>> fetchChapterAPI({
    required Map<String, dynamic> chapter,
  }) async {
    try {
      if (chapter["chapter_api_data"] != null) {
        var response = await dioService.dio.get(chapter["chapter_api_data"]);
        if (response.statusCode == 200) {
          var data = response.data["data"];
          ChapterModel chapterModel = ChapterModel.fromJson(data);
          return Result.success(chapterModel);
        } else {
          return Result.error(ApiError.unknown);
        }
      }
      return Result.error(ApiError.unknown);
    } catch (e) {
      return Result.error(ApiError.unknown);
    }
  }

  static Future<Result<ComicModel>> getBookDetailDataAPI(
      {required String slug}) async {
    final bookRemote = ComicApi();
    return bookRemote.fetchBookBySlug(slug: slug);
  }

  static Future<Result<ChapterModel>> getChapterDataAPI(
      {required Map<String, dynamic> chapter}) async {
    return await ComicApi().fetchChapterAPI(chapter: chapter);
  }

  static Future<Result<ListComicModel>> getHomeData() async {
    return await ComicApi().fetchHomeData();
  }

  static Future<Result<ListComicModel>> getListNewest({page = 1}) async {
    return await ComicApi().fetchListBySlug(slug: 'truyen-moi', page: page);
  }

  static Future<Result<ListComicModel>> getListComingSoon({page = 1}) async {
    return await ComicApi().fetchListBySlug(slug: 'sap-ra-mat', page: page);
  }

  static Future<Result<ListComicModel>> getListNowRelease({page = 1}) async {
    return await ComicApi().fetchListBySlug(slug: 'dang-phat-hanh', page: page);
  }

  static Future<Result<ListComicModel>> getListBySlug(
      {required String slug, page = 1}) async {
    return await ComicApi().fetchListBySlug(slug: slug, page: page);
  }

  static Future<Result<ListComicModel>> getListComplete({page = 1}) async {
    return await ComicApi().fetchListBySlug(slug: 'hoan-thanh', page: page);
  }

  static Future<Result<ListComicModel>> getListNewUpdate({page = 1}) async {
    return await ComicApi().fetchListBySlug(slug: 'moi-cap-nhat', page: page);
  }

  static Future<Result<ListComicModel>> getListSearchBySlug(
      {required String slug, page = 1}) async {
    return await ComicApi().fetchListSearchBySlug(slug: slug, page: page);
  }

  static Future<Result<List<ListCategoryModel>>> getListCategories() async {
    return await ComicApi().fetchCategories();
  }

  static Future<Result<ListComicModel>> getListComicCategoryBySlug(
      {required String slug, int page = 1}) async {
    return await ComicApi().fetchComicCategoryBySlug(slug: slug, page: page);
  }

  static Future<void> setCategoryCache() async {
    bool checkSetUp = await UseCaseCategory.checkCategoryCache();

    if (checkSetUp) {
      return;
    }

    Result<List<ListCategoryModel>> listCategory = await getListCategories();

    if (listCategory.status == Status.success) {
      await UseCaseCategory.setCategoryCache(listCategory: listCategory.data!);
    }
  }

  static Future<List<ListCategoryModel>?> getCategoryCache() async {
    return await UseCaseCategory.getCategoryCache();
  }
}
