import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/features/nav/book_case/presentation/controller/book_case_controller.dart';
import 'package:reading_app/features/nav/book_case/presentation/widgets/build_list_book_case.dart';

class BookCasePage extends GetView<BookCaseController> {
  const BookCasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              centerTitle: true,
              title: TextMediumSemiBold(
                textChild: TextFormat.capitalizeEachWord(AppContents.bookCase),
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
                  TextNormal(textChild: AppContents.downloaded),
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
                          controller.typeSelect.value = value;
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem<String>(
                            value: 'Tất cả',
                            child: Text('Tất cả'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Tiểu thuyết',
                            child: Text('Tiểu thuyết'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Truyện tranh',
                            child: Text('Truyện tranh'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Truyện audio',
                            child: Text('Truyện audio'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Truyện ngắn',
                            child: Text('Truyện ngắn'),
                          ),
                        ],
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
                          controller.filterType.value = "Mới cập nhật";
                        } else {
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
                  BuildListBookCase(listBook: controller.listBookData),
                  BuildListBookCase(listBook: controller.listBookData),
                  BuildListBookCase(listBook: controller.listBookData),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
