import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final double? textSize;
  final VoidCallback onTap;
  final String? textChild; // Renamed from `text` for clarity
  final double? width;
  final Color? background; // Renamed from `backgroundColor`
  final Color textColor;
  final FontWeight? fontWeight;
  final bool rounder; // Added for rounded border support
  final bool isBorder;
  final Color? borderColor;
  final SvgPicture? leadingIcon;
  final Widget? child;
  final EdgeInsetsGeometry padding; // Renamed from `padding`
  final double? borderRadius; // Will be calculated based on `rounder`

  const ButtonWidget({
    super.key,
    this.textSize = 20,
    required this.onTap,
    this.textChild,
    this.width = double.infinity,
    this.background = AppColors.primary,
    this.textColor = AppColors.white,
    this.fontWeight = FontWeight.w600,
    this.rounder = false, // Default is not rounded
    this.isBorder = false,
    this.borderColor,
    this.leadingIcon,
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.0),
    this.borderRadius, // Optional
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        width: width,
        decoration: BoxDecoration(
          border: isBorder
              ? Border.all(
                  width: 1,
                  color: borderColor ?? AppColors.primary,
                )
              : null,
          color: background,
          borderRadius: BorderRadius.circular(rounder ? 1000 : (borderRadius ?? 10)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadingIcon != null) leadingIcon!,
              if (leadingIcon != null) const SizedBox(width: 10.0),
              child ??
                  TextWidget(
                    size: textSize,
                    text: textChild ?? "",
                    fontWeight: fontWeight,
                    textAlign: TextAlign.center,
                    color: textColor,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
