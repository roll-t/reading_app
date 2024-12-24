import 'package:reading_app/core/service/configs/end_point_config.dart';
import 'package:reading_app/core/service/core_service.dart';
import 'package:reading_app/core/service/data/dto/response/category_response.dart';
import 'package:reading_app/core/service/data/model/result.dart';

class CategoryData extends CoreService {
  CategoryData._privateConstructor();

  static final CategoryData _instance = CategoryData._privateConstructor();

  factory CategoryData() {
    return _instance;
  }

  Future<Result<List<CategoryResponse>>> fetchAllCategories() async {
    return await fetchData(
        endpoint: EndPointSetting.getAllCategory,
        parse: (data) => (data as List<dynamic>)
            .map((items) => CategoryResponse.fromJson(items))
            .toList());
  }

}
