import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/core/ui/widgets/images/image_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CarouselComic {
  static Widget buildCarouselSlider({
    required RxInt indexValue,
    required ListComicModel listBook,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpaceDimens.space10),
      child: CarouselSlider.builder(
        itemCount: listBook.items.length,
        itemBuilder: (context, index, realIndex) {
          return Obx(() {
            final currentIndex = indexValue.value;
            final isCurrent = index == currentIndex;
            final double scale = isCurrent ? 1 : 0.9;

            // Thêm hiệu ứng opacity mượt mà
            final double opacity = isCurrent ? 1 : 0.7;
            
            return AnimatedScale(
              scale: scale,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.comicDetail,
                          arguments: {"slug": listBook.items[index].slug});
                    },
                    child: ImageWidget(
                        imageUrl:
                            "https://img.otruyenapi.com/uploads/comics/${listBook.items[index].thumbUrl}"),
                  ),
                ),
              ),
            );
          });
        },
        options: CarouselOptions(
          height: 40.h,
          viewportFraction: 0.6,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
