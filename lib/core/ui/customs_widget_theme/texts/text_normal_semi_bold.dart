
import 'dart:ui';

import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class TextNormalSemiBold extends TextWidget {
  final String textChild;
  final Color? colorChild;
  final int ? maxLineChild;

  const TextNormalSemiBold({
    super.key,
    required this.textChild,
    this.colorChild,
    this.maxLineChild,
  }) 
  : super(
          text: textChild,
          color: colorChild,
          fontWeight: FontWeight.w500,
          size: TextDimens.textNormal,
          maxLines: maxLineChild,
        );
}
