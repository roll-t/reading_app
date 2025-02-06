import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/services/api/data/entities/models/category_model.dart';
import 'package:reading_app/core/ui/dialogs/custom_bottom_sheet.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/utils/string_utils.dart';
import 'package:reading_app/features/content/categories/comics/data/models/category_arument_model.dart';
import 'package:reading_app/features/dashboard/home/presentation/navigators/navigator_home_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildListTagCategory extends StatelessWidget {
  final List<CategoryModel> listCategory;
  final List<String> listType;
  final String? titleSection;

  const BuildListTagCategory({
    super.key,
    this.listType = const [],
    this.titleSection,
    this.listCategory = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: titleSection ?? "Kho Truyện tranh",
            size: TextDimens.textSize18,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 1.h),
          Wrap(
            spacing: SpaceDimens.space10,
            runSpacing: SpaceDimens.space10,
            children: [
              // Danh sách loại truyện
              ...listType.map((type) => TagCategory(
                  typeTag: type,
                  categoryName: StringUtils.translate(type),
                  onTap: () {
                    NavigatorHomePage.toCategoryPage(
                        CategoryArgumentModel(slug: type));
                  })),

              // Danh sách thể loại truyện
              ...listCategory
                  .take((listCategory.length / 4).ceil())
                  .map((category) => TagCategory(
                      categoryName: category.name,
                      onTap: () {
                        NavigatorHomePage.toCategoryPage(
                            CategoryArgumentModel(slug: category.slug));
                      })),

              // Nút "Xem thêm"
              TagCategory(
                  categoryName: "${AppContents.seeMore} +",
                  onTap: () {
                    _showCategoryBottomSheet(context);
                  }),
            ],
          ),
        ],
      ),
    );
  }

  /// Hiển thị danh sách tất cả thể loại trong BottomSheet
  void _showCategoryBottomSheet(BuildContext context) {
    CustomBottomSheetWidget(
      heightSheet: 85.h,
      context,
      viewItems: [
        Padding(
          padding: EdgeInsets.only(left: 5.w, bottom: 2.h, top: 2.h),
          child: TextWidget(
            text: AppContents.type,
            size: TextDimens.textSize18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Wrap(
            spacing: 2.h,
            runSpacing: 2.h,
            children: listCategory.map((category) {
              return TagCategory(
                  categoryName: category.name,
                  onTap: () {
                    NavigatorHomePage.toCategoryPage(
                        CategoryArgumentModel(slug: category.slug));
                  });
            }).toList(),
          ),
        ),
        SizedBox(height: 5.h),
      ],
    ).show(context);
  }
}
