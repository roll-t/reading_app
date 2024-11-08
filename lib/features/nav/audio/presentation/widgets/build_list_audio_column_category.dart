import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/features/nav/book_case/model/book_case_model.dart';
import 'package:reading_app/features/nav/comic/presentation/widgets/build_body_list.dart';

class BuildListAudioColumnCategory extends StatelessWidget {
  final int maxLength;
  final List<BookCaseModel> listBook;
  final String ? titleList;
  final VoidCallback ? seeMore;

  const BuildListAudioColumnCategory({
    super.key,
    this.maxLength = 3, 
    required this.listBook, 
    this.titleList,  
    this.seeMore,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: SpaceDimens.space10),
      padding: const EdgeInsets.symmetric(
          horizontal: SpaceDimens.spaceStandard),
      child: BuildBodyList(
        titleList:titleList,
        seeMore: seeMore,
        childBuilder: const Wrap(
          runSpacing: SpaceDimens.space15,
          children: [
            // for(var i = 0; i<maxLength;i++)
            // CardCommicFullInfo(
            //   heightImage: 120,
            //   bookModel: listBook[i],
            //   currentIndex: 0,
            //   widthImage: 90,
            // ),
          ],
        ),
      ),
    );
  }
}
