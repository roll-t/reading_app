

// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

// ignore: camel_case_types
class leadingIconAppBar extends StatelessWidget {
  const leadingIconAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          border: Border.all(color: AppColors.white.withOpacity(.4),width: .6),
          color: AppColors.white.withOpacity(.2)),
        child: IconButton(
          onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back_ios_new_rounded,size: IconsDimens.iconsSize18,)),
      ),
    );
  }
}