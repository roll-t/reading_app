

import 'dart:ui';

import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class TextMediumSemiBold extends TextWidget {
  final String textChild;
  final Color? colorChild;
  final int ? maxLinesChild;

  const TextMediumSemiBold({
    super.key,
    required this.textChild,
    this.colorChild,
    this.maxLinesChild,
  }) 
  : super(
          text: textChild,
          color: colorChild,
          fontWeight: FontWeight.w500,
          size: TextDimens.textMedium,
          maxLines: maxLinesChild
        );
}
