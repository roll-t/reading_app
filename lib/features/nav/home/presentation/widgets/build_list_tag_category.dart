import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/service/model/list_category_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/modal/custom_bottom_sheet.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildListTagCategory extends StatelessWidget {
  final List<ListCategoryModel> listCategory;
  const BuildListTagCategory({
    super.key,
    this.listCategory = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 3.w, top: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextLargeSemiBold(textChild: "Kho truyện tranh"),
          Container(
            padding: EdgeInsets.only(top: 2.h),
            child: Wrap(
              spacing: SpaceDimens.space10,
              runSpacing: SpaceDimens.space10,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.category,
                        arguments: {"slugQuery": "dang-phat-hanh"});
                  },
                  child: const TagCategory(
                    categoryName: AppContents.newestUpdate,
                    typeTag: TagMarker.newUpdate,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.category,
                        arguments: {"slugQuery": "truyen-moi"});
                  },
                  child: const TagCategory(
                    categoryName: AppContents.justPosted,
                    typeTag: TagMarker.justPosted,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.category,
                        arguments: {"slugQuery": "hoan-thanh"});
                  },
                  child: const TagCategory(
                    categoryName: "Hoàn thành",
                    typeTag: TagMarker.trending,
                  ),
                ),
                for (var i = 0; i < (listCategory.length / 4).ceil(); i++)
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.category,
                          arguments: {"slugQuery": listCategory[i].slug});
                    },
                    child: TagCategory(
                      categoryName: listCategory[i].name,
                    ),
                  ),
                InkWell(
                  onTap: () {
                    CustomBottomSheetWidget(
                      heightSheet: 75.h,
                      context,
                      viewItems: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 5.w, bottom: 2.h, top: 2.h),
                          child: const TextLargeSemiBold(
                            textChild: "Thể loại",
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              bottom: 5.h, left: 5.w, right: 5.w),
                          child: Wrap(
                            spacing: 2.h,
                            runSpacing: 2.h,
                            children: [
                              for (var i = 0; i < listCategory.length; i++)
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.category, arguments: {
                                      "slugQuery": listCategory[i].slug
                                    });
                                  },
                                  child: TagCategory(
                                    categoryName: listCategory[i].name,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ).show(context);
                  },
                  child: const TagCategory(
                    categoryName: "${AppContents.seeMore} +",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
