import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/services/api/data/entities/models/category_model.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_large_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/features/content/explores/presentation/controller/explore_novel_type_controller.dart';

class BuildCategoryFilterNovel extends GetView<ExploreNovelTypeController> {
  final RxInt currentIndex;
  final List<CategoryModel> categories;
  final bool? isLoading;
  const BuildCategoryFilterNovel({
    super.key,
    required this.currentIndex,
    required this.categories,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: SpaceDimens.space30,
        top: SpaceDimens.space20,
        bottom: SpaceDimens.space30,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                border: Border.all(
                    color: AppColors.white.withOpacity(.7), width: .6),
                color: AppColors.white.withOpacity(.3)),
            child: IconButton(
                onPressed: () {
                  // Show the bottom sheet
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        width: Get.width,
                        padding:
                            const EdgeInsets.all(SpaceDimens.spaceStandard),
                        height: Get.height * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const TextLargeSemiBold(
                                textChild: AppContents.selectCategory),
                            const SizedBox(
                              height: SpaceDimens.space20,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Wrap(
                                  spacing: SpaceDimens.space10,
                                  runSpacing: SpaceDimens.space10,
                                  children:
                                      List.generate(categories.length, (index) {
                                    return Obx(
                                      () => InkWell(
                                        onTap: () {
                                          controller.currentCategoryModalNovel
                                              .value = index;
                                        },
                                        child: FittedBox(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: controller
                                                          .currentCategoryModalNovel
                                                          .value ==
                                                      index
                                                  ? AppColors.accentColor
                                                  : AppColors.black,
                                              border: controller
                                                          .currentCategoryModalNovel
                                                          .value !=
                                                      index
                                                  ? Border.all(
                                                      color: AppColors.gray2)
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: SpaceDimens.space15,
                                              vertical: SpaceDimens.space5,
                                            ),
                                            child: Center(
                                              child: TextNormal(
                                                textChild:
                                                    categories[index].name,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            ButtonWidget(
                              padding: const EdgeInsets.symmetric(
                                vertical: SpaceDimens.space10,
                              ),
                              rounder: true,
                              background: AppColors.accentColor,
                              textChild: "Xong",
                              onTap: () async {
                                Navigator.pop(
                                    context); // Close the bottom sheet
                                await controller.fetchDataNovelByCategory(
                                    categoryName: controller
                                        .categoriesNovel[controller
                                            .currentCategoryModalNovel.value]
                                        .slug);
                                controller.currentIndexCategoryNovel.value =
                                    controller.currentCategoryModalNovel.value;
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.filter_alt_rounded,
                  size: IconsDimens.iconsSize18,
                )),
          ),
          const SizedBox(width: SpaceDimens.space30),
          Expanded(
            child: SizedBox(
              height: 35,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      currentIndex.value = index;
                      await controller.fetchDataNovelByCategory(
                          categoryName: controller.categoriesNovel[index].slug);
                      controller.currentCategoryModalNovel.value =
                          currentIndex.value;
                    },
                    child: Obx(
                      () => Container(
                        margin:
                            const EdgeInsets.only(right: SpaceDimens.space10),
                        decoration: BoxDecoration(
                          // ignore: unrelated_type_equality_checks
                          color: currentIndex == index
                              ? AppColors.accentColor
                              : AppColors.black,
                          // ignore: unrelated_type_equality_checks
                          border: currentIndex != index
                              ? Border.all(color: AppColors.gray2)
                              : null,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: SpaceDimens.space15,
                          vertical: SpaceDimens.space5,
                        ),
                        child: Center(
                          child: TextNormal(
                            textChild: categories[index].name,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
