import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingWidgets {
  // ignore: non_constant_identifier_names
  static Obx LoadingFullScreen({
    required RxBool isLoading,
    required Widget body,
  }) {
    return Obx(() => Scaffold(
          body: Stack(
            children: [
              body,
              if (isLoading.value)
                Positioned.fill(
                  child: Container(
                    color: AppColors.grey.withOpacity(0.3),
                    child: Center(
                      child: Image.asset(width: 10.w, AppImages.iLoading),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  static Obx LoadingPartial({required RxBool isLoading, required Widget body}) {
    return Obx(() => isLoading.value
        ? const Center(
            child: TextWidget(
              text: "Loading ...",
              size: TextDimens.textSize12,
              color: AppColors.gray2,
            ),
          )
        : body);
  }
}
