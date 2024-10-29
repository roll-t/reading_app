import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/data/dto/response/novel_response.dart';
import 'package:reading_app/core/ui/widgets/card/novel_explore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildListNovel extends StatelessWidget {
  final List<NovelResponse> listBookData;
  const BuildListNovel({
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
            return Container(
                alignment: Alignment.center,
                child: NovelExplore(
                  widthCard: 14.h,
                  heightCard: 25.h,
                  bookModel: listBookData[index],
                ));
          },
          childCount: listBookData.length, // Số lượng phần tử trong lưới
        ),
      ),
    );
  }
}
