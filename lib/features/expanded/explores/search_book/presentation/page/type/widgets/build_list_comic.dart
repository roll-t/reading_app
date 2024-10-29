import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/data/database/model/list_comic_model.dart';
import 'package:reading_app/core/ui/widgets/card/card_explore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildListComic extends StatelessWidget {
  final ListComicModel listBookData;
  const BuildListComic({
    super.key,
    required this.listBookData,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
          horizontal: SpaceDimens.space20, vertical: SpaceDimens.space15),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.6 / 3,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            // Xây dựng phần tử của lưới
            return Container(
                alignment: Alignment.center,
                child: CardExplore(
                  widthCard: 14.h,
                  heightCard: 25.h,
                  bookModel: listBookData.items[index],
                  domainImage: listBookData.domainImage,
                ));
          },
          childCount: listBookData.items.length, // Số lượng phần tử trong lưới
        ),
      ),
    );
  }
}
