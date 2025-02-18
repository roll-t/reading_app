import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/utils/text_format.dart';
import 'package:reading_app/features/dashboard/book_case/presentation/controller/book_case_controller.dart';
import 'package:reading_app/features/dashboard/book_case/presentation/widgets/build_comic_bookcase.dart';
import 'package:reading_app/features/dashboard/book_case/presentation/widgets/build_favorite_bookcase.dart';
import 'package:reading_app/features/dashboard/book_case/presentation/widgets/build_novel_bookcase.dart';

class BookCasePage extends GetView<BookCaseController> {
  const BookCasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.initial,
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            _buildTabBar(),
            _buildTabBarView(),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      centerTitle: true,
      title: TextMediumSemiBold(
        textChild: TextFormat.capitalizeEachWord(AppContents.bookCase),
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
          TextNormal(textChild: AppContents.reading),
          TextNormal(textChild: AppContents.liked),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpaceDimens.spaceStandard,
          vertical: SpaceDimens.space20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => PopupMenuButton<String>(
                onSelected: controller.handleChangeTypeRead,
                itemBuilder: (context) => [
                  const PopupMenuItem<String>(
                    value: AppContents.novel,
                    child: TextWidget(
                      text: AppContents.novel,
                      size: 16,
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: AppContents.comic,
                    child: TextWidget(
                      text: AppContents.comic,
                      size: 16,
                    ),
                  ),
                ],
                child: Container(
                  padding: const EdgeInsets.only(bottom: SpaceDimens.space5),
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
                      TextNormal(textChild: controller.typeSelect.value),
                      const SizedBox(width: SpaceDimens.space15),
                      const Icon(Icons.arrow_drop_down, color: AppColors.white),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                final sortType = controller.filterType.value == "Mới nhất"
                    ? "updatedAt"
                    : "readingDate";
                final newFilterType = controller.filterType.value == "Mới nhất"
                    ? "Mới cập nhật"
                    : "Mới nhất";
                controller.sortBooksByType(sortType);
                controller.filterType.value = newFilterType;
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: SpaceDimens.space5),
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
                      () => TextNormal(textChild: controller.filterType.value),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return SliverFillRemaining(
      child: Obx(
        () => TabBarView(
          controller: controller.tabController,
          children: [
            controller.typeSelect.value == AppContents.novel
                ? BuildNovelBookCase(
                    novels: controller.novelsReadingBookcase,
                  )
                : BuildComicBookCase(
                    listBook: controller.comicsReadingBookcase,
                  ),
            BuildFavoriteBookCase(
              listBook: controller.novelsFavoriteBookcase,
            ),
          ],
        ),
      ),
    );
  }
}
