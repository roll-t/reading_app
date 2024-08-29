import 'dart:convert';

import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/data/models/list_category_model.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';

class UseCaseCategory {
  static final Prefs prefs = Prefs();

  // Method to store categories in the cache
  static Future<void> setCategoryCache(
      {required List<ListCategoryModel> listCategory}) async {
    try {
      // Convert the list of categories to JSON and save to prefs
      await prefs.set(PrefsConstants.categoryCache, jsonEncode(listCategory.map((category) => category.toJson()).toList()));
    } catch (e) {
      print(e);
    }
  }

  // Method to retrieve categories from the cache
  static Future<List<ListCategoryModel>?> getCategoryCache() async {
    try {
      var data = await prefs.get(PrefsConstants.categoryCache);

      if (data != null) {
        List<dynamic> decodedData = jsonDecode(data);
        // Convert each Map into a ListCategoryModel
        List<ListCategoryModel> result = decodedData.map((categoryJson) => ListCategoryModel.fromJson(categoryJson)).toList();
        return result;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  // Method to check if categories exist in the cache
  static Future<bool> checkCategoryCache() async {
    try {
      var checkSetUp = await prefs.get(PrefsConstants.categoryCache);
      if (checkSetUp != null && checkSetUp.isNotEmpty) {
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
