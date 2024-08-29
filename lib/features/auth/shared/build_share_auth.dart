import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal_bold.dart';
import 'package:reading_app/core/ui/widgets/icons/icon_circle.dart';
import 'package:reading_app/core/utils/loading.dart';

class BuildShareAuth {
  static Expanded buildBackgoundForm({Widget childContent = const SizedBox()}) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: SpaceDimens.space25, vertical: Get.height * .04),
          width: Get.width,
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
        height: Get.height * .26,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextLargeBold(
              textChild: title,
            ),
            const SizedBox(
              height: SpaceDimens.space10,
            ),
            TextNormalBold(
              textChild: subTitle,
            ),
            const SizedBox(
              height: SpaceDimens.space30,
            )
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
        backgroundColor: AppColors.primary,
        body: Loading(
          isLoading: isLoading,
          bodyBuilder: SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Stack(
                children: [
                  Positioned(
                      left: -400 / 1.7,
                      top: -400 / 1.7,
                      child: Container(
                        width: 400,
                        height: 400,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(RadiusDimens.radiusFull),
                            color: AppColors.lightActive),
                      )),
                  Positioned(
                      right: -150 / 1.5,
                      top: 150 / 4,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(RadiusDimens.radiusFull),
                            color: AppColors.lightHover),
                      )),
                  Positioned(child: appbar),
                  body,
                ],
              ),
            ),
          ),
        ));
  }

  static Widget buildAppbar() {
    return Container(
        margin: const EdgeInsets.only(
            top: SpaceDimens.space20, left: SpaceDimens.space10),
        child: IconCircle(
          background: AppColors.white.withOpacity(.3),
          iconColor: AppColors.white,
          iconChild: Icons.arrow_back_ios_new,
          onTap: () {
            Get.back();
          },
        ));
  }
}
