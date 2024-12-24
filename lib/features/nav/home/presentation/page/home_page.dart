import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_icons.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/data/dto/response/category_response.dart';
import 'package:reading_app/core/ui/widgets/background/background_gradient.dart';
import 'package:reading_app/core/ui/widgets/card/comic_card_widget.dart';
import 'package:reading_app/core/ui/widgets/card/novel_card_widget.dart';
import 'package:reading_app/core/ui/widgets/icons/icon_image.dart';
import 'package:reading_app/core/ui/widgets/loading.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/ui/widgets/wrap/wrap_list_row_widget.dart';
import 'package:reading_app/core/ui/widgets/wrap/wrap_list_widget.dart';
import 'package:reading_app/features/nav/home/presentation/controller/home_controller.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_list_tag_category.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_slider.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_sliver_app_bar.dart';
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
            _buildAppBar(),
            _buildSlider(),
            _buildSpacing(),
            _buildCategories(),
            _buildSpacing(),
            _buildListComic(),
            _buildSpacing(),
            _buildListNovel(),
            _buildSpacing(),
            _buildListAllType(),
            _buildSpacing(),
            _buildListNewNovel(),
            _buildSpacing(),
            _buildToExplore(),
            _buildSpacingWidthBottom(),
          ],
        ),
      )),
    );
  }

  SliverToBoxAdapter _buildSpacing() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 3.h,
      ),
    );
  }

  SliverToBoxAdapter _buildSpacingWidthBottom() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 10.h,
      ),
    );
  }

  SliverToBoxAdapter _buildToExplore() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.search);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: SpaceDimens.space10,
              horizontal: SpaceDimens.space10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.secondaryColor,
            ),
            child: const Row(
              mainAxisSize:
                  MainAxisSize.min, // Đặt chiều rộng vừa đủ với nội dung
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.menu_book),
                SizedBox(
                  width: SpaceDimens.space10,
                ),
                TextWidget(
                  text: "Khám phá thêm truyện",
                  size: TextDimens.textSize16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildListNewNovel() {
    return SliverToBoxAdapter(child: Obx(() {
      // ignore: invalid_use_of_protected_member
      final items = controller.listNovel.value;
      return items.isNotEmpty
          ? wrapListWidget(
              maxLength: 8,
              titleList: 'Tiểu thuyết mới',
              seeMore: () {
                Get.toNamed(Routes.categoryNovel, arguments: {
                  "slugQuery": CategoryResponse(
                      name: "Tiểu thuyết mới", slug: "truyen-moi", id: 2)
                });
              },
              maxCol: 4,
              cardBuilder: (index, widthCard) {
                return NovelCardWidget(
                  heightImage: 15.h,
                  width: widthCard,
                  novelId: items[index].bookDataId,
                  slug: items[index].slug,
                  thumbUrl: items[index].thumbUrl ?? "",
                  novelTitle: items[index].name ?? "",
                );
              },
            )
          : const SizedBox();
    }));
  }

  Obx _buildListAllType() {
    return Obx(() {
      return SliverToBoxAdapter(
        child: BuildListTagCategory(listCategory: controller.categories.value),
      );
    });
  }

  SliverToBoxAdapter _buildListNovel() {
    return SliverToBoxAdapter(child: Obx(() {
      // ignore: invalid_use_of_protected_member
      final items = controller.listNovel.value;
      return items.isNotEmpty
          ? wrapListRowWidget(
              titleList: "Tiểu thuyết",
              maxLength: items.length,
              seeMore: () {
                Get.toNamed(Routes.categoryNovel, arguments: {
                  "slugQuery": CategoryResponse(
                      name: "Sắp ra mắt", slug: "truyen-moi", id: 1)
                });
              },
              cardBuilder: (index) {
                return NovelCardWidget(
                  novelId: items[index].bookDataId,
                  thumbUrl: items[index].thumbUrl ?? "",
                  novelTitle: items[index].name ?? "",
                );
              },
            )
          : const SizedBox();
    }));
  }

  SliverToBoxAdapter _buildListComic() {
    return SliverToBoxAdapter(
      child: Obx(() {
        final items = controller.listDataComplete.value.items;
        const lengthList = 9;
        return items.isNotEmpty
            ? wrapListWidget(
                maxLength: lengthList,
                titleList: 'Cập nhật mới nhất',
                seeMore: () {
                  controller.toDetailListBySlug(slug: "sap-ra-mat");
                },
                maxCol: 3,
                cardBuilder: (index, widthCard) {
                  return ComicCardWidget(
                    width: widthCard,
                    slug: items[index].slug,
                    comicId: items[index].id,
                    comicTitle: items[index].name,
                    thumbUrl: items[index].thumbUrl,
                  );
                },
              )
            : const SizedBox.shrink();
      }),
    );
  }

  SliverToBoxAdapter _buildCategories() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconImage.iconImageSub(
                iconUrl: AppIcons.iRank, sub: AppContents.rank),
            IconImage.iconImageSub(
                iconUrl: AppIcons.iGold, sub: AppContents.gold),
            IconImage.iconImageSub(
                iconUrl: AppIcons.iStarBadge, sub: AppContents.selection),
            IconImage.iconImageSub(
                iconUrl: AppIcons.iFeatherPen, sub: AppContents.shortStory),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSlider() {
    return SliverToBoxAdapter(child: Obx(() {
      return BuildSlider(
        // ignore: invalid_use_of_protected_member
        listBook: controller.listSlide.value,
        currentIndex: controller.currentIndex,
      );
    }));
  }

  Obx _buildAppBar() {
    return Obx(() {
      return BuildSliverAppBar(
        userName: controller.userName.value,
      );
    });
  }
}
