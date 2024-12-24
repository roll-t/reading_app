// Home slider
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/service/data/dto/response/novel_response.dart';
import 'package:reading_app/core/ui/widgets/carousel/carousel_utils.dart';

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
              CarouselUtils.buildCarousel(
                indexValue: currentIndex,
                listBook: listBook,
              ),

              // build dots control
              if (showDots)
                CarouselUtils.buildListDots(
                  indexValue: currentIndex,
                  lengthList: listBook.length,
                ),
            ],
          )
        : const SizedBox();
  }
}
