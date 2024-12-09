import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/materials/book/presentation/controller/widget_controller.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends GetView<WidgetController> {
  final int starCount;
  final double initialRating;
  final RatingChangeCallback onRatingChanged;
  final Color color;
  final double height;

  const StarRating({
    super.key,
    this.starCount = 5,
    this.height = 15,
    this.initialRating = 0.0,
    required this.onRatingChanged,
    required this.color,
  });

  void _onStarTap(WidgetController controller, int index, TapDownDetails details) {
    double newRating;
    if (details.localPosition.dx < 15) {
      // Assuming 15 is half the star size
      newRating = index + 0.5;
    } else {
      newRating = index + 1.0;
    }
    controller.updateRating(newRating);
    onRatingChanged(newRating);
  }

  Widget buildStar(BuildContext context, WidgetController controller, int index) {
    Icon icon;
    if (index >= controller.currentRating.value) {
      icon = Icon(
        Icons.star_border,
        color: Colors.grey, // Use your defined AppColors.gray37
        size: height, // Adjust size as needed
      );
    } else if (index > controller.currentRating.value - 1 && index < controller.currentRating.value) {
      icon = Icon(
        Icons.star_half,
        color: color,
        size: height, // Adjust size as needed
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
        size: height, // Adjust size as needed
      );
    }
    return GestureDetector(
      onTapDown: (details) => _onStarTap(controller, index, details),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WidgetController());
    controller.updateRating(initialRating); // Set initial rating

    return Obx(() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          starCount,
          (index) => buildStar(context, controller, index),
        ),
      );
    });
  }
}
