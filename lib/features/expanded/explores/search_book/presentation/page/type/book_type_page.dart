import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/features/expanded/explores/search_book/presentation/controller/search_book_controller.dart';
import 'package:reading_app/features/expanded/explores/search_book/presentation/page/type/widgets/build_category_filter_novel.dart';
import 'package:reading_app/features/expanded/explores/search_book/presentation/page/type/widgets/build_list_novel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookTypePage extends GetView<SearchBookController> {
  const BookTypePage({super.key});

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
                  child: BuildCategoryFilterNovel(
                    currentIndex: controller.currentIndexCategoryNovel,
                    categories: controller.categoriesNovel,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h),
                  sliver: const SliverToBoxAdapter(
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
                        TextNormal(textChild: "Hoàn thành"),
                        TextNormal(textChild: "Truyện hot"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Obx(() {
              return Expanded(
                  child: TabBarView(
                children: [
                  CustomScrollView(
                    slivers: [
                      // ignore: invalid_use_of_protected_member
                      BuildListNovel(listBookData: controller.listNovel.value)
                    ],
                  ),
                  CustomScrollView(
                    slivers: [
                      // ignore: invalid_use_of_protected_member
                      BuildListNovel(
                          listBookData: controller.listNovelComplete.value)
                    ],
                  ),
                  CustomScrollView(
                    slivers: [
                      // ignore: invalid_use_of_protected_member
                      BuildListNovel(listBookData: controller.listNovel.value)
                    ],
                  ),
                ],
              ));
            })
          ],
        ),
      ),
    );
  }
}
