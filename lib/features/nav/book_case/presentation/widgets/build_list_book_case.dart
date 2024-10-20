import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/data/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/ui/widgets/card/card_book_case.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildListBookCase extends StatelessWidget {
  final List<ReadingBookCaseResponse> listBook;
  const BuildListBookCase({
    super.key,
    required this.listBook,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: listBook.length,
              padding:
                  const EdgeInsets.only(top: 0, bottom: SpaceDimens.space60),
              itemBuilder: (context, index) {
                return CardBookCase(
                  type: "Tiểu thuyết",
                  bookModel: listBook[index],
                  heightCard: 120,
                  widthCard: 100,
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
