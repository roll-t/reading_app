import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/services/data/model/list_comic_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';

class BuildWrapListCard extends StatelessWidget {
  final double heightWrapList;
  final String? titleList;
  final double widthCard;
  final EdgeInsetsGeometry margin;
  final List<ItemModel> listBookData;
  final Widget Function(double widthCard, ItemModel bookModel) cardBuilder; // Thay đổi ở đây
  final VoidCallback ? seeMore;
  final Axis scrollDirection; // New parameter for scroll direction
  

  const BuildWrapListCard({
    super.key,
    required this.heightWrapList,
    this.titleList, 
    required this.widthCard, 
    required this.cardBuilder, 
    this.margin = const EdgeInsets.only(top: SpaceDimens.space20), 
    this.seeMore, 
    required this.listBookData, 
    this.scrollDirection = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: titleList != null
          ? heightWrapList + SpaceDimens.space10 + TextDimens.textLarge
          : heightWrapList,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titleList != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: SpaceDimens.spaceStandard, bottom: SpaceDimens.space10),
                  child: TextLargeSemiBold(textChild: titleList!),
                ),
                if(seeMore!=null)
                Padding(
                  padding: const EdgeInsets.only(
                      right: SpaceDimens.spaceStandard, bottom: SpaceDimens.space10),
                  child: InkWell( onTap:seeMore,child: const TextNormal(textChild: AppContents.seeMore,colorChild: AppColors.accentColor,)),
                ),
              ],
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SpaceDimens.spaceStandard),
              child: ListView.builder(
                scrollDirection: scrollDirection,
                itemCount:listBookData.length,
                itemBuilder: (context, index) {
                  return cardBuilder(
                    widthCard,listBookData[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
