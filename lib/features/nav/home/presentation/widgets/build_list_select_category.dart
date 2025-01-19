import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/service/data/model/list_category_model.dart';
import 'package:reading_app/core/ui/widgets/background/background_gradient.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal_semi_bold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildListSelectCategory extends StatelessWidget {
  final int currentIndex;
  final List<ListCategoryModel> ? listCategory;
  final Function(int) onTap;
  const BuildListSelectCategory({
    super.key,
    required this.currentIndex,
    this.listCategory,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TextDimens.textNormal + ((SpaceDimens.space15 - 2) * 2),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listCategory?.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                onTap(index);
              },
              child: Container(
                  margin: EdgeInsets.only(left: 3.w),
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
                    textChild: listCategory?[index].name??"",
                    colorChild: currentIndex != index
                        ? AppColors.gray2
                        : AppColors.white,
                  )),
            );
          }),
    );
  }
}
