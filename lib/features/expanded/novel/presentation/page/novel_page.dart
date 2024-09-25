
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/button/button_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/widgets/textfield/custom_search_field.dart';
import 'package:reading_app/core/utils/loading.dart';
import 'package:reading_app/features/expanded/book/widgets/book_details/build_bottom_book_detail.dart';
import 'package:reading_app/features/expanded/book/widgets/book_details/build_content_book_detail.dart';
import 'package:reading_app/features/expanded/novel/presentation/controller/novel_controller.dart';
import 'package:reading_app/features/expanded/novel/widgets/build_chapter_body.dart';
import 'package:reading_app/features/expanded/novel/widgets/build_header_tab_bar.dart';
import 'package:reading_app/features/expanded/novel/widgets/build_sliver_app_bar_book_detail.dart';

class NovelPage extends GetView<NovelController> {
  const NovelPage({super.key});
  @override
  Widget build(BuildContext context) {
    final String tag = 'bookDetail ${DateTime.now().microsecondsSinceEpoch}';
    return Obx(() {
      return !controller.isAuth.value
          ? _LoginRequest()
          : _BuildBodyBookDetail(tag);
    });
  }

  // ignore: non_constant_identifier_names
  Widget _BuildBodyBookDetail(String tag) {
    return Scaffold(
      body: Loading(
        isLoading: controller.isLoading,
        bodyBuilder: NovelDetailPage(
          tag: tag,
          controller: controller,
        ),
      ),
      bottomNavigationBar:Obx(()=> controller.isLoading.value ? const SizedBox(): const BuildBottomNavBookDetail()),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _LoginRequest() {
    return Scaffold(
        body: Loading(
            isLoading: controller.isLoading,
            bodyBuilder: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: SpaceDimens.space30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonNormal(
                    textChild: AppContents.login,
                    onTap: () async {
                      await controller.handleLogin();
                    },
                  ),
                ],
              ),
            )));
  }
}

class NovelDetailPage extends StatelessWidget {
  const NovelDetailPage({
    super.key,
    required this.tag,
    required this.controller,
  });
  final String tag;
  final NovelController controller;

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
          BuildSliverAppBarBookDetail(
            controller: controller,
            comicModel: controller.comicModel,
          ),

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

  TabBarView _buildMainBodyBookDetail(
    BuildContext context,
  ) {
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
              BuildChapterBody(
                controller: controller,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
