import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/data/dto/response/category_response.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/custom_backgound/background_gradient.dart';
import 'package:reading_app/core/ui/widgets/card/card_newest_update.dart';
import 'package:reading_app/core/ui/widgets/card/card_novel_newest_update.dart';
import 'package:reading_app/core/ui/widgets/card/novel_card.dart';
import 'package:reading_app/core/ui/widgets/loading.dart';
import 'package:reading_app/features/nav/home/presentation/controller/home_controller.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_buttom_to_explore.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_category.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_list_tag_category.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_slider.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_sliver_app_bar.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_wrap_grid_card.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_wrap_grid_novel_card.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_wrap_novel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient.gradientRedBack(
          child: Loading(
        isLoading: controller.isLoading,
        bodyBuilder: CustomScrollView(
          slivers: [
            Obx(() {
              return BuildSliverAppBar(
                userName: controller.userName.value,
              );
            }),
            SliverToBoxAdapter(child: Obx(() {
              return BuildSlider(
                // ignore: invalid_use_of_protected_member
                listBook: controller.listSlide.value,
                currentIndex: controller.currentIndex,
              );
            })),
            const SliverToBoxAdapter(child: BuildCategory()),
            SliverToBoxAdapter(child: Obx(() {
              return controller.listDataComplete.value.items.isNotEmpty
                  ? BuildWrapGridCard(
                      margin: const EdgeInsets.only(top: SpaceDimens.space40),
                      heightCardItem: 45.h,
                      title: controller.listDataComplete.value.titlePage,
                      maxLength: 9,
                      seeMore: () {
                        controller.toDetailListBySlug(slug: "sap-ra-mat");
                      },
                      columns: 3,
                      childAspectRatio: 1.4 / 3,
                      heightImage: 20.h,
                      listBookData: controller.listDataComplete.value.items,
                      spacingCol: 3.w,
                      spacingRow: 3.w,
                      cardChild: (double heightImage, bookModel) {
                        return CardNewestUpdate(
                          heightImage: heightImage,
                          bookModel: bookModel,
                          domainImage:
                              controller.listDataComplete.value.domainImage,
                        );
                      },
                    )
                  : const SizedBox();
            })),
            SliverToBoxAdapter(child: Obx(() {
              // ignore: invalid_use_of_protected_member
              return controller.listNovel.value.isNotEmpty
                  ? BuildWrapNovel(
                      // ignore: invalid_use_of_protected_member
                      listBookData: controller.listNovel.value,
                      titleList: "Tiểu Thuyết",
                      heightWrapList: 35.h,
                      widthCard: 150,
                      seeMore: () {
                        Get.toNamed(Routes.categoryNovel, arguments: {
                          "slugQuery": CategoryResponse(
                              name: "Sắp ra mắt", slug: "truyen-moi", id: 1)
                        });
                      },
                      cardBuilder: (double widthCard, bookModel) {
                        return NovelCard(
                          widthCard: widthCard,
                          heightImage: 22.h,
                          bookModel: bookModel,
                        );
                      },
                    )
                  : const SizedBox();
            })),
            Obx(() {
              return SliverToBoxAdapter(
                child: BuildListTagCategory(
                    // ignore: invalid_use_of_protected_member
                    listCategory: controller.categories.value),
              );
            }),
            SliverToBoxAdapter(child: Obx(() {
              // ignore: invalid_use_of_protected_member
              return controller.listNovel.value.isNotEmpty
                  ? BuildWrapGridNovelCard(
                      heightCardItem: 26.h,
                      maxLength: 8,
                      title: "Tiểu thuyết mới",
                      seeMore: () {
                        Get.toNamed(Routes.categoryNovel, arguments: {
                          "slugQuery": CategoryResponse(
                              name: "Tiểu thuyết mới",
                              slug: "truyen-moi",
                              id: 2)
                        });
                      },
                      columns: 4,
                      childAspectRatio: .82 / 2,
                      heightImage: 16.h,
                      // ignore: invalid_use_of_protected_member
                      listBookData: controller.listNovel.value,
                      spacingCol: 2.w,
                      spacingRow: 2.w,
                      cardChild: (double heightImage, bookModel) {
                        return CardNovelNewestUpdate(
                          heightImage: 16.h,
                          bookModel: bookModel,
                        );
                      },
                    )
                  : const SizedBox();
            })),
            const SliverToBoxAdapter(
              child: BuildButtomToExplore(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
