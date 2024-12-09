import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/card/card_full_info_follow_row.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/features/materials/category/presentation/controller/category_controller.dart';

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

                        return CardFullInfoFollowRow(
                          heightImage: 120,
                          bookModel: controller
                              .listDataChangeCategory.value.items[index],
                          currentIndex: index,
                          last: index ==
                              controller.listDataChangeCategory.value.items
                                      .length -
                                  1,
                          domain: controller
                              .listDataChangeCategory.value.domainImage,
                        );
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
