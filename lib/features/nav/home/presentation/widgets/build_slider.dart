// Home slider
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/data/database/model/list_comic_model.dart';
import 'package:reading_app/core/ui/widgets/carousel_slider/carousel_slider_utils.dart';

class BuildSlider extends StatelessWidget {
  final ListComicModel listImage;
  final RxInt currentIndex ;

  const BuildSlider({
    super.key, 
    required this.listImage, 
    required this.currentIndex, 
  });

  @override
  Widget build(BuildContext context) {

    return listImage.items.isNotEmpty? Column(  
      children: [
        // build slide control
        CarouselSliderUtils.buildCarouselSlider(
            indexValue: currentIndex,
            listImage: listImage,
            ),
            
            // build dots control
        CarouselSliderUtils.buildListDots(
          indexValue: currentIndex,
          lengthList: listImage.items.length,
        ),
      ],
    ):const SizedBox();
  }
}
