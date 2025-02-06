import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/services/api/data/entities/models/reading_book_case_model.dart';
import 'package:reading_app/core/ui/widgets/card/card_comic_book_case.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal_light.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildListComicCase extends StatelessWidget {
  final List<ReadingComicBookCaseModel> listBook;
  final Future<void> Function()? onRefresh;

  const BuildListComicCase({
    super.key,
    this.onRefresh,
    this.listBook = const [],
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (listBook.isEmpty) _buildEmptyState(),
            if (listBook.isNotEmpty) _buildBookList(),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 5.h),
          const Icon(Icons.import_contacts, color: AppColors.gray2, size: 23),
          SizedBox(height: 1.h),
          const TextNormalLight(
            textChild: "Chưa có truyện nào trong tủ sách",
            colorChild: AppColors.gray2,
          ),
        ],
      ),
    );
  }

  Widget _buildBookList() {
    return ListView.separated(
      itemCount: listBook.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 0, bottom: SpaceDimens.space60),
      separatorBuilder: (context, index) => const SizedBox(
          height: SpaceDimens.space10), // Khoảng cách giữa các item
      itemBuilder: (context, index) {
        return CardComicBookCase(
          type: "Truyện tranh",
          bookModel: listBook[index],
          heightCard: 15.h,
          widthCard: 25.w,
        );
      },
    );
  }
}
