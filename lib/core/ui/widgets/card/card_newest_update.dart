
import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/data/models/book_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';

class CardNewestUpdate extends StatelessWidget {
  final double heightImage;
  final BookModel bookModel;

  const CardNewestUpdate({
    super.key,
    required this.heightImage,
    required this.bookModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: heightImage,
          child: ImageWidget(imageUrl: bookModel.imageUrl),
        ),
        const SizedBox(height: SpaceDimens.space5,),
        Expanded(
          child: TextNormal(
            textChild: bookModel.title,
            maxLinesChild: 2,
          ),
        ),
      ],
    );
  }
}