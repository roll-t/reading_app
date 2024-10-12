import 'dart:async';

import 'package:dio/dio.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/database/data/model/chapter_model.dart';
import 'package:reading_app/core/database/data/model/comic_model.dart';
import 'package:reading_app/core/database/data/model/list_category_model.dart';
import 'package:reading_app/core/database/data/model/list_comic_model.dart';
import 'package:reading_app/core/database/data/model/result.dart';
import 'package:reading_app/core/database/domain/auth_use_case.dart';
import 'package:reading_app/core/database/domain/use_case_category.dart';
import 'package:reading_app/core/database/dto/response/response_api.dart';
import 'package:reading_app/core/database/service/configs/end_point_setting.dart';

class ComicApi extends EndPointSetting {
  final Dio _dio;
  ComicApi(this._dio);

  Future<void> _initializeHeaders() async {
    String token = await AuthUseCase.getAuthToken();
    if (token.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<Result<ComicModel>> fetchBookBySlug({required String slug}) async {
    await _initializeHeaders();
    try {
      final response =
          await _dio.get(EndPointSetting.comicDetailEndpoint(slug: slug));
      return ResponseApi.handleResponseComic(response.statusCode ?? 500,
          data: response.data);
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          return Result.error(ApiError.unauthorized);
        }
      }
      return Result.error(ApiError.unknown);
    }
  }

  Future<Result<ListComicModel>> fetchHomeData() async {
    try {
      final response = await _dio.get(EndPointSetting.comicHomeEndpoint());
      return ResponseApi.handleResponseData(response.statusCode ?? 500,
          data: response.data);
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          return Result.error(ApiError.unauthorized);
        }
      }
      return Result.error(ApiError.unknown);
    }
  }

  Future<Result<ListComicModel>> fetchListBySlug(
      {required String slug, required int page}) async {
    try {
      final response = await _dio
          .get(EndPointSetting.listByTypeEndpoint(slug: slug, page: page));
      final apiResponse = response.data;
      return ResponseApi.handleResponseData(response.statusCode ?? 500,
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

  Future<Result<ListComicModel>> fetchListSearchBySlug(
      {required String slug, required int page}) async {
    try {
      final response = await _dio
          .get(EndPointSetting.searchBySlugEndpoint(slug: slug, page: page));
      final apiResponse = response.data;
      return ResponseApi.handleResponseData(response.statusCode ?? 500,
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

  Future<Result<List<ListCategoryModel>>> fetchCategories() async {
    try {
      final response = await _dio.get(EndPointSetting.categoriesEndpoint());
      final apiResponse = response.data;
      return ResponseApi.handleResponseCategories(response.statusCode ?? 500,
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
    try {
      final response = await _dio.get(
          EndPointSetting.categoriesBySlugEndpoint(slug: slug, page: page));

      final apiResponse = response.data;

      return ResponseApi.handleResponseData(response.statusCode ?? 500,
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

  static Future<String> buildDomaiFromChaptersData(
      {required List<dynamic> chapter}) async {
    return "domain";
  }

  Future<Result<ChapterModel>> fetchChapterAPI({
    required Map<String, dynamic> chapter,
  }) async {
    try {
      if (chapter["chapter_api_data"] != null) {
        var response = await _dio.get(chapter["chapter_api_data"]);
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
    final bookRemote = ComicApi(Dio());
    return bookRemote.fetchBookBySlug(slug: slug);
  }

  static Future<Result<ChapterModel>> getChapterDataAPI(
      {required Map<String, dynamic> chapter}) async {
    final bookRemote = ComicApi(Dio());
    return await bookRemote.fetchChapterAPI(chapter: chapter);
  }

  static Future<Result<ListComicModel>> getHomeData() async {
    final dataRemote = ComicApi(Dio());
    return await dataRemote.fetchHomeData();
  }

  static Future<Result<ListComicModel>> getListNewest({page = 1}) async {
    final dataRemote = ComicApi(Dio());
    return await dataRemote.fetchListBySlug(slug: 'truyen-moi', page: page);
  }

  static Future<Result<ListComicModel>> getListComingSoon({page = 1}) async {
    final dataRemote = ComicApi(Dio());
    return await dataRemote.fetchListBySlug(slug: 'sap-ra-mat', page: page);
  }

  static Future<Result<ListComicModel>> getListNowRelease({page = 1}) async {
    final dataRemote = ComicApi(Dio());
    return await dataRemote.fetchListBySlug(slug: 'dang-phat-hanh', page: page);
  }

  static Future<Result<ListComicModel>> getListBySlug(
      {required String slug, page = 1}) async {
    final dataRemote = ComicApi(Dio());
    return await dataRemote.fetchListBySlug(slug: slug, page: page);
  }

  static Future<Result<ListComicModel>> getListComplete({page = 1}) async {
    final dataRemote = ComicApi(Dio());
    return await dataRemote.fetchListBySlug(slug: 'hoan-thanh', page: page);
  }

  static Future<Result<ListComicModel>> getListNewUpdate({page = 1}) async {
    final dataRemote = ComicApi(Dio());
    return await dataRemote.fetchListBySlug(slug: 'moi-cap-nhat', page: page);
  }

  static Future<Result<ListComicModel>> getListSearchBySlug(
      {required String slug, page = 1}) async {
    final dataRemote = ComicApi(Dio());
    return await dataRemote.fetchListSearchBySlug(slug: slug, page: page);
  }

  static Future<Result<List<ListCategoryModel>>> getListCategories() async {
    final dataRemote = ComicApi(Dio());
    return await dataRemote.fetchCategories();
  }

  static Future<Result<ListComicModel>> getListComicCategoryBySlug(
      {required String slug, int page = 1}) async {
    final dataRemote = ComicApi(Dio());
    return await dataRemote.fetchComicCategoryBySlug(slug: slug, page: page);
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
