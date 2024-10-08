import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/card/card_by_category.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/book_detail_controller.dart';
import 'package:reading_app/features/expanded/book/widgets/book_details/build_wrap_list_comment.dart';
import 'package:reading_app/features/expanded/book/widgets/shared/build_wrap_list_card.dart';
import 'package:reading_app/features/expanded/book/widgets/shared/expandable_text.dart';

class BuildContentBookDetail extends GetView<BookDetailController> {
  const BuildContentBookDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: SpaceDimens.spaceStandard),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: SpaceDimens.space20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextMediumSemiBold(textChild: AppContents.type),
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: SpaceDimens.space10,
                          top: SpaceDimens.space10),
                      margin:
                          const EdgeInsets.only(bottom: SpaceDimens.space30),
                      width: Get.width,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.gray3, width: .5))),
                      child:  Wrap(
                        spacing: SpaceDimens.space10,
                        runSpacing: SpaceDimens.space10,
                        children: [
                          for(var value in controller.category)
                            TagCategory(categoryName: value["name"],)
                        ],
                      ),
                    )
                  ],
                ),
                const TextMediumSemiBold(textChild: AppContents.description),
                const SizedBox(
                  height: SpaceDimens.space10,
                ),
                ExpandableText(text: controller.description),
                const SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),

        // Build list có thể bạn sẽ thích
        SliverToBoxAdapter(
          child: BuildWrapListComment(
            titleList: AppContents.comment,
            heightWrapList: 200,
            widthCard: 150,
            toDetail: () {
              Get.toNamed(
                Routes.comment,
              );
            },
          ),
        ),
        // Build list có thể bạn sẽ thích
        SliverToBoxAdapter(
          child: BuildWrapListCard(
            listBookData: controller.listComicNewest,
            titleList: "Có thể bạn sẽ thích",
            heightWrapList: 270,
            widthCard: 150,
            seeMore: () {
              Get.toNamed(Routes.category,
                  arguments: {"titleCategory": "Có thể bạn sẽ thích"});
            },
            cardBuilder: (double widthCard, bookModel) {
              return CardByCategory(
                widthCard: widthCard,
                heightImage: 190,
                bookModel: bookModel,
                domain: " ",
              );
            },
          ),
        ),
      ],
    );
  }
}
