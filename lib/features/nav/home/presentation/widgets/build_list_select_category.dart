import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/custom_backgound/background_gradient.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal_semi_bold.dart';

class BuildListSelectCategory extends StatelessWidget {
  final int currentIndex;
  final List<String> listCategory;
  final Function(int) onTap; // Change VoidCallback to Function(int)
  const BuildListSelectCategory({
    super.key,
    required this.currentIndex,
    required this.listCategory,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: SpaceDimens.space40, bottom: SpaceDimens.space20),
      height: TextDimens.textNormal + ((SpaceDimens.space15 - 2) * 2),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listCategory.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                onTap(index); // Update current index when item is clicked
              },
              child: Container(
                  margin: const EdgeInsets.only(right: SpaceDimens.space10),
                  padding: const EdgeInsets.symmetric(
                      vertical: SpaceDimens.space10,
                      horizontal: SpaceDimens.space15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.tertiaryDarkBg,
                    gradient: currentIndex == index
                        ? BackgroundGradient.gradientButton()
                        : null,
                  ),
                  child: TextNormalSemiBold(
                    textChild: listCategory[index],
                    colorChild: currentIndex != index
                        ? AppColors.gray2
                        : AppColors.white,
                  )),
            );
          }),
    );
  }
}
