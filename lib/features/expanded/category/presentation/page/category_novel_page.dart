import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/card/card_novel_full_info.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/features/expanded/category/presentation/controller/category_controller.dart';
import 'package:reading_app/features/expanded/category/presentation/controller/category_novel_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryNovelPage extends GetView<CategoryNovelController> {
  const CategoryNovelPage({super.key});

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
              title: TextMediumSemiBold(
                textChild: controller.title.value,
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
            Obx(() {
              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpaceDimens.spaceStandard,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >=
                          controller.listDataChangeCategory.value.length) {
                        // Display loading indicator at the end
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CardNovelFullInfo(
                        heightImage: 12.h,
                        bookModel:
                            // ignore: invalid_use_of_protected_member
                            controller.listDataChangeCategory.value[index],
                        currentIndex: index,
                        last: index ==
                            // ignore: invalid_use_of_protected_member
                            controller.listDataChangeCategory.value.length - 1,
                      );
                    },
                    childCount: controller.isLoading.value
                        ? controller.listDataChangeCategory.value.length + 1
                        : controller.listDataChangeCategory.value.length,
                  ),
                ),
              );
            })
          ],
        );
      },
    ));
  }
}
