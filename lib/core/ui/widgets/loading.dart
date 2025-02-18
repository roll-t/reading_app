import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Loading extends StatelessWidget {
  final RxBool isLoading;
  final Widget bodyBuilder;
  final RxBool? isLoadMore;
  final RxBool? isWaitProcess;
  final Widget shimmerLoadMoreWidget;

  const Loading({
    super.key,
    required this.isLoading,
    required this.bodyBuilder,
    this.isLoadMore,
    this.isWaitProcess,
    this.shimmerLoadMoreWidget = const CircularProgressIndicator(),
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading.value) {
        return Center(
          child: Image.asset(
            width: 40.w,
            AppImages.iLoading,
          ),
        );
      }
      return Stack(
        children: [
          Column(
            children: [
              Expanded(child: bodyBuilder),
              if (isLoadMore?.value == true)
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: shimmerLoadMoreWidget),
            ],
          ),
          if (isWaitProcess?.value == true)
            Positioned.fill(
              child: Container(
                color: AppColors.black.withOpacity(0.6),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      );
    });
  }
}
