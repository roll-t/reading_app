import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/loading.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildShareAuth {
  static Expanded buildBackgoundForm({Widget childContent = const SizedBox()}) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: SpaceDimens.space25, vertical: 4.h),
          width: 100.w,
          decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(RadiusDimens.radiusLarge2),
                  topRight: Radius.circular(RadiusDimens.radiusLarge2))),
          child: childContent),
    );
  }

  static Widget buildTitle({String title = "", String subTitle = ""}) {
    return Center(
      child: SizedBox(
        height: 23.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 130, child: Image.asset(AppImages.iLogo)),
            const SizedBox(height: 5),
            TextWidget(
              text: title,
              fontWeight: FontWeight.w700,
              size: 23.sp,
            ),
          ],
        ),
      ),
    );
  }

  static Scaffold buildMainBodyPage(
      {Widget body = const SizedBox(),
      Widget appbar = const SizedBox(),
      required RxBool isLoading}) {
    return Scaffold(
        backgroundColor: AppColors.tertiaryDarkBg,
        body: Loading(
          isLoading: isLoading,
          bodyBuilder: SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: appbar),
                  body,
                ],
              ),
            ),
          ),
        ));
  }
}
