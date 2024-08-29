import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/data/models/list_type.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/button/button_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/custom_backgound/background_gradient.dart';
import 'package:reading_app/core/ui/widgets/card/btv_recoment_card.dart';
import 'package:reading_app/core/ui/widgets/card/card_by_category.dart';
import 'package:reading_app/core/ui/widgets/card/card_full_info_follow_row.dart';
import 'package:reading_app/core/ui/widgets/card/card_newest_update.dart';
import 'package:reading_app/core/ui/widgets/card/card_reading_continue.dart';
import 'package:reading_app/core/utils/loading.dart';
import 'package:reading_app/features/nav/home/presentation/controller/home_controller.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_buttom_to_explore.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_category.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_list_select_category.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_list_tag_category.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_slider.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_sliver_app_bar.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_wrap_grid_card.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_wrap_list_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient.gradientRedBack(
          child: Loading(
        isLoading: controller.isLoading,
        bodyBuilder: CustomScrollView(
          slivers: [
            // App bar
            const BuildSliverAppBar(
              userName: "P T",
            ),

            // home slider
            SliverToBoxAdapter(
                child: GetBuilder<HomeController>(
              id: "sliderID",
              builder: (context) {
                return BuildSlider(
                  listImage: controller.listDataSlider,
                  currentIndex: controller.currentIndex,
                );
              },
            )),

            // //build Category list
            const SliverToBoxAdapter(child: BuildCategory()),

            // build list card reading continue
            SliverToBoxAdapter(
                child: GetBuilder<HomeController>(
                    id: "ReadContinue",
                    builder: (_) {
                      return BuildWrapListCard(
                        margin: const EdgeInsets.all(0),
                        heightWrapList: 120,
                        listBookData: controller.listDataSlider.items,
                        titleList: AppContents.titleListContinue,
                        widthCard: 170,
                        cardBuilder: (double widthCard, bookModel) {
                          return CardReadingContinue(
                            domain: controller.listDataSlider.domainImage,
                            widthCard: widthCard,
                            bookModel: bookModel,
                            chapter: "chapter 5",
                          );
                        },
                      );
                    })),
            // Build list BTV đề cử
            SliverToBoxAdapter(
                child: GetBuilder<HomeController>(
                    id: "IDListNowRelease",
                    builder: (_) {
                      return BuildWrapListCard(
                        listBookData: controller.listDataNowRelease.items,
                        titleList: controller.listDataNowRelease.titlePage,
                        heightWrapList: 270,
                        widthCard: 150,
                        seeMore: () {
                          Get.toNamed(Routes.category,
                              arguments: {"slugQuery": ListType.ongoing});
                        },
                        cardBuilder: (double widthCard, bookModel) {
                          return BTVRecomentCard(
                            widthCard: widthCard,
                            heightImage: 180,
                            bookModel: bookModel,
                            domain: controller.listDataNowRelease.domainImage,
                          );
                        },
                      );
                    })),

            // // build list newest update
            SliverToBoxAdapter(
                child: GetBuilder<HomeController>(
              id: "ListNewUpdateID",
              builder: (_) {
                return BuildWrapGridCard(
                  heightCardItem: 205,
                  maxLength: 8,
                  title: controller.listDataNewest.titlePage,
                  seeMore: () {
                    Get.toNamed(Routes.category,
                        arguments: {"slugQuery": ListType.newUpdate});
                  },
                  columns: 4,
                  childAspectRatio: 0.95 /
                      2, // tỉ lệ giữa chiều rộng với chiều cao của phần tử trong Grid 1/2 có nghĩa là chiểu cao bằng 2 lần chiều rộng
                  heightImage: 120,
                  listBookData: controller.listDataNewUpdate.items,
                  spacingCol: 10,
                  spacingRow: 10,
                  cardChild: (double heightImage, bookModel) {
                    return CardNewestUpdate(
                      heightImage: 120,
                      bookModel: bookModel,
                      domainImage: controller.listDataNewUpdate.domainImage,
                    );
                  },
                );
              },
            )),

            // build category recommentaition
            const SliverToBoxAdapter(
              child: BuildListTagCategory(),
            ),

            // build list book by category
            SliverToBoxAdapter(
              child: GetBuilder<HomeController>(
                id: "listNewestID",
                builder: (_) {
                  return BuildWrapListCard(
                    titleList: controller.listDataNewest.titlePage,
                    seeMore: () {
                      Get.toNamed(Routes.category,
                          arguments: {"slugQuery": ListType.newRelease});
                    },
                    heightWrapList: 280,
                    listBookData: controller.listDataNewest.items,
                    widthCard: 150,
                    cardBuilder: (double widthCard, bookModel) {
                      return CardByCategory(
                        widthCard: widthCard,
                        heightImage: 190,
                        bookModel: bookModel,
                        domain: controller.listDataNewest.domainImage,
                      );
                    },
                  );
                },
              ),
            ),

            // build list book by category
            SliverToBoxAdapter(
                child: GetBuilder<HomeController>(
                    id: "IDListComplete",
                    builder: (_) {
                      return BuildWrapListCard(
                        margin: const EdgeInsets.only(top: SpaceDimens.space50),
                        titleList: controller.listDataComplete.titlePage,
                        seeMore: () {
                          Get.toNamed(Routes.category,
                              arguments: {"slugQuery": ListType.completed});
                        },
                        heightWrapList: 280,
                        listBookData: controller.listDataComplete.items,
                        widthCard: 150,
                        cardBuilder: (double widthCard, bookModel) {
                          return CardByCategory(
                            widthCard: widthCard,
                            heightImage: 190,
                            bookModel: bookModel,
                            domain: controller.listDataComplete.domainImage,
                          );
                        },
                      );
                    })),

            SliverToBoxAdapter(
                child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: SpaceDimens.spaceStandard),
              child: Column(
                children: [
                  Obx(() {
                    return BuildListSelectCategory(
                      currentIndex: controller.currentIndexCategory.value,
                      listCategory: controller.categories!,
                      onTap: (index) async {
                        controller.currentIndexCategory.value = index;
                        String categorySlug =
                            controller.categories?[index].slug ?? "";
                        if (categorySlug != "") {
                          await controller.fetchDataComicCategoryByChange(
                              slug: categorySlug);
                        }
                      },
                    );
                  }),
                  GetBuilder<HomeController>(
                    id: "ListCategory",
                    builder: (_) {
                      return FittedBox(
                        child: Column(
                          children: [
                            for (var i = 0; i < 5; i++)
                              CardFullInfoFollowRow(
                                domain: controller
                                    .listDataChangeCategory.domainImage,
                                heightImage: 120,
                                bookModel:
                                    controller.listDataChangeCategory.items[i],
                                currentIndex: i,
                                last: i ==
                                    controller.listDataChangeCategory.items
                                            .length -
                                        1,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  ButtonNormal(
                    textChild: AppContents.seeMore,
                    onTap: () async {
                      await controller.toDetailListBySlug(
                          slug: controller.getSlugByTitlePage(
                              title:
                                  controller.listDataChangeCategory.titlePage));
                    },
                    rounder: true,
                    paddingChild: const EdgeInsets.symmetric(
                        vertical: SpaceDimens.space10),
                  ),
                ],
              ),
            )),

            // // build list newest update
            SliverToBoxAdapter(
                child: GetBuilder<HomeController>(
                    id: "ListByCategoryID_1",
                    builder: (_) {
                      return BuildWrapGridCard(
                        margin: const EdgeInsets.only(top: SpaceDimens.space40),
                        heightCardItem: 330,
                        title:
                            controller.listDataComicCategoryBySlug[0].titlePage,
                        maxLength: 9,
                        seeMore: () async {
                          await controller.toDetailListBySlug(
                              slug: controller.getSlugByTitlePage(
                                  title: controller
                                      .listDataComicCategoryBySlug[0]
                                      .titlePage));
                        },
                        columns: 3,
                        childAspectRatio: 1.7 / 3,
                        heightImage: 150,
                        listBookData:
                            controller.listDataComicCategoryBySlug[0].items,
                        spacingCol: 10,
                        spacingRow: 10,
                        cardChild: (double heightImage, bookModel) {
                          return CardNewestUpdate(
                            heightImage: heightImage,
                            bookModel: bookModel,
                            domainImage: controller
                                .listDataComicCategoryBySlug[0].domainImage,
                          );
                        },
                      );
                    })),

            SliverToBoxAdapter(
                child: GetBuilder<HomeController>(
                    id: "ListByCategoryID_2",
                    builder: (_) {
                      return BuildWrapGridCard(
                        margin: const EdgeInsets.only(top: SpaceDimens.space40),
                        heightCardItem: 330,
                        title:
                            controller.listDataComicCategoryBySlug[1].titlePage,
                        maxLength: 9,
                        seeMore: () async {
                          await controller.toDetailListBySlug(
                              slug: controller.getSlugByTitlePage(
                                  title: controller
                                      .listDataComicCategoryBySlug[1]
                                      .titlePage));
                        },
                        columns: 3,
                        childAspectRatio: 1.7 /
                            3, // tỉ lệ giữa chiều rộng với chiều cao của phần tử trong Grid 1/2 có nghĩa là chiểu cao bằng 2 lần chiều rộng
                        heightImage: 150,
                        listBookData:
                            controller.listDataComicCategoryBySlug[1].items,
                        spacingCol: 10,
                        spacingRow: 10,
                        cardChild: (double heightImage, bookModel) {
                          return CardNewestUpdate(
                            heightImage: heightImage,
                            bookModel: bookModel,
                            domainImage: controller
                                .listDataComicCategoryBySlug[0].domainImage,
                          );
                        },
                      );
                    })),

            SliverToBoxAdapter(
                child: GetBuilder<HomeController>(
                    id: "ListByCategoryID_3",
                    builder: (_) {
                      return BuildWrapGridCard(
                        margin: const EdgeInsets.only(top: SpaceDimens.space40),
                        heightCardItem: 330,
                        title:
                            controller.listDataComicCategoryBySlug[2].titlePage,
                        maxLength: 9,
                        seeMore: () async {
                          await controller.toDetailListBySlug(
                              slug: controller.getSlugByTitlePage(
                                  title: controller
                                      .listDataComicCategoryBySlug[2]
                                      .titlePage));
                        },
                        columns: 3,
                        childAspectRatio: 1.7 /
                            3, // tỉ lệ giữa chiều rộng với chiều cao của phần tử trong Grid 1/2 có nghĩa là chiểu cao bằng 2 lần chiều rộng
                        heightImage: 150,
                        listBookData:
                            controller.listDataComicCategoryBySlug[2].items,
                        spacingCol: 10,
                        spacingRow: 10,
                        cardChild: (double heightImage, bookModel) {
                          return CardNewestUpdate(
                            heightImage: heightImage,
                            bookModel: bookModel,
                            domainImage: controller
                                .listDataComicCategoryBySlug[0].domainImage,
                          );
                        },
                      );
                    })),

            // create bottom space
            const SliverToBoxAdapter(
              child: BuildButtomToExplore(),
            ),

            // create bottom space
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
