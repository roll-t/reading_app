import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCarousel {
  static Widget buildShimmerCarousel(int itemCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: CarouselSlider.builder(
        itemCount: itemCount,
        itemBuilder: (context, index, realIndex) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: AppColors.shimmerBase,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Shimmer.fromColors(
              baseColor: AppColors.shimmerBase,
              highlightColor: AppColors.shimmerHighlight,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.shimmerBase,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: 40.h,
          viewportFraction: 0.6,
          autoPlay: false,
          initialPage: 1,
          enableInfiniteScroll: false,
        ),
      ),
    );
  }

  static Widget buildShimmerDots(int lengthList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(lengthList, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: 8.0,
            height: 8.0,
            decoration: const BoxDecoration(
              color: AppColors.shimmerBase,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}
