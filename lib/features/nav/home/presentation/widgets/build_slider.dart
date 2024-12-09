// Home slider
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/service/api/dto/response/novel_response.dart';
import 'package:reading_app/core/ui/widgets/carousel_slider/carousel_slider_utils.dart';

class BuildSlider extends StatelessWidget {
  final List<NovelResponse> listBook;
  final RxInt currentIndex;
  final bool showDots;

  const BuildSlider({
    super.key,
    required this.listBook,
    required this.currentIndex,
    this.showDots = true,
  });

  @override
  Widget build(BuildContext context) {
    return listBook.isNotEmpty
        ? Column(
            children: [
              // build slide control
              CarouselSliderUtils.buildCarouselSlider(
                indexValue: currentIndex,
                listBook: listBook,
              ),

              // build dots control
              if (showDots)
                CarouselSliderUtils.buildListDots(
                  indexValue: currentIndex,
                  lengthList: listBook.length,
                ),
            ],
          )
        : const SizedBox();
  }
}
