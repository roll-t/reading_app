import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/response_comic_api.dart';
import 'package:reading_app/core/services/api/data/entities/models/category_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/api/domain/usecase/categories/categories_usecase.dart';
import 'package:reading_app/core/services/api/domain/usecase/categories/check_category_cache_usecase.dart';
import 'package:reading_app/core/services/network/api_endpoint.dart';
import 'package:reading_app/core/services/network/api_service.dart';

class CategoryService extends ApiService {
  final CheckCategoryCacheUsecase _checkCategoryCacheUsecase = Get.find();
  CategoryService(super.dioConfig, super.cacheService);

  // Lấy danh mục
  Future<Result<List<CategoryModel>>> getListCategories() async {
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
    Result<List<CategoryModel>> listCategories =
        ResponseComicApi.handleResponseCategories(response.statusCode ?? 500,
            data: apiResponse);
    if (listCategories.status == Status.success) {
      await CategoriesUsecase.setCategoryCache(
          listCategory: listCategories.data!);
    }
  }

  Future<List<CategoryModel>?> fetchCategoryCache() async {
    return await CategoriesUsecase.getCategoryCache();
  }
}
