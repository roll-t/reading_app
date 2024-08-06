// Home slider
import 'package:flutter/material.dart';
import 'package:reading_app/core/ui/widgets/carousel_slider/carousel_slider_utils.dart';
import 'package:reading_app/features/nav/commic/presentation/controller/commic_controller.dart';

class BuildSliderCommic extends StatelessWidget {
  final CommicController controller;
  const BuildSliderCommic({
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
      ],
    );
  }
}
