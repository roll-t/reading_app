import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/nav/commic/presentation/controller/commic_controller.dart';
import 'package:reading_app/features/nav/commic/presentation/widgets/build_list_column_category.dart';
import 'package:reading_app/features/nav/commic/presentation/widgets/build_list_row_category.dart';
import 'package:reading_app/features/nav/commic/presentation/widgets/build_slider_commic.dart';
import 'package:reading_app/features/nav/commic/presentation/widgets/build_sliver_commic_app_bar.dart';

class CommicPage extends GetView<CommicController> {
  const CommicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const BuildSliverCommicAppBar(),
          SliverToBoxAdapter(child: BuildSliderCommic(controller: controller)),

          // list category 1
          SliverToBoxAdapter(
            child: BuildListColumnCategory(
              titleList: AppContents.hottestOfWeek,
              seeMore: () {
                Get.toNamed(Routes.category,
                    arguments: {"titleCategory": AppContents.hottestOfWeek});
              },
              controller: controller,
              listBook: controller.listData,
              maxLength: 3,
            ),
          ),

          //build list category follow row
          SliverToBoxAdapter(
            child: BuildListRowCategory(
              listBookData: controller.listData,
              titleList: AppContents.newestUpdate,
              seeMore: () {
                Get.toNamed(Routes.category,
                    arguments: {"titleCategory": AppContents.newestUpdate});
              },
            ),
          ),

          // list category 1
          SliverToBoxAdapter(
            child: BuildListColumnCategory(
              titleList: "Bão cập nhật",
              seeMore: () {
                Get.toNamed(Routes.category,
                    arguments: {"titleCategory": "Bão cập nhật"});
              },
              controller: controller,
              listBook: controller.listData,
              maxLength: 3,
            ),
          ),

          //build list category follow row
          SliverToBoxAdapter(
            child: BuildListRowCategory(
              listBookData: controller.listData,
              titleList: AppContents.newestUpdate,
              seeMore: () {
                Get.toNamed(Routes.category,
                    arguments: {"titleCategory": AppContents.newestUpdate});
              },
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
