import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/features/expanded/explores/search_book/presentation/controller/search_book_controller.dart';
import 'package:reading_app/features/expanded/explores/search_book/presentation/page/type/widgets/build_category_filter.dart';
import 'package:reading_app/features/expanded/explores/search_book/presentation/page/type/widgets/build_list_comic.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommicTypePage extends StatefulWidget {
  const CommicTypePage({super.key});

  @override
  _ComicTypePageState createState() => _ComicTypePageState();
}

class _ComicTypePageState extends State<CommicTypePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final SearchBookController controller = Get.find();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() async {
      if (!tabController.indexIsChanging) {
        controller.currentTypePage.value = tabController.index;
        await controller.changeCategoryList(
          slug: controller.currentSlugComic,
        );
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: BuildCategoryFilter(
                    currentIndex: controller.currentIndexCategory,
                    categories: controller.categories ?? [],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: TabBar(
                      controller: tabController,
                      unselectedLabelColor: AppColors.gray2,
                      dividerColor: AppColors.secondaryDarkBg,
                      labelColor: AppColors.accentColor,
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 2,
                          color: AppColors.accentColor,
                        ),
                      ),
                      tabs: const [
                        TextNormal(textChild: "Tất cả"),
                        TextNormal(textChild: "Hoàn thành"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  CustomScrollView(
                    slivers: [
                      GetBuilder<SearchBookController>(
                          id: "listComicId",
                          builder: (_) => BuildListComic(
                                listBookData:
                                    controller.dataComicCategoryByType.value,
                              ))
                    ],
                  ),
                  CustomScrollView(
                    slivers: [
                      Obx(() {
                        return controller.isDataLoading.value
                            ? SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                ),
                              )
                            : BuildListComic(
                                listBookData: controller
                                    .dataComicCategoryByTypeAndStatus.value,
                              );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
