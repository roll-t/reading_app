import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/api/dto/response/favorite_response.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';
import 'package:reading_app/core/utils/date_time.dart';
import 'package:reading_app/core/utils/string_utils.dart';
import 'package:reading_app/features/nav/book_case/presentation/controller/book_case_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CardBookCaseFavorite extends GetView<BookCaseController> {
  final String type;
  final FavoriteResponse bookModel;
  final double heightCard;
  final double widthCard;
  const CardBookCaseFavorite({
    super.key,
    required this.type,
    required this.bookModel,
    required this.heightCard,
    required this.widthCard,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.novelDetail, arguments: {
          "novelId": bookModel.bookData.bookDataId,
        });
      },
      child: Container(
        height: heightCard,
        margin: EdgeInsets.symmetric(
            horizontal: 3.w, vertical: SpaceDimens.space10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.secondaryDarkBg),
        child: Row(
          children: [
            SizedBox(
              height: heightCard,
              width: widthCard,
              child: ImageWidget(
                imageUrl: bookModel.bookData.thumbUrl,
              ),
            ),
            SizedBox(
              width: 3.w,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: .5.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextSmallSemiBold(
                      textChild: type,
                      colorChild: AppColors.primaryLight,
                    ),
                    const SizedBox(
                      height: SpaceDimens.space5,
                    ),
                    TextNormal(
                      textChild: bookModel.bookData.name,
                      maxLinesChild: 2,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SpaceDimens.space10,
                          vertical: SpaceDimens.space5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          color: AppColors.accentColor.withOpacity(.4)),
                      child: TextSmall(
                        textChild: StringUtils.translate(
                            bookModel.bookData.status.split(" | ")[0]),
                      ),
                    ),
                    const SizedBox(
                      width: SpaceDimens.space10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: SpaceDimens.space10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: .5.h, horizontal: 1.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextSmall(
                      textChild:
                          DatetimeUtil.formatCustom(bookModel.favoriteDate)),
                  // InkWell(
                  //   onTap: () {
                  //     controller.handleDeleteFavorite(
                  //         bookId: bookModel.id.toString());
                  //   },
                  //   child: const Icon(
                  //     Icons.delete,
                  //     color: AppColors.gray2,
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
