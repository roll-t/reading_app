
import 'package:flutter/material.dart';
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
      children: [
        SizedBox(
          height: heightImage,
          child: ImageWidget(imageUrl: bookModel.imageUrl),
        ),
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