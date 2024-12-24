import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/service/data/dto/response/favorite_response.dart';
import 'package:reading_app/core/ui/widgets/card/card_book_case_favorite.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal_light.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildListBookCaseFavorite extends StatelessWidget {
  final List<FavoriteResponse> listBook;
  final Future<void> Function()? onRefresh;

  const BuildListBookCaseFavorite({
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
          Icon(Icons.import_contacts, color: AppColors.gray2, size: 23.sp),
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
    return ListView.builder(
      itemCount: listBook.length,
      padding: const EdgeInsets.only(top: 0, bottom: SpaceDimens.space60),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CardBookCaseFavorite(
          type: "Tiểu thuyết",
          bookModel: listBook[index],
          heightCard: 15.h,
          widthCard: 25.w,
        );
      },
    );
  }
}
