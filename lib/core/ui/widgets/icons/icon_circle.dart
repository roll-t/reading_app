import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class IconCircle extends StatelessWidget {
  final IconData iconChild;
  final double ? iconSize;
  final Color iconColor;
  final VoidCallback onTap;
  final double radius;
  final Color background;

  const IconCircle({
    super.key,
    required this.iconChild,
    this.iconSize,
    this.iconColor = AppColors.black,
    required this.onTap,
    this.radius = 35,
    this.background = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10000),
      ),
      child: Center(
        child: IconButton(
            padding: const EdgeInsets.all(0),
            iconSize: iconSize,
            color: iconColor,
            onPressed: onTap,
            icon: Icon(iconChild)),
      ),
    );
  }
}
