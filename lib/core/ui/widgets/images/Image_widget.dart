// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  final double borderWidth;

  const ImageWidget({
    super.key,
    required this.imageUrl,
    this.borderRadius = 5.0,
    this.borderWidth = 2.0, // Adjust the border width as needed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius + borderWidth),
        border: Border.all(color: AppColors.gray1.withOpacity(.5), width: borderWidth),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
