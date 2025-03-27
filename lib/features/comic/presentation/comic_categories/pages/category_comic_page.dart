import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/card/card_row_widget.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_medium_semi_bold.dart';
import 'package:reading_app/features/comic/presentation/comic_categories/controllers/category_comic_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

///**********************************
/// CREATE TIME - 11/03/2025
///
/// **USED IN:**
/// - ` comic features`
///
/// **EXPLANATION:**
///  Display comic by category type and load more comic when scroll to last position page.
///*********************************/

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.headerBackground,
            floating: true,
            snap: true,
            title: Obx(
              () => TextMediumSemiBold(
                textChild: controller.listComicFollowCategory.value.titlePage,
              ),
            ),
            centerTitle: true,
            expandedHeight: 60.0,
            leading: const leadingIconAppBar(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: AppDimens.space25,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.spaceStandard,
            ),
            sliver: Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index >=
                        controller.listComicFollowCategory.value.items.length) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CardRowWidget(
                      heightImage: 12.h,
                      bookModel:
                          controller.listComicFollowCategory.value.items[index],
                      currentIndex: index,
                      last: index ==
                          controller
                                  .listComicFollowCategory.value.items.length -
                              1,
                    );
                  },
                  childCount: controller.isLoading.value
                      ? controller.listComicFollowCategory.value.items.length +
                          1
                      : controller.listComicFollowCategory.value.items.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
