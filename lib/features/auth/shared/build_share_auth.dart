import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/app_colors.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/ui/widgets/icons/icon_circle.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/ui/widgets/texts/text_bold.dart';
import 'package:reading_app/core/ui/widgets/texts/title_big.dart';

class BuildShareAuth {
  static Expanded buildBackgoundForm({Widget childContent = const SizedBox()}) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimens.paddingSpace25,
              vertical: Get.height * .04),
          width: Get.width,
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppDimens.radius30),
                  topRight: Radius.circular(AppDimens.radius30))),
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
            TitleBig(
              contentChild: title,
            ),
            const SizedBox(
              height: AppDimens.paddingSpace10,
            ),
            TextBold(
              contentChild: subTitle,
            ),
            const SizedBox(
              height: AppDimens.paddingSpace30,
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
        body: Obx(
          () => isLoading.value == true
              ? const Center(
                  child: TextWidget(text: "Loading"),
                )
              : SingleChildScrollView(
                  child: SizedBox(
                    height: Get.height,
                    child: Stack(
                      children: [
                        Positioned(
                            left: -AppDimens.textureCircleSize400 / 1.7,
                            top: -AppDimens.textureCircleSize400 / 1.7,
                            child: Container(
                              width: AppDimens.textureCircleSize400,
                              height: AppDimens.textureCircleSize400,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppDimens.radiusFull),
                                  color: AppColors.lightActive),
                            )),
                        Positioned(
                            right: -AppDimens.textureCircleSize150 / 1.5,
                            top: AppDimens.textureCircleSize150 / 4,
                            child: Container(
                              width: AppDimens.textureCircleSize150,
                              height: AppDimens.textureCircleSize150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppDimens.radiusFull),
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
            top: AppDimens.paddingSpace20, left: AppDimens.paddingSpace10),
        child: IconCircle(
          iconChild: Icons.arrow_back_ios_new,
          onTap: () {
            Get.back();
          },
        ));
  }
}
