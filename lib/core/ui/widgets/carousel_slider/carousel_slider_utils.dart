import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/images/image_widget.dart';

class CarouselSliderUtils {
  static Widget buildCarouselSlider({
    required RxInt indexValue,
    required List<String> listImage,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpaceDimens.space10),
      child: CarouselSlider.builder(
        itemCount: listImage.length,
        itemBuilder: (context, index, realIndex) {
          return Obx(() {
            final currentIndex = indexValue.value;
            final isCurrent = index == currentIndex;
            final double scale = isCurrent ? 1 : .9;
            return Transform(
              transform: Matrix4.identity()..scale(scale),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ImageWidget(
                  imageUrl: listImage[index],
                ),
              ),
            );
          });
        },
        options: CarouselOptions(
          height: 200.0,
          viewportFraction: 0.8,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3), // Thay đổi mỗi giây
          autoPlayAnimationDuration: const Duration(milliseconds: 800), // Thời gian chuyển tiếp
          onPageChanged: (index, reason) {
            indexValue.value = index;
          },
        ),
      ),
    );
  }

  static Widget buildListDots({
    required RxInt indexValue,
    required int lengthList,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(lengthList, (index) {
            final isActive = index == indexValue.value;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: isActive ? 16.0 : 8.0,
              height: isActive ? 16.0 : 8.0,
              decoration: BoxDecoration(
                color: isActive ? AppColors.accentColor : Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      }),
    );
  }
}