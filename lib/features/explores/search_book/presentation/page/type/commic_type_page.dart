import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/features/explores/search_book/presentation/controller/search_book_controller.dart';
import 'package:reading_app/features/explores/search_book/presentation/page/type/widgets/build_category_filter.dart';
import 'package:reading_app/features/explores/search_book/presentation/page/type/widgets/build_list_book.dart';

class CommicTypePage extends GetView<SearchBookController> {
  const CommicTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: BuildCategoryFilter(
                    currentIndex: controller.currentIndexCategory,
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: TabBar(
                      unselectedLabelColor: AppColors.gray2,
                      dividerColor: AppColors.secondaryDarkBg,
                      labelColor: AppColors.accentColor,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 2,
                          color: AppColors.accentColor,
                        ),
                      ),
                      tabs: [
                        TextNormal(textChild: "Tất cả"),
                        TextNormal(textChild: "Truyện hot"),
                        TextNormal(textChild: "Hoàn thành"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: TabBarView(
              children: [
                CustomScrollView(
                  slivers: [
                    BuildListBook(listBookData: controller.listBookData)
                  ],
                ),
                CustomScrollView(
                  slivers: [
                    BuildListBook(listBookData: controller.listBookData)
                  ],
                ),
                CustomScrollView(
                  slivers: [
                    BuildListBook(listBookData: controller.listBookData)
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}