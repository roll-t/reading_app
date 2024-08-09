// ignore: camel_case_types
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

// ignore: camel_case_types
class ItemPodCast extends StatelessWidget {
  const ItemPodCast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/");
      },
      child: Stack(
        children: [
          SizedBox(
            // width: 170.0,
            child: Card(
              // color: AppColors.gray36,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 135.0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0, top: 2.0, right: 7.0),
                    child: Column(
                      children: [
                        TextWidget(
                          text: 'Hello world world ddd world ddd',
                          maxLines: 2,
                          fontWeight: FontWeight.w500,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0, left: 5.0),
                    child: Container(
                      height: 20.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColors.primary,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 3.0),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 12.0,
                            color: AppColors.primary,
                          ),
                          TextWidget(
                            text: '4.6',
                            fontWeight: FontWeight.normal,
                            size: 11,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            left: 10.0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: const TextWidget(
                text: "Free",
                size: 10.0,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.primary, shape: BoxShape.circle),
              height: 25.0,
              width: 25.0,
              child: const Icon(
                Icons.play_arrow,
                color: AppColors.white,
                size: 18.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
