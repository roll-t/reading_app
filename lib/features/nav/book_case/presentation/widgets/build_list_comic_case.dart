import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/database/model/reading_book_case_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal_light.dart';
import 'package:reading_app/core/ui/widgets/card/card_comic_book_case.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildListComicCase extends StatelessWidget {
  final List<ReadingComicBookCaseModel> listBook;
  const BuildListComicCase({
    super.key,
    this.listBook = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: listBook.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Icon(
                      Icons.import_contacts,
                      color: AppColors.gray2,
                      size: 23.sp,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const TextNormalLight(
                      textChild: "chưa có truyện nào trong tủ sách",
                      colorChild: AppColors.gray2,
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: listBook.length,
                  padding: const EdgeInsets.only(
                      top: 0, bottom: SpaceDimens.space60),
                  itemBuilder: (context, index) {
                    return CardComicBookCase(
                      type: "Truyện tranh",
                      bookModel: listBook[index],
                      heightCard: 15.h,
                      widthCard: 25.w,
                    );
                  }),
        ),
        SizedBox(
          height: 5.h,
        )
      ],
    );
  }
}
