import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class ReadThemeModel {
  String id;
  String name;
  Color textColor;
  Color backgroundColor;

  ReadThemeModel({
    this.id = "readThemeDefault",
    this.name = "Mặc định",
    this.textColor = AppColors.white,
    this.backgroundColor = AppColors.primaryDarkBg,
  });

  // Convert từ Map sang ReadThemeModel
  factory ReadThemeModel.fromMap(Map<String, dynamic> map) {
    return ReadThemeModel(
      id: map['id'],
      name: map['name'],
      textColor: map['textColor'],
      backgroundColor: map['backgroundColor'],
    );
  }

  // Convert từ ReadTheme sang Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'textColor': textColor,
      'backgroundColor': backgroundColor,
    };
  }
}
