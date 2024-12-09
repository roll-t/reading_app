import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/service/service/model/list_comic_model.dart';
import 'package:reading_app/core/ui/widgets/card/card_comic_full_info_v2.dart';
import 'package:reading_app/features/nav/comic/presentation/controller/commic_controller.dart';
import 'package:reading_app/features/nav/comic/presentation/widgets/build_body_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildListColumnCategory extends StatelessWidget {
  final List<ItemModel> listBook;
  final String? titleList;
  final VoidCallback? seeMore;
  final String? domain;

  const BuildListColumnCategory({
    super.key,
    required this.controller,
    required this.listBook,
    this.titleList,
    this.seeMore,
    this.domain,
  });

  final CommicController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: SpaceDimens.space10),
      padding:
          const EdgeInsets.symmetric(horizontal: SpaceDimens.spaceStandard),
      child: BuildBodyList(
        titleList: titleList,
        seeMore: seeMore,
        childBuilder: Wrap(
          runSpacing: SpaceDimens.space15,
          children: [
            if (listBook.isNotEmpty)
              for (var i = 0; i < 3; i++)
                CardComicFullInfoV2(
                  heightImage: 14.h,
                  bookModel: listBook[i],
                  domain: domain ?? "",
                  currentIndex: 0,
                  widthImage: 25.w,
                ),
          ],
        ),
      ),
    );
  }
}
