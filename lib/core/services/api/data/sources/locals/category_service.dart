import 'package:reading_app/core/services/api/data/entities/dto/response/category_response.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';
import 'package:reading_app/core/services/network/api_endpoint.dart';
import 'package:reading_app/core/services/network/api_service.dart';

class CategoryService extends ApiService {
  CategoryService(super.dioConfig, super.cacheService);


  Future<Result<List<CategoryResponse>>> fetchAllCategories() async {
    return await get(
        endpoint: EndPointSetting.getAllCategory,
        parse: (data) => (data as List<dynamic>)
            .map((items) => CategoryResponse.fromJson(items))
            .toList());
  }
}
