import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/service/service/model/list_comic_model.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';
import 'package:reading_app/core/ui/widgets/card/card_full_info_follow_row.dart';
import 'package:reading_app/core/ui/widgets/card/card_newest_update.dart';
import 'package:reading_app/core/ui/widgets/carousel_slider/carousel_comic.dart';
import 'package:reading_app/core/ui/widgets/loading.dart';
import 'package:reading_app/features/nav/comic/presentation/controller/commic_controller.dart';
import 'package:reading_app/features/nav/comic/presentation/widgets/build_list_column_category.dart';
import 'package:reading_app/features/nav/comic/presentation/widgets/build_sliver_commic_app_bar.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_list_select_category.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_wrap_grid_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommicPage extends GetView<CommicController> {
  const CommicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Loading(isLoading: controller.isLoading, bodyBuilder: _buildBody()),
    );
  }

  CustomScrollView _buildBody() {
    return CustomScrollView(
      slivers: [
        const BuildSliverCommicAppBar(),
        SliverToBoxAdapter(child: Obx(() {
          return controller.homeData.value.items.isNotEmpty
              ? CarouselComic.buildCarouselSlider(
                  indexValue: 0.obs, listBook: controller.homeData.value)
              : const SizedBox();
        })),

        SliverToBoxAdapter(
          child: Obx(() {
            return BuildListColumnCategory(
              titleList: "Nổi bật",
              seeMore: () {
                controller.toDetailListBySlug(slug: "homeData");
              },
              controller: controller,
              listBook: controller.getFirstNineItemsFromHomeData(),
              domain: controller.listCommitComplete.value.domainImage,
            );
          }),
        ),

        // list category 1
        SliverToBoxAdapter(
          child: Obx(() {
            return BuildListColumnCategory(
              titleList: "Hoàn thành",
              seeMore: () {
                controller.toDetailListBySlug(slug: "hoan-thanh");
              },
              controller: controller,
              listBook: controller.listCommitComplete.value.items,
              domain: controller.listCommitComplete.value.domainImage,
            );
          }),
        ),

        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: SpaceDimens.spaceStandard),
            child: Column(
              children: [
                Obx(() {
                  return BuildListSelectCategory(
                    currentIndex: controller.currentIndexCategory.value,
                    // ignore: invalid_use_of_protected_member
                    listCategory: controller.categories.value,
                    onTap: (index) async {
                      controller.currentIndexCategory.value = index;
                      String categorySlug =
                          controller.categories?[index].slug ?? "";
                      if (categorySlug.isNotEmpty) {
                        await controller.fetchDataComicCategoryByChange(
                            slug: categorySlug);
                      }
                    },
                  );
                }),
                Obx(() {
                  return Column(
                    children: [
                      if (controller.listDataChangeCategory.value.items.length >
                          4)
                        for (var i = 0; i < 5; i++)
                          CardFullInfoFollowRow(
                            domain: controller
                                .listDataChangeCategory.value.domainImage,
                            heightImage: 13.h,
                            bookModel: controller
                                .listDataChangeCategory.value.items[i],
                            currentIndex: i,
                            last: i ==
                                controller.listDataChangeCategory.value.items
                                        .length -
                                    1,
                          ),
                      // "See More" button
                      ButtonWidget(
                        textChild: AppContents.seeMore,
                        onTap: () {
                          controller.toDetailListBySlug(
                              slug: controller.getSlugByTitlePage(
                                  title: controller
                                      .listDataChangeCategory.value.titlePage));
                        },
                        rounder: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: SpaceDimens.space10),
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(child: Obx(() {
          ListComicModel? listComic;
          try {
            listComic = controller.listDataComicCategoryBySlug.value[0];
          } catch (e) {
            print(e);
          }
          return (listComic != null)
              ? BuildWrapGridCard(
                  margin: const EdgeInsets.only(top: SpaceDimens.space40),
                  heightCardItem: 40.h,
                  title: listComic.titlePage,
                  maxLength: 9,
                  seeMore: () {
                    controller.toDetailListBySlug(
                        slug: controller.getSlugByTitlePage(
                            title: listComic?.titlePage ?? ''));
                  },
                  columns: 3,
                  childAspectRatio: 1.65 / 3,
                  heightImage: 18.h,
                  listBookData: listComic.items,
                  spacingCol: 3.w,
                  spacingRow: 3.w,
                  cardChild: (double heightImage, bookModel) {
                    return CardNewestUpdate(
                      heightImage: heightImage,
                      bookModel: bookModel,
                      domainImage: listComic?.domainImage ?? "",
                    );
                  },
                )
              : const SizedBox.shrink();
        })),

        SliverToBoxAdapter(child: Obx(() {
          ListComicModel? listComic;
          try {
            // ignore: invalid_use_of_protected_member
            listComic = controller.listDataComicCategoryBySlug.value[1];
          } catch (e) {
            print(e);
          }
          return (listComic != null)
              ? BuildWrapGridCard(
                  margin: const EdgeInsets.only(top: SpaceDimens.space40),
                  heightCardItem: 40.h,
                  title: listComic.titlePage,
                  maxLength: 9,
                  seeMore: () {
                    controller.toDetailListBySlug(
                        slug: controller.getSlugByTitlePage(
                            title: listComic?.titlePage ?? ''));
                  },
                  columns: 3,
                  childAspectRatio: 1.65 / 3,
                  heightImage: 18.h,
                  // ignore: invalid_use_of_protected_member
                  listBookData: listComic.items,
                  spacingCol: 3.w,
                  spacingRow: 3.w,
                  cardChild: (double heightImage, bookModel) {
                    return CardNewestUpdate(
                      heightImage: heightImage,
                      bookModel: bookModel,
                      domainImage: listComic?.domainImage ?? "",
                    );
                  },
                )
              : const SizedBox.shrink();
        })),

        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }
}
