import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/widgets/loading_widgets.dart';
import 'package:reading_app/features/nav/book_case/presentation/controller/book_case_controller.dart';
import 'package:reading_app/features/nav/book_case/presentation/widgets/build_list_book_case.dart';
import 'package:reading_app/features/nav/book_case/presentation/widgets/build_list_book_case_favorite.dart';
import 'package:reading_app/features/nav/book_case/presentation/widgets/build_list_comic_case.dart';

class BookCasePage extends GetView<BookCaseController> {
  const BookCasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: RefreshIndicator(
          onRefresh: controller.initial,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: true,
                centerTitle: true,
                title: TextMediumSemiBold(
                  textChild:
                      TextFormat.capitalizeEachWord(AppContents.bookCase),
                ),
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
                    TextNormal(textChild: AppContents.reading),
                    TextNormal(textChild: AppContents.liked),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SpaceDimens.spaceStandard,
                      vertical: SpaceDimens.space20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => PopupMenuButton<String>(
                          onSelected: (value) {
                            controller.handleChangeTypeRead(value);
                          },
                          itemBuilder: (BuildContext context) =>
                              controller.selectedValue,
                          child: Container(
                            padding: const EdgeInsets.only(
                                bottom: SpaceDimens.space5),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.gray2,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                TextNormal(
                                    textChild: controller.typeSelect.value),
                                const SizedBox(width: SpaceDimens.space15),
                                const Icon(Icons.arrow_drop_down,
                                    color: AppColors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.filterType.value == "Mới nhất") {
                            controller.sortBooksByType("updatedAt");
                            controller.filterType.value = "Mới cập nhật";
                          } else {
                            controller.sortBooksByType("readingDate");
                            controller.filterType.value = "Mới nhất";
                          }
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only(bottom: SpaceDimens.space5),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.gray2,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.filter_alt_rounded),
                              const SizedBox(width: SpaceDimens.space10),
                              Obx(
                                () => TextNormal(
                                    textChild: controller.filterType.value),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  children: [
                    LoadingWidgets.LoadingPartial(
                        isLoading: controller.isLoading,
                        body: GetBuilder<BookCaseController>(
                            id: "LoadReadingBookCase",
                            builder: (_) => controller.typeSelect.value ==
                                    "Truyện tranh"
                                ? BuildListComicCase(
                                    onRefresh: controller.reloadListBookComic,
                                    listBook: controller.listBookComic,
                                  )
                                : BuildListBookCase(
                                    onRefresh:
                                        controller.reloadListReadingBookCase,
                                    listBook: controller.listReadingBookCase))),
                    GetBuilder<BookCaseController>(
                      id: "LoadFavoriteBookCase",
                      builder: (_) => BuildListBookCaseFavorite(
                          listBook: controller.listFavoriteBooks),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
