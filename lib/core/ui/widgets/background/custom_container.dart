

import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class CustomContainer {
    static Container customBackgroudBox({required Widget childBuilder}){
    return Container(
      padding: const EdgeInsets.all(AppDimens.spaceStandard),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.secondaryDarkBg,
      ),
      child: childBuilder,
    );
  }
}