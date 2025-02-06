import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';
import 'package:reading_app/core/ui/widgets/card/card_row_widget.dart';
import 'package:reading_app/core/ui/widgets/card/comic_card_widget.dart';
import 'package:reading_app/core/ui/widgets/carousel/carousel_comic.dart';
import 'package:reading_app/core/ui/widgets/loading.dart';
import 'package:reading_app/core/ui/widgets/shimmer/shimmer_carousel.dart';
import 'package:reading_app/core/ui/widgets/shimmer/simular_card_row_widget.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/ui/widgets/wrap/wrap_list_widget.dart';
import 'package:reading_app/features/content/categories/comics/data/models/category_arument_model.dart';
import 'package:reading_app/features/dashboard/comic/presentation/controller/comic_controller.dart';
import 'package:reading_app/features/dashboard/comic/presentation/navigators/navigator_comic_page.dart';
import 'package:reading_app/features/dashboard/comic/presentation/widgets/build_section_list_widget.dart';
import 'package:reading_app/features/dashboard/home/presentation/widgets/build_list_select_category.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommicPage extends GetView<ComicController> {
  const CommicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Loading(
        isLoading: false.obs,
        isLoadMore: controller.isLoadMore,
        bodyBuilder: _buildBody(),
      ),
    );
  }

  CustomScrollView _buildBody() {
    return CustomScrollView(
      controller: controller.scrollController,
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
        _buildListComics(),
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
              NavigatorComicPage.toSearchPage();
            },
            child: const Icon(Icons.search)),
        const SizedBox(width: SpaceDimens.spaceStandard),
      ],
      expandedHeight: 60.0,
    );
  }

  SliverToBoxAdapter _buildSlider() {
    return SliverToBoxAdapter(
      child: Obx(() {
        if (controller.isLoading.value) {
          return Column(
            children: [
              ShimmerCarousel.buildShimmerCarousel(5),
            ],
          );
        } else {
          return Column(
            children: [
              CarouselComic.buildCarouselSlider(
                indexValue: controller.currentIndex,
                listBook: controller.homeData!.value,
              ),
            ],
          );
        }
      }),
    );
  }

  SliverToBoxAdapter _buildListComicComplete() {
    return SliverToBoxAdapter(
      child: GetBuilder<ComicController>(
          id: "listCompleteID",
          builder: (_) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: BuildSectionListWidget(
                simuler: true,
                titleList: controller.completedComics?.value.titlePage,
                seeMore: () {
                  NavigatorComicPage.toCategoryPage(
                    CategoryArgumentModel(slug: "hoan-thanh"),
                  );
                },
                books: controller.completedComics?.value.items,
              ),
            );
          }),
    );
  }

  SliverToBoxAdapter _buildListComicRecommend() {
    return SliverToBoxAdapter(
        child: GetBuilder<ComicController>(
      id: "listRecommendID",
      builder: (_) {
        final books = controller.getFirstNineItemsFromHome();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: BuildSectionListWidget(
            isHorizontal: true,
            simuler: true,
            titleList: "Đề xuất",
            seeMore: () {
              NavigatorComicPage.toCategoryRecommendPage();
            },
            books: books,
          ),
        );
      },
    ));
  }

  SliverToBoxAdapter _buildComicCategories() {
    return SliverToBoxAdapter(
      child: GetBuilder<ComicController>(
        id: "listCategoryID",
        builder: (_) => (controller.categories?.isEmpty ?? true)
            ? const SizedBox.shrink()
            : Column(
                children: [
                  Obx(() {
                    return BuildListSelectCategory(
                      currentIndex: controller.currentIndexCategory.value,
                      listCategory: controller.categories,
                      onTap: (index) async {
                        controller.currentIndexCategory.value = index;
                        String categorySlug =
                            controller.categories?[index].slug ?? "";
                        if (categorySlug.isNotEmpty) {
                          await controller
                              .fetchComicsForSelectedCategory(categorySlug);
                        }
                      },
                    );
                  }),
                  SizedBox(height: 3.w),
                  Obx(() {
                    final items =
                        controller.selectedCategoryComics?.value.items;
                    const int countComicDisplay = 5;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Column(
                        children: [
                          ...List.generate(
                            countComicDisplay,
                            (i) =>
                                (controller.isLoadProcessCategoryComics.value)
                                    ? SimularCardRowWidget(heightImage: 13.h)
                                    : CardRowWidget(
                                        heightImage: 13.h,
                                        bookModel: items?[i],
                                        currentIndex: i,
                                        last: i == countComicDisplay - 1,
                                      ),
                          ),

                          // Nút "Xem thêm"
                          ButtonWidget(
                            textChild: AppContents.seeMore,
                            onTap: () {
                              NavigatorComicPage.toCategoryPage(
                                  CategoryArgumentModel(
                                slug: controller.getSlugByTitle(
                                  controller.selectedCategoryComics?.value
                                          .titlePage ??
                                      "",
                                ),
                              ));
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
      ),
    );
  }

  SliverToBoxAdapter _buildListComics() {
    return SliverToBoxAdapter(
      child: Obx(() {
        try {
          // Kiểm tra nếu danh sách comicsByCategory rỗng
          if (controller.comicsByCategory.isEmpty) {
            return const SizedBox.shrink();
          }

          // Duyệt qua từng danh mục trong comicsByCategory và tạo widget
          final widgets = controller.comicsByCategory.map((comicCategory) {
            if (comicCategory.items.isEmpty) {
              return const SizedBox.shrink();
            }

            final items = comicCategory.items;
            const lengthList = 12;

            return wrapListWidget(
              maxLength: lengthList,
              titleList: comicCategory.titlePage,
              spacingWithBottom: 5.w,
              seeMore: () {
                NavigatorComicPage.toCategoryPage(
                  CategoryArgumentModel(
                    slug: controller.getSlugByTitle(comicCategory.titlePage),
                  ),
                );
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
          }).toList();

          // Trả về danh sách các widget dạng Column
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          );
        } catch (e) {
          return Center(child: Text('Lỗi khi tải dữ liệu: $e'));
        }
      }),
    );
  }
}
