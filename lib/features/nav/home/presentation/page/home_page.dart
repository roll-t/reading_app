import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/ui/customs_widget_theme/custom_backgound/background_gradient.dart';
import 'package:reading_app/core/ui/widgets/card/btv_recoment_card.dart';
import 'package:reading_app/core/ui/widgets/card/card_by_category.dart';
import 'package:reading_app/core/ui/widgets/card/card_full_info_follow_row.dart';
import 'package:reading_app/core/ui/widgets/card/card_newest_update.dart';
import 'package:reading_app/core/ui/widgets/card/card_reading_continue.dart';
import 'package:reading_app/features/nav/home/presentation/controller/home_controller.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_category.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_list_select_category.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_list_tag_category.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_slider.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_sliver_app_bar.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_wrap_grid_card.dart';
import 'package:reading_app/features/nav/home/presentation/widgets/build_wrap_list_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient.gradientRedBack(
        child: CustomScrollView(
          slivers: [
            // App bar
            const BuildSliverAppBar(
              userName: "P T",
            ),

            // home slider
            SliverToBoxAdapter(child: BuildSlider(controller: controller)),

            //build Category list
            const SliverToBoxAdapter(child: BuildCategory()),

            // build list card reading continue
            SliverToBoxAdapter(
              child: BuildWrapListCard(
                margin: const EdgeInsets.all(0),
                heightWrapList: 120,
                listBookData: controller.listValueCardContinue,
                titleList: AppContents.titleListContinue,
                widthCard: 170,
                cardBuilder: (double widthCard, bookModel) {
                  return CardReadingContinue(
                    widthCard: widthCard,
                    bookModel: bookModel,
                    chapter: "chapter 5",
                  );
                },
              ),
            ),

            // Build list BTV đề cử
            SliverToBoxAdapter(
              child: BuildWrapListCard(
                listBookData: controller.listValueCardBTVRecoment,
                titleList: AppContents.btvRecomment,
                heightWrapList: 270,
                widthCard: 150,
                seeMore: () {},
                cardBuilder: (double widthCard, bookModel) {
                  return BTVRecomentCard(
                    widthCard: widthCard,
                    heightImage: 180,
                    bookModel: bookModel,
                  );
                },
              ),
            ),

            // build list newest update
            SliverToBoxAdapter(
              child: BuildWrapGridCard(
                heightCardItem: 200,
                title: AppContents.newestUpdate,
                seeMore: () {},
                columns: 4,
                childAspectRatio: 1 /
                    2, // tỉ lệ giữa chiều rộng với chiều cao của phần tử trong Grid 1/2 có nghĩa là chiểu cao bằng 2 lần chiều rộng
                heightImage: 120,
                listBookData: controller.listValueCardContinue,
                spacingCol: 10,
                spacingRow: 10,
                cardChild: (double heightImage, bookModel) {
                  return CardNewestUpdate(
                    heightImage: 120,
                    bookModel: bookModel,
                  );
                },
              ),
            ),

            // build category recommentaition
            const SliverToBoxAdapter(
              child: BuildListTagCategory(),
            ),

            // build list book by category
            SliverToBoxAdapter(
              child: BuildWrapListCard(
                titleList: "Tiểu thuyết mới",
                seeMore: () {},
                heightWrapList: 280,
                listBookData: controller.listValueCardByCategory,
                widthCard: 150,
                cardBuilder: (double widthCard, bookModel) {
                  return CardByCategory(
                    widthCard: widthCard,
                    heightImage: 190,
                    bookModel: bookModel,
                  );
                },
              ),
            ),
            // build list book by category
            SliverToBoxAdapter(
              child: BuildWrapListCard(
                margin: const EdgeInsets.only(top: SpaceDimens.space50),
                titleList: "Truyện tranh mới",
                seeMore: () {},
                heightWrapList: 280,
                listBookData: controller.listValueCardByCategory,
                widthCard: 150,
                cardBuilder: (double widthCard, bookModel) {
                  return CardByCategory(
                    widthCard: widthCard,
                    heightImage: 190,
                    bookModel: bookModel,
                  );
                },
              ),
            ),

            SliverToBoxAdapter(
                child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: SpaceDimens.spaceStandard),
              child: Column(
                children: [
                  BuildListSelectCategory(
                    currentIndex: 1,
                    listCategory: controller.listCategory,
                  ),
                  FittedBox(
                    child: Column(
                      children: [
                        for(var i=0;i<controller.listCardFullInfo.length;i++)
                          CardFullInfoFollowRow(heightImage: 120, bookModel: controller.listCardFullInfo[i], currentIndex: i,)
                      ],
                    ),
                  )
                ],
              ),
            )),

            // create bottom space
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

