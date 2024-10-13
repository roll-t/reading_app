import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/utils/images_service.dart';

class Avatar extends StatelessWidget {
  final double ? padding;
  final double radius;
  final String ? url;
  
  const Avatar({
    super.key,
    this.url ,
    required this.radius, 
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? 0),
      decoration: BoxDecoration(

        color: AppColors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.gray1, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.2),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10000),
        child: FutureBuilder<bool>(
          future: ImagesService.doesImageLinkExist(url??""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                width: radius,
                height: radius,
                child: const Center(child: CircularProgressIndicator(strokeWidth: 2,)),
              );
            } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == false) {
              return Image.asset(
                AppImages.iAvatarDefault,
                width: radius,
                height: radius,
                fit: BoxFit.cover,
              );
            } else {
              return Image.network(
                url??"",
                width: radius,
                height: radius,
                fit: BoxFit.cover,
              );
            }
          },
        ),
      ),
    );
  }
}
