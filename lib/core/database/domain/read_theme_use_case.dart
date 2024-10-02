import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/database/prefs/prefs.dart';

class ReadThemeUseCase {
  static final Prefs prefs = Prefs();

  static Future<void> setReadTheme(
      {required Map<String, dynamic> readThemSetting}) async {
    try {
      var mutableReadThemeSetting = Map<String, dynamic>.from(readThemSetting);
      mutableReadThemeSetting.update(
          "textColor", (value) => (value as Color).value);
      mutableReadThemeSetting.update(
          "backgroundColor", (value) => (value as Color).value);
      await prefs.set(
          PrefsConstants.readThemeUseCase, jsonEncode(mutableReadThemeSetting));
      print(mutableReadThemeSetting);
    } catch (e) {
      print(e);
    }
  }

  static Future<Map<String, dynamic>?> getReadTheme() async {
    try {
      var data = await prefs.get(PrefsConstants.readThemeUseCase);
      if (data != null) {
        Map<String, dynamic> decodedData = jsonDecode(data);
        decodedData.update("textColor", (value) => Color(value as int));
        decodedData.update("backgroundColor", (value) => Color(value as int));
        return decodedData;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<void> setTextSizeReadTheme({required double sizeText}) async {
    try {
      // Lưu trực tiếp kích thước văn bản dưới dạng chuỗi
      await prefs.set(PrefsConstants.readSizeTextUseCase, sizeText.toString());
    } catch (e) {
      print('Error setting text size: $e');
    }
  }

  static Future<double?> getTextSizeReadTheme() async {
    try {
      var data = await prefs.get(PrefsConstants.readSizeTextUseCase);
      if (data != null) {
        return double.tryParse(data);
      }
    } catch (e) {
      print('Error getting text size: $e');
      return null;
    }
    return null; // Trả về null nếu không có dữ liệu
  }
}
