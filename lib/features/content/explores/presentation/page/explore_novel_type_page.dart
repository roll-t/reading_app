import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/features/content/explores/presentation/controller/explore_novel_type_controller.dart';
import 'package:reading_app/features/content/explores/presentation/widgets/build_category_filter_novel.dart';
import 'package:reading_app/features/content/explores/presentation/widgets/build_list_novel.dart';

class ExploreNovelTypePage extends GetView<ExploreNovelTypeController> {
  const ExploreNovelTypePage({super.key});

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
                  BuildListNovel(
                    isLoading: controller.isDataLoading.value,
                    // ignore: invalid_use_of_protected_member
                    listBookData: controller.listNovel.value,
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
                () => BuildListNovel(
                  isLoading: controller.isDataLoading.value,
                  // ignore: invalid_use_of_protected_member
                  listBookData: controller.listNovelComplete.value,
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
        () => BuildCategoryFilterNovel(
          isLoading: controller.isLoading.value,
          currentIndex: controller.currentIndexCategoryNovel,
          categories: controller.categoriesNovel,
        ),
      ),
    );
  }
}
