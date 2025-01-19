import 'package:reading_app/core/configs/end_point_config.dart';
import 'package:reading_app/core/service/api/api_service.dart';
import 'package:reading_app/core/service/data/dto/response/category_response.dart';
import 'package:reading_app/core/service/data/model/result.dart';

class CategoryService extends ApiService {
  CategoryService(super.dioConfig, super.cacheService);


  Future<Result<List<CategoryResponse>>> fetchAllCategories() async {
    return await fetchData(
        endpoint: EndPointSetting.getAllCategory,
        parse: (data) => (data as List<dynamic>)
            .map((items) => CategoryResponse.fromJson(items))
            .toList());
  }
}
