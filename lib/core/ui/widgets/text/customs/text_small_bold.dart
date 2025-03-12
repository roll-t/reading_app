
import 'dart:ui';

import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class TextSmallBold extends TextWidget {
  final String textChild;
  final Color? colorChild;

  const TextSmallBold({
    super.key,
    required this.textChild,
    this.colorChild,
  }) 
  : super(
          text: textChild,
          color: colorChild,
          fontWeight: FontWeight.w700,
          size: AppDimens.textSmall
        );
}
