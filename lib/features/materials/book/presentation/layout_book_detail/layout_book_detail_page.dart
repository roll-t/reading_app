import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/service/api/dto/response/category_response.dart';
import 'package:reading_app/core/service/api/dto/response/commentReponse.dart';
import 'package:reading_app/core/service/service/model/chapter_novel_model.dart';
import 'package:reading_app/core/service/service/model/list_comic_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/widgets/loading.dart';
import 'package:reading_app/core/ui/widgets/textfield/custom_search_field.dart';
import 'package:reading_app/features/materials/book/model/info_book_detail_model.dart';
import 'package:reading_app/features/materials/book/model/info_comic_read_now_argument_model.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/layout_book_detail_controller.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/shared/build_sliver_app_bar_book_detail.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/widgets/build_bottom_book_detail.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/widgets/build_chapter_comic_body.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/widgets/build_chapter_novel_body.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/widgets/build_content_book_detail.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/widgets/build_header_tab_bar.dart';
import 'package:reading_app/features/materials/comic/presentation/controllers/comic_detail_controller.dart';
import 'package:reading_app/features/materials/novel/presentation/controller/novel_detail_controller.dart';

// ignore: must_be_immutable
class LayoutBookDetailPage extends GetView<LayoutBookDetailController> {
  String ?uid;
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

  @override
  Widget build(BuildContext context) {
    final String tag = 'bookDetail ${DateTime.now().microsecondsSinceEpoch}';
    return _BuildBodyBookDetail(tag);
  }

  // ignore: non_constant_identifier_names
  Widget _BuildBodyBookDetail(String tag) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Loading(
        isLoading: isLoading,
        bodyBuilder: BookDetailBody(
          novelId: novelId,
          comicId: comicId,
          listComment: lisComment ?? [],
          novelDetailController: novelDetailController,
          tag: tag,
          controller: controller,
          listChapter: listChapter,
          listChapterComic: listChapterComic,
          infoBookDetailModel: infoBookDetailModel,
          comicDetailController: comicDetailController,
          categories: categories,
          categoriesNovel: categoriesNovel,
        ),
      ),
      bottomNavigationBar: Obx(() => isLoading.value
          ? const SizedBox()
          : BuildBottomNavBookDetail(
              infoComicReadNowArgumentModel: InfoComicReadNowArgumentModel(
                  slug: comicDetailController?.slugArgument ?? "",
                  title: comicDetailController?.comicModel.title ?? "",
                  thumb: comicDetailController?.comicModel.thumb ?? ""),
              readingComicBookCaseModel: controller.readingComicBookCaseModel,
              listChapterNovel: listChapter,
              bookCaseResponse: controller.bookCaseModel,
              novelId: novelId,
              listChapterComic: listChapterComic,
              uid: uid,
            )),
    );
  }
}

class BookDetailBody extends StatelessWidget {
  final String? novelId;
  final String? comicId;
  final NovelDetailController? novelDetailController;
  final ComicDetailController? comicDetailController;
  final InfoBookDetailModel infoBookDetailModel;
  final List<ChapterNovelModel>? listChapter;
  final List<dynamic>? listChapterComic;
  final List<CategoryModel>? categories;
  final List<CommentResponse> listComment;
  final List<CategoryResponse>? categoriesNovel;
  const BookDetailBody({
    super.key,
    required this.tag,
    required this.controller,
    required this.listChapter,
    required this.infoBookDetailModel,
    this.categories,
    this.listChapterComic,
    this.categoriesNovel,
    required this.listComment,
    this.novelId,
    this.novelDetailController,
    this.comicId,
    this.comicDetailController,
  });
  final String tag;
  final LayoutBookDetailController controller;

  @override
  Widget build(BuildContext context) {
    return buildScrollView(context);
  }

  Widget buildScrollView(BuildContext context) {
    return NestedScrollView(
      controller: controller.scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          BuildSliverAppBarBookDetail(
            opacityAppBarTitle: controller.opacity,
            infoBookDetailModel: infoBookDetailModel,
          ),
          // tab bar
          BuildHeaderTapBar(controller: controller),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: SpaceDimens.space10,
            ),
          ),
        ];
      },
      body: _buildMainBodyBookDetail(
          description: infoBookDetailModel.description ?? "",
          chapters: listChapter ?? [],
          categoriesNovel: categoriesNovel ?? [],
          categories: categories ?? [],
          listComment: listComment),
    );
  }

  TabBarView _buildMainBodyBookDetail(
      {required List<ChapterNovelModel> chapters,
      List<CategoryModel> categories = const [],
      List<CategoryResponse> categoriesNovel = const [],
      required List<CommentResponse> listComment,
      String description = ""}) {
    Timer? debounce;
    return TabBarView(
      controller: controller.tabController,
      children: [
        BuildContentBookDetail(
          novelId: novelId,
          comicId: comicId,
          comicDetailController: comicDetailController,
          novelController: novelDetailController,
          categoriesNovel: categoriesNovel,
          description: description,
          categories: categories,
          listComment: listComment,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: SpaceDimens.spaceStandard,
              vertical: SpaceDimens.space15),
          child: Column(
            children: [
              CustomSearchField(
                onChanged: (value) {
                  if (debounce?.isActive ?? false) {
                    debounce?.cancel();
                  }
                  debounce = Timer(const Duration(milliseconds: 300), () {
                    controller.searchQuery = value;
                    controller.filteredChapters.value =
                        controller.filterChapters(chapters);
                  });
                },
                placeholder: AppContents.searchPlaceholderChapter,
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: SpaceDimens.space25,
                    left: SpaceDimens.spaceStandard,
                    right: SpaceDimens.spaceStandard),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextMediumSemiBold(textChild: AppContents.list),
                    InkWell(
                      onTap: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.sort,
                            color: AppColors.gray2,
                          ),
                          TextNormal(
                            textChild: AppContents.newest,
                            colorChild: AppColors.gray2,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Obx(() {
                if (listChapter != null && listChapter!.isNotEmpty) {
                  return BuildChapterNovelBody(
                    // ignore: invalid_use_of_protected_member
                    chapters: controller.filteredChapters.value.isNotEmpty
                        // ignore: invalid_use_of_protected_member
                        ? controller.filteredChapters.value
                        : chapters,
                  );
                } else {
                  return BuildChapterComicBody(
                    controller: comicDetailController,
                    listChapterComic:
                        // ignore: invalid_use_of_protected_member
                        controller.filteredChapterComic.value.isNotEmpty
                            ? controller.filteredChapterComic
                            : listChapterComic ?? [],
                  );
                }
              }),
            ],
          ),
        ),
      ],
    );
  }
}
