import 'dart:convert';

import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/services/api/data/entities/models/category_model.dart';
import 'package:reading_app/core/storage/prefs/prefs.dart';

class CategoriesUsecase {
  static final Prefs prefs = Prefs();

  static Future<void> setCategoryCache(
      {required List<CategoryModel> listCategory}) async {
    try {
      await prefs.set(
          PrefsConstants.categoryCache,
          jsonEncode(
              listCategory.map((category) => category.toJson()).toList()));
    } catch (e) {
      print(e);
    }
  }

  static Future<List<CategoryModel>?> getCategoryCache() async {
    try {
      var data = await prefs.get(PrefsConstants.categoryCache);

      List<dynamic> decodedData = jsonDecode(data);
      List<CategoryModel> result = decodedData
          .map((categoryJson) => CategoryModel.fromJson(categoryJson))
          .toList();
      return result;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> checkCategoryCache() async {
    try {
      var checkSetUp = await prefs.get(PrefsConstants.categoryCache);
      if (checkSetUp.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      await prefs.set(PrefsConstants.categoryCache, "");
      return false;
    }
  }
}
