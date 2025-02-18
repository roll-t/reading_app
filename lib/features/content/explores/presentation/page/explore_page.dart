import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/features/content/explores/presentation/controller/explore_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchBookPage extends GetView<ExploreController> {
  const SearchBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  // Build Body Explore page
  Widget _buildBody() {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        _buildAppBar(),
      ],
      body: Obx(() => TabBarView(
            controller: controller.tabController,
            // ignore: invalid_use_of_protected_member
            children: controller.listPage.value,
          )),
    );
  }

  // build AppBar explore page
  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: true,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      title: GestureDetector(
        onTap: () {
          if (controller.currentTypePage.value == 0) {
            Get.toNamed(Routes.searchComic, arguments: {"mark": "COMIC"});
          } else {
            Get.toNamed(Routes.searchNovel, arguments: {"mark": "NOVEL"});
          }
        },
        child: Container(
          padding: const EdgeInsets.only(left: SpaceDimens.space20),
          decoration: BoxDecoration(
              color: AppColors.tertiaryDarkBg,
              borderRadius: BorderRadius.circular(RadiusDimens.radiusFull)),
          height: 6.5.h,
          width: 80.w,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextNormal(
                textChild: AppContents.searchPlaceholder,
              ),
            ],
          ),
        ),
      ),
      bottom: TabBar(
        controller: controller.tabController,
        dividerColor: AppColors.black,
        labelColor: AppColors.accentColor,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2,
            color: AppColors.accentColor,
          ),
        ),
        tabs: const [
          Tab(text: AppContents.comic),
          Tab(text: AppContents.novel),
        ],
      ),
    );
  }
}
