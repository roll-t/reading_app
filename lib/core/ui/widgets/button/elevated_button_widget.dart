import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback ontap;
  final String text;
  final String? icon; // Made optional
  final double? height;
  final double? textSize;
  final double? width;
  final Color? backgroundcolor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final bool? isBorder;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const ElevatedButtonWidget({
    super.key,
    required this.ontap,
    required this.text,
    this.icon,
    this.height = 55.0,
    this.width = double.infinity,
    this.textSize = TextDimens.textNormal,
    this.backgroundcolor = AppColors.primary,
    this.textColor = AppColors.white,
    this.fontWeight = FontWeight.w600,
    this.isBorder = false,
    this.padding,
    this.borderRadius = RadiusDimens.radiusMedium1,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: isBorder == true
              ? Border.all(
                  width: 1.5,
                  color: AppColors.primary.withOpacity(0.9),
                )
              : null,
          color: backgroundcolor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null && icon!.isNotEmpty) // Show icon only if provided
              Image.asset(
                icon!,
                height: 20.0,
                width: 20.0,
              ),
            if (icon != null && icon!.isNotEmpty) const SizedBox(width: 10.0),
            TextWidget(
              text: text,
              fontWeight: fontWeight,
              color: textColor,
              size: textSize,
            ),
          ],
        ),
      ),
    );
  }
}
