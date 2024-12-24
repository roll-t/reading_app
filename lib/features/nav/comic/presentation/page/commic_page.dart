import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';
import 'package:reading_app/core/ui/widgets/card/card_row_widget.dart';
import 'package:reading_app/core/ui/widgets/card/comic_card_widget.dart';
import 'package:reading_app/core/ui/widgets/carousel/carousel_comic.dart';
import 'package:reading_app/core/ui/widgets/loading.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/ui/widgets/wrap/wrap_list_widget.dart';
import 'package:reading_app/features/nav/comic/presentation/controller/commic_controller.dart';
import 'package:reading_app/features/nav/comic/presentation/widgets/build_section_list_widget.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_list_select_category.dart';
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
        _buildAppBar(),
        _buildSlider(),
        _buildSpacing(),
        _buildListComicRecommend(),
        _buildSpacing(),
        _buildListComicComplete(),
        _buildSpacing(),
        _buildComicCategories(),
        _buildSpacing(),
        _buildListComic(0),
        _buildSpacing(),
        _buildListComic(1),
        _buildSpaceWithBottom(),
      ],
    );
  }

  SliverToBoxAdapter _buildSpacing() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 6.w,
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      title: TextWidget(
        text: TextFormat.capitalizeEachWord(AppContents.commic),
        size: TextDimens.textSize18,
        fontWeight: FontWeight.w500,
      ),
      actions: [
        InkWell(
            onTap: () {
              Get.toNamed(Routes.search);
            },
            child: const Icon(Icons.search)),
        const SizedBox(width: SpaceDimens.spaceStandard),
      ],
      expandedHeight: 60.0,
    );
  }

  SliverToBoxAdapter _buildSlider() {
    return SliverToBoxAdapter(child: Obx(() {
      return controller.homeData.value.items.isNotEmpty
          ? CarouselComic.buildCarouselSlider(
              indexValue: 0.obs, listBook: controller.homeData.value)
          : const SizedBox();
    }));
  }

  SliverToBoxAdapter _buildListComicComplete() {
    return SliverToBoxAdapter(
      child: Obx(() {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: BuildSectionListWidget(
            titleList: "Hoàn thành",
            seeMore: () {
              controller.toDetailListBySlug(slug: "hoan-thanh");
            },
            books: controller.listCommitComplete.value.items,
          ),
        );
      }),
    );
  }

  SliverToBoxAdapter _buildListComicRecommend() {
    return SliverToBoxAdapter(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final books = controller.getFirstNineItemsFromHomeData();
        return books.isEmpty
            ? const Center(child: Text("No data available"))
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: BuildSectionListWidget(
                  isHorizontal: true,
                  titleList: "Đề xuất",
                  seeMore: () {
                    controller.toDetailListBySlug(slug: "homeData");
                  },
                  books: books,
                ),
              );
      }),
    );
  }

  SliverToBoxAdapter _buildComicCategories() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Obx(() {
            return BuildListSelectCategory(
              currentIndex: controller.currentIndexCategory.value,
              listCategory: controller.categories,
              onTap: (index) async {
                controller.currentIndexCategory.value = index;
                String categorySlug = controller.categories[index].slug;
                if (categorySlug.isNotEmpty) {
                  await controller.fetchDataComicCategoryByChange(
                      slug: categorySlug);
                }
              },
            );
          }),
          SizedBox(height: 3.w),
          Obx(() {
            final items = controller.listDataChangeCategory.value.items;
            if (items.isEmpty) {
              return const SizedBox.shrink();
            }

            const int countComicDisplay = 5;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                children: [
                  ...List.generate(
                    items.length > countComicDisplay
                        ? countComicDisplay
                        : items.length,
                    (i) => CardRowWidget(
                      heightImage: 13.h,
                      bookModel: items[i],
                      currentIndex: i,
                      last: i == countComicDisplay - 1,
                    ),
                  ),

                  // Nút "Xem thêm"
                  ButtonWidget(
                    textChild: AppContents.seeMore,
                    onTap: () {
                      controller.toDetailListBySlug(
                        slug: controller.getSlugByTitlePage(
                          title:
                              controller.listDataChangeCategory.value.titlePage,
                        ),
                      );
                    },
                    rounder: true,
                    padding: const EdgeInsets.symmetric(
                        vertical: SpaceDimens.space10),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildSpaceWithBottom() {
    return SliverToBoxAdapter(
      child: SizedBox(height: 10.h),
    );
  }

  SliverToBoxAdapter _buildListComic(int index) {
    return SliverToBoxAdapter(
      child: Obx(() {
        try {
          if (controller.listDataComicCategoryBySlug.isEmpty) {
            return const SizedBox.shrink();
          }

          final comicCategory = controller.listDataComicCategoryBySlug[index];

          if (comicCategory.items.isEmpty) {
            return const SizedBox.shrink();
          }

          final items = comicCategory.items;
          const lengthList = 12;

          return wrapListWidget(
            maxLength: lengthList,
            titleList: comicCategory.titlePage,
            seeMore: () {
              controller.toDetailListBySlug(
                  slug: controller.getSlugByTitlePage(
                      title: comicCategory.titlePage));
            },
            maxCol: 4,
            cardBuilder: (index, widthCard) {
              final item = items[index];
              return ComicCardWidget(
                heightImage: 15.h,
                width: widthCard,
                slug: item.slug,
                comicId: item.id,
                comicTitle: item.name,
                thumbUrl: item.thumbUrl,
              );
            },
          );
        } catch (e) {
          return Center(child: Text('Lỗi khi tải dữ liệu: $e'));
        }
      }),
    );
  }
}
