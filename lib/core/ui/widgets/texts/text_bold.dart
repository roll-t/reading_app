import 'dart:ui';

import 'package:reading_app/core/configs/app_colors.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class TextBold extends TextWidget {
  final String contentChild;
  final Color colorChild;
  const TextBold(
      {super.key,
      required this.contentChild,
      this.colorChild = AppColors.textNormal})
      : super(
            text: contentChild,
            color: colorChild,
            size: AppDimens.textSize22,
            fontWeight: FontWeight.w500);
}
