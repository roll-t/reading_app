
import 'dart:ui';

import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class TextLargeBold extends TextWidget {
  final String textChild;
  final Color? colorChild;
  const TextLargeBold({
    super.key,
    required this.textChild,
    this.colorChild,
  }) 
  : super(
          text: textChild,
          color: colorChild,
          fontWeight: FontWeight.w700,
          size: TextDimens.textLarge
        );
}
