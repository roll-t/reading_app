// Home slider
import 'package:flutter/material.dart';
import 'package:reading_app/core/ui/widgets/carousel_slider/carousel_slider_utils.dart';
import 'package:reading_app/features/nav/audio/presentation/controller/audio_controller.dart';

class BuildSliderAudio extends StatelessWidget {
  final AudioController controller;
  const BuildSliderAudio({
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
