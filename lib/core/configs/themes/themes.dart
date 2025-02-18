import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class Themes {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.white,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryHover,
        surface: AppColors.white,
        error: AppColors.error,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.lightThemePrimaryText),
        bodyMedium: TextStyle(color: AppColors.lightThemePrimaryText),
        titleLarge: TextStyle(color: AppColors.lightThemePrimaryText),
        titleMedium: TextStyle(color: AppColors.lightThemePrimaryText),
        titleSmall: TextStyle(color: AppColors.lightThemePrimaryText),
        headlineLarge: TextStyle(color: AppColors.lightThemePrimaryText),
        headlineMedium: TextStyle(color: AppColors.lightThemePrimaryText),
        headlineSmall: TextStyle(color: AppColors.lightThemePrimaryText),
        labelLarge: TextStyle(color: AppColors.lightThemePrimaryText),
        labelMedium: TextStyle(color: AppColors.lightThemePrimaryText),
        labelSmall: TextStyle(color: AppColors.lightThemePrimaryText),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        fillColor: WidgetStateProperty.all(AppColors.primary),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.accentColor, // Màu cho CircularProgressIndicator
        circularTrackColor:
            AppColors.accentColor.withOpacity(0.1), // Màu cho vòng tròn nền
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black,
      ),
      scaffoldBackgroundColor: AppColors.black,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryHover,
        surface: AppColors.black,
        error: AppColors.error,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkThemePrimaryText),
        bodyMedium: TextStyle(color: AppColors.darkThemePrimaryText),
        titleLarge: TextStyle(color: AppColors.darkThemePrimaryText),
        titleMedium: TextStyle(color: AppColors.darkThemePrimaryText),
        titleSmall: TextStyle(color: AppColors.darkThemePrimaryText),
        headlineLarge: TextStyle(color: AppColors.darkThemePrimaryText),
        headlineMedium: TextStyle(color: AppColors.darkThemePrimaryText),
        headlineSmall: TextStyle(color: AppColors.darkThemePrimaryText),
        labelLarge: TextStyle(color: AppColors.darkThemePrimaryText),
        labelMedium: TextStyle(color: AppColors.darkThemePrimaryText),
        labelSmall: TextStyle(color: AppColors.darkThemePrimaryText),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        fillColor: WidgetStateProperty.all(AppColors.primary),
      ),
    );
  }
}
