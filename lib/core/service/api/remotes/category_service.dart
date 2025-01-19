import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/end_point_config.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/service/api/api_service.dart';
import 'package:reading_app/core/service/data/dto/response/response_comic_api.dart';
import 'package:reading_app/core/service/data/model/list_category_model.dart';
import 'package:reading_app/core/service/data/model/result.dart';
import 'package:reading_app/core/service/domain/usecase/categories/check_category_cache_usecase.dart';
import 'package:reading_app/core/service/storage/use_case/categories_usecase.dart';

class CategoryService extends ApiService {
  final CheckCategoryCacheUsecase _checkCategoryCacheUsecase = Get.find();
  CategoryService(super.dioConfig, super.cacheService);

  // Lấy danh mục
  Future<Result<List<ListCategoryModel>>> getListCategories() async {
    try {
      final response =
          await dioConfig.dio.get(EndPointSetting.categoriesEndpoint());
      final apiResponse = response.data;
      return ResponseComicApi.handleResponseCategories(
          response.statusCode ?? 500,
          data: apiResponse);
    } catch (e) {
      return _handleApiError(e);
    }
  }

  // Xử lý lỗi API
  Result<T> _handleApiError<T>(e) {
    if (e is DioException) {
      if (e.response?.statusCode == 401) {
        return Result.error(ApiError.unauthorized);
      }
    }
    return Result.error(ApiError.unknown);
  }

  Future<void> setCategoryCache() async {
    bool checkSetUp = await _checkCategoryCacheUsecase();
    if (checkSetUp) return;
    final response =
        await dioConfig.dio.get(EndPointSetting.categoriesEndpoint());
    final apiResponse = response.data;
    Result<List<ListCategoryModel>> listCategories =
        ResponseComicApi.handleResponseCategories(response.statusCode ?? 500,
            data: apiResponse);
    if (listCategories.status == Status.success) {
      await CategoriesUsecase.setCategoryCache(
          listCategory: listCategories.data!);
    }
  }

  Future<List<ListCategoryModel>?> fetchCategoryCache() async {
    return await CategoriesUsecase.getCategoryCache();
  }
}
