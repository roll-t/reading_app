import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/features/materials/explores/search_book/presentation/controller/search_book_controller.dart';
import 'package:reading_app/features/materials/explores/search_book/presentation/page/type/widgets/build_list_novel.dart';
import 'package:reading_app/features/materials/explores/widgets/build_category_filter_novel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookTypePage extends StatefulWidget {
  const BookTypePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookTypePageState createState() => _BookTypePageState();
}

class _BookTypePageState extends State<BookTypePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final SearchBookController controller = Get.find();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        controller.currentTypePageNovel.value = tabController.index;
        if (tabController.index == 1) {
          controller.fetchListNovelByCategorySlugAndStatus(
              categorySlug: controller.currentSlugNovel, status: 'COMPLETED');
        } else {
          controller.fetchDataNovelByCategory(
              categoryName: controller.currentSlugNovel);
        }
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
      body: Column(
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
                sliver: SliverToBoxAdapter(
                  child: TabBar(
                    controller: tabController, // Set the tab controller here
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
              controller: tabController, // Set the tab controller here as well
              children: [
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
                          : BuildListNovel(
                              // ignore: invalid_use_of_protected_member
                              listBookData: controller.listNovel.value);
                    }),
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
                          : BuildListNovel(
                              // ignore: invalid_use_of_protected_member
                              listBookData: controller.listNovelComplete.value);
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
