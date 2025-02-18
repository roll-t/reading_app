import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/ui/widgets/card/card_book_case.dart';
import 'package:reading_app/features/dashboard/book_case/presentation/widgets/build_empty_sate_bookcase.dart';
import 'package:reading_app/features/dashboard/book_case/presentation/widgets/build_shimmerbookcase.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildNovelBookCase extends StatelessWidget {
  final RxList<ReadingBookCaseResponse> novels;
  final Future<void> Function()? onRefresh;

  const BuildNovelBookCase({
    super.key,
    this.onRefresh,
    required this.novels,
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
              () =>
                  // ignore: invalid_use_of_protected_member
                  novels.value.isEmpty
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
    return novels.isEmpty ? const BuildEmptySateBookcase() : _buildBookList();
  }

  Widget _buildBookList() {
    return ListView.separated(
      itemCount: novels.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 0, bottom: SpaceDimens.space60),
      separatorBuilder: (context, index) =>
          const SizedBox(height: SpaceDimens.space10),
      itemBuilder: (context, index) {
        return CardBookCase(
          type: AppContents.novel,
          bookModel: novels[index],
          heightCard: 15.h,
          widthCard: 25.w,
        );
      },
    );
  }
}
