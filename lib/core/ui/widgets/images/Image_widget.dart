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
    this.borderWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius + borderWidth),
        border: Border.all(
            color: AppColors.gray1.withOpacity(.5), width: borderWidth),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: _validateImageUrl(imageUrl),
          fit: BoxFit.cover,
          width: double.infinity,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) {
            return Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error); // Hoặc một hình ảnh placeholder khác
              },
            );
          },
        ),
      ),
    );
  }

  String _validateImageUrl(String? url) {
    // Check if URL is null or empty
    if (url == null || url.isEmpty) {
      return "https://via.placeholder.com/150"; // Default placeholder URL
    }
    // Optionally, validate URL format
    try {
      final uri = Uri.parse(url);
      if (uri.isAbsolute) {
        return url;
      }
    } catch (_) {
      return "https://via.placeholder.com/150";
    }
    return "https://via.placeholder.com/150";
  }
}
