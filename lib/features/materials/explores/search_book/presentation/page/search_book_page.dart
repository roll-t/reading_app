import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/features/materials/explores/search_book/presentation/controller/search_book_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchBookPage extends GetView<SearchBookController> {
  const SearchBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SearchBookController>(
        id: "IDSeach",
        builder: (_) {
          return !controller.isLoading.value
              ? DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    controller: controller.scrollController,
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        floating: true,
                        pinned: true,
                        leading: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        title: InkWell(
                            onTap: () {
                              if (controller.currentTypePage.value == 0) {
                                Get.toNamed(Routes.find,
                                    arguments: {"mark": "COMIC"});
                              } else {
                                Get.toNamed(Routes.findNovel,
                                    arguments: {"mark": "NOVEL"});
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: SpaceDimens.space20),
                              decoration: BoxDecoration(
                                  color: AppColors.tertiaryDarkBg,
                                  borderRadius: BorderRadius.circular(
                                      RadiusDimens.radiusFull)),
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
                            )),
                        bottom: const TabBar(
                          dividerColor: AppColors.black,
                          labelColor: AppColors.accentColor,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 2,
                              color: AppColors.accentColor,
                            ),
                          ),
                          tabs: [
                            Tab(text: "Truyện tranh"),
                            Tab(text: "Tiểu thuyết"),
                          ],
                        ),
                      ),
                    ],
                    body: Builder(
                      builder: (context) {
                        final TabController tabController =
                            DefaultTabController.of(context);

                        tabController.addListener(() {
                          if (!tabController.indexIsChanging) {
                            controller.currentTypePage.value =
                                tabController.index;
                          }
                        });

                        return TabBarView(
                          children: controller.listPage,
                        );
                      },
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
