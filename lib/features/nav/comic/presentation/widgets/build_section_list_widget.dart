import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/core/ui/widgets/card/comic_card_row_widget.dart';
import 'package:reading_app/core/ui/widgets/card/comic_card_widget.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildSectionListWidget extends StatelessWidget {
  final List<ItemModel> books;
  final String? titleList;
  final VoidCallback? seeMore;
  final bool isHorizontal; // New property to control layout direction

  const BuildSectionListWidget({
    super.key,
    required this.titleList,
    this.seeMore,
    required this.books,
    this.isHorizontal = false, // Default is vertical
  });

  @override
  Widget build(BuildContext context) {
    final randomBooks = _getRandomBooks(books);
    return Container(
      padding: const EdgeInsets.all(SpaceDimens.spaceStandard),
      decoration: BoxDecoration(
          color: AppColors.secondaryDarkBg,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          _buildTitleRow(),
          SizedBox(height: 2.w),
          _buildComicList(randomBooks),
        ],
      ),
    );
  }

  Row _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: titleList ?? "",
          size: TextDimens.textSize18,
          fontWeight: FontWeight.w500,
        ),
        if (seeMore != null)
          InkWell(
            onTap: seeMore,
            child: const TextWidget(
              size: TextDimens.textSize14,
              text: AppContents.seeMore,
              color: AppColors.accentColor,
            ),
          ),
      ],
    );
  }

  Widget _buildComicList(List<ItemModel> randomBooks) {
    if (randomBooks.isEmpty) return const SizedBox.shrink();

    if (isHorizontal) {
      return SizedBox(
        height: 20.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: randomBooks.map((book) {
            return ComicCardWidget(
              width: 19.w,
              heightImage: 14.h,
              slug: book.slug,
              thumbUrl: book.thumbUrl,
              comicId: book.id ?? "",
              comicTitle: book.name,
            );
          }).toList(),
        ),
      );
    }

    return Column(
      children: randomBooks.map((book) {
        return ComicCardRowWidget(
          slug: book.slug,
          title: book.name,
          thumbUrl: book.thumbUrl,
          comicId: book.id ?? "",
          category: book.category.isNotEmpty ? book.category.first.name : null,
          imageHeight: 13.h,
          imageWidth: 25.w,
        );
      }).toList(),
    );
  }

  List<ItemModel> _getRandomBooks(List<ItemModel> books) {
    final random = Random();
    return books.length <= 4
        ? books
        : (books.toList()..shuffle(random)).take(4).toList();
  }
}
