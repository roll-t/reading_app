

import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/models/book_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal_bold.dart';

class BuildWrapGridCard extends StatelessWidget {
  final double heightCardItem;
  final String? title;
  final VoidCallback? seeMore;
  final Widget Function(double heightImage, BookModel bookModel) cardChild;
  final int columns;
  final double childAspectRatio;
  final double heightImage;
  final List<BookModel> listBookData;
  final double spacingCol;
  final double spacingRow;

  const BuildWrapGridCard({
    super.key,
    required this.heightCardItem,
    this.title,
    this.seeMore,
    required this.columns,
    required this.childAspectRatio,
    required this.heightImage,
    required this.listBookData,
    this.spacingCol = 0,
    this.spacingRow = 0,
    required this.cardChild,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: SpaceDimens.spaceStandard),
      margin: const EdgeInsets.only(top: SpaceDimens.space20),
      height: heightCardItem * 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: SpaceDimens.space10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextLargeSemiBold(textChild: title!),
                  if (seeMore != null)
                    const TextNormalBold(
                      textChild: AppContents.seeMore,
                      colorChild: AppColors.accentColor,
                    ),
                ],
              ),
            ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listBookData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisSpacing: spacingCol,
                crossAxisSpacing: spacingRow,
                childAspectRatio: childAspectRatio,
              ),
              itemBuilder: (context, index) {
                return cardChild(heightImage, listBookData[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
