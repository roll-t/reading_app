import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/data/models/book_model.dart';
import 'package:reading_app/core/ui/widgets/card/card_book_case.dart';

class BuildListBookCase extends StatelessWidget {
  final List<BookModel> listBook;
  const BuildListBookCase({
    super.key,
    required this.listBook,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listBook.length,
        padding: const EdgeInsets.only(top: 0, bottom: SpaceDimens.space60),
        itemBuilder: (context, index) {
          return CardBookCase(
            type: AppContents.audio,
            bookModel: listBook[index],
            heightCard: 120,
            widthCard: 100,
          );
        });
  }
}
