import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_icons.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/category_response.dart';
import 'package:reading_app/core/ui/widgets/background/background_gradient.dart';
import 'package:reading_app/core/ui/widgets/card/comic_card_widget.dart';
import 'package:reading_app/core/ui/widgets/card/novel_card_widget.dart';
import 'package:reading_app/core/ui/widgets/icons/icon_image.dart';
import 'package:reading_app/core/ui/widgets/loading.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/ui/widgets/wrap/wrap_list_row_widget.dart';
import 'package:reading_app/core/ui/widgets/wrap/wrap_list_widget.dart';
import 'package:reading_app/features/content/categories/comics/data/models/category_arument_model.dart';
import 'package:reading_app/features/dashboard/home/presentation/controller/home_controller.dart';
import 'package:reading_app/features/dashboard/home/presentation/navigators/navigator_home_page.dart';
import 'package:reading_app/features/dashboard/home/presentation/widgets/build_list_tag_category.dart';
import 'package:reading_app/features/dashboard/home/presentation/widgets/build_slider.dart';
import 'package:reading_app/features/dashboard/home/presentation/widgets/build_sliver_app_bar.dart';
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
        height: 3.h,
      ),
    );
  }

  SliverToBoxAdapter _buildToExplore() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: InkWell(
          onTap: NavigatorHomePage.toSearchPage,
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
              mainAxisSize: MainAxisSize.min,
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
      // Kiểm tra items.isNotEmpty một lần, tránh việc kiểm tra nhiều lần
      final hasItems = items.isNotEmpty;
      return wrapListWidget(
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
          // Lấy item tại index một lần để sử dụng trong cardBuilder
          final novel = hasItems ? items[index] : null;

          return NovelCardWidget(
            heightImage: 15.h,
            width: widthCard,
            isLoading: !hasItems,
            novelId: novel?.bookDataId,
            slug: novel?.slug,
            thumbUrl: novel?.thumbUrl ?? "",
            novelTitle: novel?.name ?? "",
          );
        },
      );
    }));
  }

  Obx _buildListAllType() {
    return Obx(() {
      return SliverToBoxAdapter(
        // ignore: invalid_use_of_protected_member
        child: BuildListTagCategory(listType: controller.listType,listCategory: controller.categories.value),
      );
    });
  }

  SliverToBoxAdapter _buildListNovel() {
    return SliverToBoxAdapter(child: Obx(() {
      // ignore: invalid_use_of_protected_member
      final items = controller.listNovel.value;
      final hasItems = items.isNotEmpty;

      return wrapListRowWidget(
        titleList: "Tiểu thuyết",
        maxLength: hasItems ? items.length : 6,
        seeMore: () {
          Get.toNamed(Routes.categoryNovel, arguments: {
            "slugQuery":
                CategoryResponse(name: "Sắp ra mắt", slug: "truyen-moi", id: 1)
          });
        },
        cardBuilder: (index) {
          // Lấy item tại index một lần để sử dụng trong cardBuilder
          final novel = hasItems ? items[index] : null;
          return NovelCardWidget(
            isLoading: !hasItems,
            novelId: novel?.bookDataId,
            thumbUrl: novel?.thumbUrl ?? "",
            novelTitle: novel?.name ?? "",
          );
        },
      );
    }));
  }

  SliverToBoxAdapter _buildListComic() {
    return SliverToBoxAdapter(
      child: GetBuilder<HomeController>(
          id: "listComics",
          builder: (_) {
            final items = controller.upcomingComics?.value.items;
            const lengthList = 9;
            return wrapListWidget(
              isLoading: controller.isLoading.value,
              maxLength: lengthList,
              titleList: 'Cập nhật mới nhất',
              seeMore: () {
                NavigatorHomePage.toCategoryPage(
                    CategoryArgumentModel(slug: "sap-ra-mat"));
              },
              maxCol: 3,
              cardBuilder: (index, widthCard) {
                return ComicCardWidget(
                  width: widthCard,
                  isLoading: !(items?.isNotEmpty ?? false),
                  slug: items?[index].slug,
                  comicId: items?[index].id,
                  comicTitle: items?[index].name ?? "",
                  thumbUrl: items?[index].thumbUrl ?? "",
                );
              },
            );
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
        userName: controller.user.value.displayName,
      );
    });
  }
}
