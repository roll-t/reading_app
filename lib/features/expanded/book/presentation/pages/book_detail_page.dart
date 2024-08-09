import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/widgets/textfield/custom_search_field.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/book_detail_controller.dart';
import 'package:reading_app/features/expanded/book/presentation/widgets/book_details/build_bottom_book_detail.dart';
import 'package:reading_app/features/expanded/book/presentation/widgets/book_details/build_chapter_body.dart';
import 'package:reading_app/features/expanded/book/presentation/widgets/book_details/build_content_book_detail.dart';
import 'package:reading_app/features/expanded/book/presentation/widgets/book_details/build_header_tab_bar.dart';
import 'package:reading_app/features/expanded/book/presentation/widgets/book_details/build_sliver_app_bar_book_detail.dart';

class BookDetailPage extends GetView<BookDetailController> {
  const BookDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    final String tag = 'bookDetail ${DateTime.now().microsecondsSinceEpoch}';
    return Scaffold(
      body: BookDetailBody(
        tag: tag,
        controller: controller,
      ),
      bottomNavigationBar: const BuildBottomNavBookDetail(),
    );
  }
}


class BookDetailBody extends StatelessWidget {
  const BookDetailBody({
    super.key,
    required this.tag,
    required this.controller,
  });
  final String tag;
  final BookDetailController controller;

  @override
  Widget build(BuildContext context) {
    return buildScrollView(context);
  }

  Widget buildScrollView(BuildContext context) {
    return NestedScrollView(
      controller: controller.scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          // app bar
          const BuildSliverAppBarBookDetail(),

          // tab bar
          BuildHeaderTapBar(controller: controller),

          //space
          const SliverToBoxAdapter(
            child: SizedBox(
              height: SpaceDimens.space10,
            ),
          ),
        ];
      },
      // main body
      body: _buildMainBodyBookDetail(context),
    );
  }

  TabBarView _buildMainBodyBookDetail(BuildContext context) {
    return TabBarView(
      controller: controller.tabController,
      children: [
        const BuildContentBookDetail(),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: SpaceDimens.spaceStandard,
              vertical: SpaceDimens.space15),
          child: Column(
            children: [
              const CustomSearchField(
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
              const BuildChapterBody(),
            ],
          ),
        ),
      ],
    );
  }
}


