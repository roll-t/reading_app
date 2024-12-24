import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/card/card_row_widget.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_medium_semi_bold.dart';
import 'package:reading_app/features/materials/categories/presentation/controller/category_comic_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<CategoryController>(
      id: "loadMoreID",
      builder: (_) {
        return CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.headerBackground,
              floating: true,
              snap: true,
              title: GetBuilder<CategoryController>(
                id: "titleID",
                builder: (_) => TextMediumSemiBold(
                  textChild: controller.listDataChangeCategory.value.titlePage,
                ),
              ),
              centerTitle: true,
              expandedHeight: 60.0,
              leading: const leadingIconAppBar(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: SpaceDimens.space25,
              ),
            ),
            GetBuilder<CategoryController>(
              id: "ListCategoryID",
              builder: (_) {
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpaceDimens.spaceStandard,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >=
                            controller
                                .listDataChangeCategory.value.items.length) {
                          // Display loading indicator at the end
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return CardRowWidget(
                            heightImage: 12.h,
                            bookModel: controller
                                .listDataChangeCategory.value.items[index],
                            currentIndex: index,
                            last: index ==
                                controller.listDataChangeCategory.value.items
                                        .length -
                                    1);
                      },
                      childCount: controller.isLoading.value
                          ? controller
                                  .listDataChangeCategory.value.items.length +
                              1
                          : controller
                              .listDataChangeCategory.value.items.length,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    ));
  }
}
