import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class BackgroundGradient {
  static Widget gradientRedBack({required Widget child}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.black,
            AppColors.black,
            AppColors.black,
          ],
          stops: [0.13, 0.3, 0.3, 0.3],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }

  static Gradient gradientButton() {
    return const LinearGradient(colors: [
      AppColors.primaryLight,
      AppColors.accentColor,
      AppColors.accentColor,
    ], end: Alignment.bottomCenter, begin: Alignment.topCenter);
  }

  static Container backgroundBox({required Widget childBuilder }){
    return Container(
      decoration: BoxDecoration(color: AppColors.secondaryDarkBg,borderRadius: BorderRadius.circular(10)),
      child: childBuilder,
    );
  }
}
