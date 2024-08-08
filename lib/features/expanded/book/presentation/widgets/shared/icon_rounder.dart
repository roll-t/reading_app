import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class IconsRounder extends StatelessWidget {
  final IconData iconData;
  const IconsRounder({
    super.key, 
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(1000),
            color: AppColors.gray3),
        child: Icon(
          iconData,
          color: AppColors.gray2,
          size: IconsDimens.iconsSize20,
        ));
  }
}
