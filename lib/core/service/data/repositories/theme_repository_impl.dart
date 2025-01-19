import 'dart:convert';
import 'dart:ui';

import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/service/domain/repositories/theme_repository.dart';
import 'package:reading_app/core/service/storage/prefs/prefs.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final Prefs _prefs;

  ThemeRepositoryImpl(this._prefs);

  @override
  Future<void> setReadTheme(Map<String, dynamic> readThemeSetting) async {
    var mutableReadThemeSetting = Map<String, dynamic>.from(readThemeSetting);
    mutableReadThemeSetting.update(
        "textColor", (value) => (value as Color).value);
    mutableReadThemeSetting.update(
        "backgroundColor", (value) => (value as Color).value);
    await _prefs.set(
        PrefsConstants.readThemeUseCase, jsonEncode(mutableReadThemeSetting));
  }

  @override
  Future<Map<String, dynamic>?> getReadTheme() async {
    var data = await _prefs.get(PrefsConstants.readThemeUseCase);
    Map<String, dynamic> decodedData = jsonDecode(data);
    decodedData.update("textColor", (value) => Color(value as int));
    decodedData.update("backgroundColor", (value) => Color(value as int));
    return decodedData;
  }

  @override
  Future<void> setTextSize(double sizeText) async {
    await _prefs.set(PrefsConstants.readSizeTextUseCase, sizeText.toString());
  }

  @override
  Future<double> getTextSize() async {
    var data = await _prefs.get(PrefsConstants.readSizeTextUseCase);
    return double.tryParse(data) ?? 10;
  }

  @override
  Future<void> setFont(String font) async {
    await _prefs.set(PrefsConstants.fontTheme, font);
  }

  @override
  Future<String> getFont() async {
    return await _prefs.get(PrefsConstants.fontTheme);
  }
}
