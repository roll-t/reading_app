import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/entities/dto/response/response_comic_api.dart';
import 'package:reading_app/core/services/entities/models/category_model.dart';
import 'package:reading_app/core/services/entities/models/result.dart';
import 'package:reading_app/core/services/network/api_endpoint.dart';
import 'package:reading_app/core/services/network/api_service.dart';
import 'package:reading_app/features/category/domain/usecase/categories_usecase.dart';
import 'package:reading_app/features/category/domain/usecase/check_category_cache_usecase.dart';

class CategoryComicService extends ApiService {
  final CheckCategoryCacheUsecase _checkCategoryCacheUsecase = Get.find();
  
  CategoryComicService(super.dioConfig, super.cacheService);

  // Lấy danh mục
  Future<Result<List<CategoryModel>>> getListCategories() async {
    try {
      final response =
          await dioConfig.dio.get(APIEndpoint.categoriesEndpoint());
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
        await dioConfig.dio.get(APIEndpoint.categoriesEndpoint());
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
