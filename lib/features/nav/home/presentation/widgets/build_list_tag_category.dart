import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';

class BuildListTagCategory extends StatelessWidget {
  const BuildListTagCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: SpaceDimens.space40, left: SpaceDimens.spaceStandard),
      child: const Wrap(
        spacing: SpaceDimens.space10,
        runSpacing: SpaceDimens.space10,
        children: [
          TagCategory(
            categoryName: AppContents.newestUpdate,
            typeTag: TagMarker.newUpdate,
          ),
          TagCategory(
            categoryName: AppContents.justPosted,
            typeTag: TagMarker.justPosted,
          ),
          TagCategory(
            categoryName: AppContents.trending,
            typeTag: TagMarker.trending,
          ),
          TagCategory(
            categoryName: 'Huyền thoại',
          ),
          TagCategory(
            categoryName: 'Huyền thoại',
          ),
          TagCategory(
            categoryName: 'Huyền thoại',
          ),
          TagCategory(
            categoryName: 'Huyền thoại',
          ),
          TagCategory(
            categoryName: 'Huyền thoại',
          ),
          TagCategory(
            categoryName: "${AppContents.seeMore} +",
          ),
        ],
      ),
    );
  }
}
