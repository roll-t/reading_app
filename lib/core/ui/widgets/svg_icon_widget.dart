import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class SvgIconWidget extends StatelessWidget {
  final String svgUrl;
  final double size;
  final Color color;
  const SvgIconWidget({
    required this.svgUrl,
    this.size = 25,
    this.color = AppColors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      width: size,
      svgUrl,
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),
    );
  }
}
