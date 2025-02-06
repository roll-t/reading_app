import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/features/content/explores/presentation/controller/explore_controller.dart';
import 'package:reading_app/features/content/explores/presentation/widgets/build_category_filter.dart';
import 'package:reading_app/features/content/explores/presentation/widgets/build_list_comic.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ExploreComicTypePage extends GetView<ExploreController> {
  const ExploreComicTypePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomScrollView(
            shrinkWrap: true,
            slivers: [
              _buildFilterByCategory(),
              _buildHeaderTabBarTypeList(),
            ],
          ),
          _buildBodyTabBarTypeList(),
        ],
      ),
    );
  }

  Expanded _buildBodyTabBarTypeList() {
    return Expanded(
      child: TabBarView(
        controller: controller.tabController,
        children: [
          Obx(
            () {
              return CustomScrollView(
                slivers: [
                  BuildListComic(
                    isLoading: controller.isDataLoading.value,
                    listBookData: controller.dataComicCategoryByType.value,
                  ),
                  if (controller.isLoadMore.value == true)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    )
                ],
              );
            },
          ),
          CustomScrollView(
            slivers: [
              controller.isDataLoading.value
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    )
                  : BuildListComic(
                      listBookData:
                          controller.dataComicCategoryByTypeAndStatus.value,
                    ),
            ],
          )
        ],
      ),
    );
  }

  SliverPadding _buildHeaderTabBarTypeList() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: TabBar(
          controller: controller.tabController,
          unselectedLabelColor: AppColors.gray2,
          dividerColor: AppColors.secondaryDarkBg,
          labelColor: AppColors.accentColor,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2,
              color: AppColors.accentColor,
            ),
          ),
          tabs: const [
            TextNormal(textChild: "Tất cả"),
            TextNormal(textChild: "Hoàn thành"),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildFilterByCategory() {
    return SliverToBoxAdapter(
      child: Obx(
        () => BuildCategoryFilter(
          isLoading: controller.isLoading.value,
          currentIndex: controller.currentIndexCategory,
          categories: controller.categories ?? [],
        ),
      ),
    );
  }
}
