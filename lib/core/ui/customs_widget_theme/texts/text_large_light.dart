
import 'dart:ui';

import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class TextLargeLight extends TextWidget {
  final String textChild;
  final Color? colorChild;

  const TextLargeLight({
    super.key,
    required this.textChild,
    this.colorChild,
  }) 
  : super(
          text: textChild,
          color: colorChild,
          fontWeight: FontWeight.w300,
          size: TextDimens.textLarge
        );
}
