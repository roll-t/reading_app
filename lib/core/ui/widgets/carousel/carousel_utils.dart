import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/ui/widgets/images/image_widget.dart';

class CarouselUtils {
  static Widget buildCarousel(
      {required RxInt indexValue, required List<NovelResponse> listBook}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpaceDimens.space10),
      child: CarouselSlider.builder(
        itemCount: listBook.length,
        itemBuilder: (context, index, realIndex) {
          return Obx(() {
            final currentIndex = indexValue.value;
            final isCurrent = index == currentIndex;
            final double scale = isCurrent ? 1 : .9;

            return AnimatedScale(
              scale: scale,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                opacity: isCurrent ? 1 : 0.7,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.novelDetail,
                          arguments: {"novelId": listBook[index].bookDataId});
                    },
                    child: ImageWidget(
                      imageUrl: listBook[index].thumbUrl ?? "",
                    ),
                  ),
                ),
              ),
            );
          });
        },
        options: CarouselOptions(
          height: 330.0,
          viewportFraction: 0.6,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
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
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(lengthList, (index) {
              final isActive = index == indexValue.value;
              return AnimatedContainer(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: isActive ? 25.0 : 8.0,
                height: 8.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.accentColor : Colors.grey,
                  borderRadius: isActive
                      ? BorderRadius.circular(4.0)
                      : BorderRadius.circular(50.0),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
