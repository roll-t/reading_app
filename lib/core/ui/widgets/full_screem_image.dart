import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';

class FullScreemImage extends StatelessWidget {
  final String avatarUrl;

  const FullScreemImage({super.key, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close full screen when tapped
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.8),
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: avatarUrl.isEmpty ||
                        !Uri.tryParse(avatarUrl)!.hasAbsolutePath ??
                    false
                // Check if the URL is valid
                ? Image.asset(
                    AppImages.iAvatarDefault, // fallback to local asset
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : Image.network(
                    avatarUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
          ),
        ),
      ),
    );
  }
}
