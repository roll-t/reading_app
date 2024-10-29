import 'package:reading_app/core/data/database/model/result.dart';
import 'package:reading_app/core/data/dto/response/category_response.dart';
import 'package:reading_app/core/data/service/configs/end_point_setting.dart';
import 'package:reading_app/core/data/service/core_service.dart';

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
