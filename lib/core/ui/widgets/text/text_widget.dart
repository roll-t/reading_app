import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final List<Shadow>? listShadow;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  final String? fontFamily;

  const TextWidget({
    super.key,
    this.textAlign,
    this.listShadow,
    this.maxLines = 1000,
    required this.text,
    this.color,
    this.size = TextDimens.textSize18,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.textDecoration = TextDecoration.none,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      maxLines: maxLines,
      textAlign: textAlign,
      style: _getTextStyle(),
    );
  }

  TextStyle _getTextStyle() {
    try {
      return GoogleFonts.getFont(
        fontFamily ?? "Roboto",
        textStyle: TextStyle(
          color: color,
          fontSize: size,
          fontStyle: fontStyle,
          shadows: listShadow,
          fontWeight: fontWeight,
          decoration: textDecoration,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } catch (e) {
      return GoogleFonts.roboto(
        textStyle: TextStyle(
          color: color,
          fontSize: size,
          fontStyle: fontStyle,
          shadows: listShadow,
          fontWeight: fontWeight,
          decoration: textDecoration,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
  }
}
