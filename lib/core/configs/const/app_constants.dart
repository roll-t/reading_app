import 'dart:ui';

import 'package:reading_app/core/configs/themes/app_colors.dart';

class AppConstants {
  static const bool isAdmobEnabled = false;
  static const Map<String, dynamic> listType = {
    "newRelease": "truyen-moi",
    "upcoming": "sap-ra-mat",
    "ongoing": "dang-phat-hanh",
    "completed": "hoan-thanh"
  };
  static const List<Map<String, dynamic>> readThemeIds = [
    {
      "id": "readThemeDefault",
      "name":"Mặc định",
      "textColor": AppColors.white,
      "backgroundColor": AppColors.primaryDarkBg,
    },
    {
      "id": "readThemePaper", // Chủ đề Giấy
      "name":"Giấy",
      "textColor": Color(0xFF4A4A4A), // Màu chữ đen nhẹ
      "backgroundColor": Color(0xFFFAF3E0), // Màu nền giống giấy
    },
    {
      "id": "readThemeChill", // Chủ đề Êm dịu
      "name":"Êm diệu",
      "textColor": Color(0xFF757575), // Màu chữ xám nhạt
      "backgroundColor": Color(0xFFE0F7FA), // Màu nền xanh pastel
    },
    {
      "id": "readThemeFocus", // Chủ đề Tập trung
      "name":"Tập chung",
      "textColor": Color(0xFFE3F2FD), // Màu chữ trắng hoặc xanh biển nhạt
      "backgroundColor": Color(0xFF263238), // Màu nền xanh đậm
    },
  ];
}
