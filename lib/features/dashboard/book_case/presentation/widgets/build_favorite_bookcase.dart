import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/favorite_response.dart';
import 'package:reading_app/core/ui/widgets/card/card_book_case_favorite.dart';
import 'package:reading_app/features/dashboard/book_case/presentation/widgets/build_empty_sate_bookcase.dart';
import 'package:reading_app/features/dashboard/book_case/presentation/widgets/build_shimmerbookcase.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildFavoriteBookCase extends StatelessWidget {
  final RxList<FavoriteResponse> listBook;
  final Future<void> Function()? onRefresh;

  const BuildFavoriteBookCase({
    super.key,
    this.onRefresh,
    required this.listBook,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => listBook.isEmpty
                  ? const BuildShimmerBookcase()
                  : _buildContent(),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return listBook.isEmpty ? const BuildEmptySateBookcase() : _buildBookList();
  }

  Widget _buildBookList() {
    return ListView.separated(
      itemCount: listBook.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 0, bottom: SpaceDimens.space60),
      separatorBuilder: (context, index) =>
          const SizedBox(height: SpaceDimens.space10),
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
