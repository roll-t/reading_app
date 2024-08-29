import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/widget_controller.dart';

class ExpandableText extends GetView<WidgetController> {
  const ExpandableText({
    this.lineHeight=1.5,
    required this.text,
    super.key,
    this.trimLines = 4,
    this.fontSize = TextDimens.textNormal,
    this.fontSizeReadMore = 15,
    this.colorText = AppColors.gray2,
    this.fontWeight = FontWeight.w400,
    this.fontWeightReadMore = FontWeight.w400,
  });
  final double lineHeight;
  final String text;
  final int trimLines;
  final double fontSize;
  final double fontSizeReadMore;
  final FontWeight fontWeight;
  final FontWeight fontWeightReadMore;
  final Color colorText;

  @override
  Widget build(BuildContext context) {
    const colorClickableText =
        AppColors.accentColor; // Replace with AppColors.primary

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final textSpan = TextSpan(
          text: text,
          style: TextStyle(
            color: colorText,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        );

        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          maxLines: trimLines,
          ellipsis: '...',
        )..layout(maxWidth: constraints.maxWidth);

        if (textPainter.didExceedMaxLines) {
          final endIndex = textPainter
              .getPositionForOffset(
                Offset(
                  constraints.maxWidth - textPainter.size.width,
                  textPainter.size.height,
                ),
              )
              .offset;

          return Obx(() {
            final displayedText =
                controller.readMore.value ? text : text.substring(0, endIndex);

            final link = TextSpan(
              text: controller.readMore.value
                  ? AppContents.readLess
                  : AppContents.seeMore,
              style: TextStyle(
                color: colorClickableText,
                fontWeight: fontWeightReadMore,
                fontSize: fontSizeReadMore,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = controller.toggleReadMore,
            );

            final fullText = TextSpan(
              text: displayedText,
              style: TextStyle(
                height: 1.5,
                color: colorText,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
              children: <TextSpan>[link],
            );

            return RichText(
              text: fullText,
              textDirection: TextDirection.ltr,
              softWrap: true,
            );
          });
        } else {
          return RichText(
            text: textSpan,
            textDirection: TextDirection.ltr,
            softWrap: true,
          );
        }
      },
    );
  }
}
