import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/features/content/explores/presentation/controller/explore_comic_type_controller.dart';
import 'package:reading_app/features/content/explores/presentation/widgets/build_category_filter_comic.dart';
import 'package:reading_app/features/content/explores/presentation/widgets/build_list_comic.dart';

class ExploreComicTypePage extends GetView<ExploreComicTypeController> {
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
                controller: controller.scrollController,
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
              Obx(
                () => BuildListComic(
                  isLoading: controller.isDataLoading.value,
                  listBookData:
                      controller.dataComicCategoryByTypeAndStatus.value,
                ),
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
        () => BuildCategoryFilterComic(
          isLoading: controller.isLoading.value,
          currentIndex: controller.currentIndexCategory,
          categories: controller.categories ?? [],
        ),
      ),
    );
  }
}
