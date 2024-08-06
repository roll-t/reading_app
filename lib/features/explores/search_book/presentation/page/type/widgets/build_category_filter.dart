  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/button/button_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';

  class BuildCategoryFilter extends StatelessWidget {
    final RxInt currentIndex;
    const BuildCategoryFilter({
      super.key,
      required this.currentIndex,
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
                          height: Get.height *
                              0.5, // Set the height of the bottom sheet
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const TextLargeSemiBold(
                                  textChild: AppContents.selectCategory),
                              Expanded(
                                child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: 10,
                                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Obx(
                                      () => FittedBox(
                                        child: InkWell(
                                          onTap: () {
                                            currentIndex.value = index;
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(SpaceDimens.space5),
                                            decoration: BoxDecoration(
                                              color: currentIndex.value == index
                                                  ? AppColors.accentColor
                                                  : AppColors.black,
                                              border: currentIndex.value != index
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
                                            child: const Center(
                                              child: TextNormal(
                                                textChild: "Tất cả",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ButtonNormal(
                                paddingChild: const EdgeInsets.symmetric(
                                  vertical: SpaceDimens.space5,
                                ),
                                backgroundChild: AppColors.accentColor,
                                textChild: "Xong",
                                onTap: () {
                                  Navigator.pop(
                                      context); // Close the bottom sheet
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                
                  },
                  icon: const Icon(
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        currentIndex.value = index;
                      },
                      child: Obx(
                        () => Container(
                          margin:
                              const EdgeInsets.only(right: SpaceDimens.space10),
                          decoration: BoxDecoration(
                            color: currentIndex == index
                                ? AppColors.accentColor
                                : AppColors.black,
                            border: currentIndex != index
                                ? Border.all(color: AppColors.gray2)
                                : null,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: SpaceDimens.space15,
                            vertical: SpaceDimens.space5,
                          ),
                          child: const Center(
                            child: TextNormal(
                              textChild: "Tất cả",
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