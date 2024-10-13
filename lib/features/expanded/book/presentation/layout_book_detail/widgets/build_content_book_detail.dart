import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/database/model/list_comic_model.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';
import 'package:reading_app/core/ui/widgets/text/expandable_text.dart';
import 'package:reading_app/features/expanded/book/presentation/layout_book_detail/widgets/build_wrap_list_comment.dart';

class BuildContentBookDetail extends StatelessWidget{
  final List<CategoryModel>  categories;
  final String ?description;
  final SliverToBoxAdapter ? listRelate;
  const BuildContentBookDetail({
    super.key,
    this.categories=const[],
    this.description,
    this.listRelate,
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
                          for(var value in categories)
                            TagCategory(categoryName: value.name,)
                        ],
                      ),
                    )
                  ],
                ),
                const TextMediumSemiBold(textChild: AppContents.description),
                const SizedBox(
                  height: SpaceDimens.space10,
                ),
                ExpandableText(text: description ?? ""),
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
        if(listRelate!=null) listRelate!
      ],
    );
  }
}
