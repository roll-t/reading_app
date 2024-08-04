// Home slider
import 'package:flutter/material.dart';
import 'package:reading_app/core/ui/widgets/carousel_slider/carousel_slider_utils.dart';
import 'package:reading_app/features/nav/home/presentation/controller/home_controller.dart';

class BuildSlider extends StatelessWidget {
  final HomeController controller;
  const BuildSlider({
    super.key,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // build slide control
        CarouselSliderUtils.buildCarouselSlider(
            indexValue: controller.currentIndex,
            listImage: controller.listIntroduceSlide),
            
            // build dots control
        CarouselSliderUtils.buildListDots(
          indexValue: controller.currentIndex,
          lengthList: controller.listIntroduceSlide.length,
        ),
      ],
    );
  }
}
