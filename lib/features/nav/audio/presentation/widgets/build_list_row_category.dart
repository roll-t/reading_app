import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/features/nav/book_case/model/book_case_model.dart';
import 'package:reading_app/features/nav/comic/presentation/widgets/build_body_list.dart';

class BuildListRowCategory extends StatelessWidget {
  final List<BookCaseModel> listBookData;
  final int maxLength;
  final String? titleList;
  final VoidCallback? seeMore;

  const BuildListRowCategory({
    super.key,
    required this.listBookData,
    this.maxLength = 4,
    this.titleList,
    this.seeMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: SpaceDimens.space10),
      padding:
          const EdgeInsets.symmetric(horizontal: SpaceDimens.spaceStandard),
      child: BuildBodyList(
        titleList: titleList,
        seeMore: seeMore,
        childBuilder: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // for (var i = 0; i < maxLength; i++)
            //   CardExplore(
            //     bookModel: listBookData[i],
            //     widthCard: Get.width * 0.2,
            //     heightCard: 160,
            //   )
          ],
        ),
      ),
    );
  }
}
