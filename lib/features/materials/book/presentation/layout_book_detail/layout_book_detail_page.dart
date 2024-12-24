import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/data/dto/response/category_response.dart';
import 'package:reading_app/core/service/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/service/data/model/chapter_novel_model.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/core/ui/widgets/loading.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/core/ui/widgets/text/expandable_text.dart';
import 'package:reading_app/core/ui/widgets/textfield/custom_search_field.dart';
import 'package:reading_app/features/materials/book/model/info_book_detail_model.dart';
import 'package:reading_app/features/materials/book/model/info_comic_read_now_argument_model.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/layout_book_detail_controller.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/shared/build_sliver_app_bar_book_detail.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/widgets/build_bottom_book_detail.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/widgets/build_chapter_comic_body.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/widgets/build_chapter_novel_body.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/widgets/build_wrap_list_comment.dart';
import 'package:reading_app/features/materials/comic/presentation/controllers/comic_detail_controller.dart';
import 'package:reading_app/features/materials/novel/presentation/controller/novel_detail_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class LayoutBookDetailPage extends GetView<LayoutBookDetailController> {
  final String? uid;
  final NovelDetailController? novelDetailController;
  final ComicDetailController? comicDetailController;
  final RxBool isLoading;
  final InfoBookDetailModel infoBookDetailModel;
  final List<ChapterNovelModel> listChapter;
  final List<dynamic>? listChapterComic;
  final List<CategoryModel>? categories;
  final List<CategoryResponse>? categoriesNovel;
  final List<CommentResponse>? lisComment;
  final String? novelId;
  final String? comicId;

  LayoutBookDetailPage({
    super.key,
    required this.infoBookDetailModel,
    this.comicDetailController,
    required this.isLoading,
    this.categories,
    this.uid,
    this.novelDetailController,
    this.lisComment,
    this.listChapterComic,
    this.novelId,
    this.comicId,
    this.categoriesNovel,
    this.listChapter = const <ChapterNovelModel>[],
  });

  Timer? debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Loading(
        isLoading: isLoading,
        bodyBuilder: NestedScrollView(
          controller: controller.scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              BuildSliverAppBarBookDetail(
                opacityAppBarTitle: controller.opacity,
                infoBookDetailModel: infoBookDetailModel,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  child: TabBar(
                    controller: controller.tabController,
                    isScrollable: false,
                    dividerColor: AppColors.gray3,
                    labelColor: AppColors.accentColor,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.accentColor,
                      ),
                    ),
                    tabs: const [
                      Tab(text: AppContents.info),
                      Tab(text: AppContents.chapter),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: SpaceDimens.space10,
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: controller.tabController,
            children: [
              _buildRefreshIndicator(),
              _buildChapterTab(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => isLoading.value
          ? const SizedBox()
          : BuildBottomNavBookDetail(
              infoComicReadNowArgumentModel: InfoComicReadNowArgumentModel(
                slug: comicDetailController?.slugArgument ?? "",
                title: comicDetailController?.comicModel.title ?? "",
                thumb: comicDetailController?.comicModel.thumb ?? "",
              ),
              readingComicBookCaseModel: controller.readingComicBookCaseModel,
              listChapterNovel: listChapter,
              bookCaseResponse: controller.bookCaseModel,
              novelId: novelId,
              listChapterComic: listChapterComic,
              uid: uid,
            )),
    );
  }

  Widget _buildRefreshIndicator() {
    return RefreshIndicator(
      onRefresh: () async {
        if (novelDetailController != null) {
          await novelDetailController!.loadNovelDetails();
        }
        if (comicDetailController != null) {
          await comicDetailController?.loadComicDetail();
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SpaceDimens.spaceStandard),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: SpaceDimens.space20),
                  _buildCategoryTags(),
                  const TextMediumSemiBold(textChild: AppContents.description),
                  const SizedBox(height: SpaceDimens.space10),
                  ExpandableText(text: infoBookDetailModel.description ?? ""),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BuildWrapListComment(
              bookTitle: novelDetailController?.novelModel.name ?? "",
              novelId: novelId,
              listComment: lisComment ?? [],
              titleList: AppContents.comment,
              heightWrapList: 24.h,
              widthCard: 70.w,
              toDetail: () async {
                await _navigateToCommentPage();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextMediumSemiBold(textChild: AppContents.type),
        Container(
          padding: const EdgeInsets.only(
              bottom: SpaceDimens.space10, top: SpaceDimens.space10),
          margin: const EdgeInsets.only(bottom: SpaceDimens.space30),
          width: 100.w,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: AppColors.gray3, width: .5))),
          child: Wrap(
            spacing: SpaceDimens.space10,
            runSpacing: SpaceDimens.space10,
            children: [
              ...?categories
                  ?.map((value) => _buildCategoryTag(value, Routes.category)),
              ...?categoriesNovel?.map((value) => _buildCategoryTag(
                  controller.convertToCategoryModel(value),
                  Routes.categoryNovel)),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCategoryTag(CategoryModel value, String route) {
    return InkWell(
      onTap: () {
        Get.offAndToNamed(route, arguments: {"slugQuery": value.slug});
      },
      child: TagCategory(categoryName: value.name),
    );
  }

  Future<void> _navigateToCommentPage() async {
    if (novelId != null) {
      await Get.toNamed(Routes.comment, arguments: {"novelId": novelId});
      await novelDetailController?.loadNovelDetails();
    } else if (comicId != null) {
      await Get.toNamed(Routes.comment, arguments: {"comicId": comicId});
      await comicDetailController?.loadComicDetail();
    }
  }

  Widget _buildChapterTab() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SpaceDimens.spaceStandard,
        vertical: SpaceDimens.space15,
      ),
      child: Column(
        children: [
          CustomSearchField(
            onChanged: (value) {
              debounce?.cancel();
              debounce = Timer(const Duration(milliseconds: 300), () {
                controller.searchQuery = value;
                controller.filteredChapters.value =
                    controller.filterChapters(listChapter);
              });
            },
            placeholder: AppContents.searchPlaceholderChapter,
          ),
          _buildSortRow(),
          Obx(() {
            if (listChapter.isNotEmpty) {
              return BuildChapterNovelBody(
                // ignore: invalid_use_of_protected_member
                chapters: controller.filteredChapters.value.isNotEmpty
                    // ignore: invalid_use_of_protected_member
                    ? controller.filteredChapters.value
                    : listChapter,
              );
            } else {
              return BuildChapterComicBody(
                controller: comicDetailController,
                listChapterComic:
                    // ignore: invalid_use_of_protected_member
                    controller.filteredChapterComic.value.isNotEmpty
                        // ignore: invalid_use_of_protected_member
                        ? controller.filteredChapterComic.value
                        : listChapterComic ?? [],
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildSortRow() {
    return Container(
      padding: const EdgeInsets.only(
        top: SpaceDimens.space25,
        left: SpaceDimens.spaceStandard,
        right: SpaceDimens.spaceStandard,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextMediumSemiBold(textChild: AppContents.list),
          InkWell(
            onTap: () {},
            child: const Row(
              children: [
                Icon(Icons.sort, color: AppColors.gray2),
                TextNormal(
                    textChild: AppContents.newest, colorChild: AppColors.gray2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({required this.child});

  final TabBar child;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.black,
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
