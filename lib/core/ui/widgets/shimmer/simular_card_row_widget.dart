import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class SimularCardRowWidget extends StatelessWidget {
  final double heightImage;
  final bool last;

  const SimularCardRowWidget({
    super.key,
    required this.heightImage,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightImage + SpaceDimens.space25,
      width: double.infinity,
      margin: const EdgeInsets.only(top: SpaceDimens.space15),
      padding: const EdgeInsets.only(bottom: SpaceDimens.space15),
      decoration: BoxDecoration(
        border: !last
            ? const Border(
                bottom: BorderSide(color: AppColors.gray3, width: .5))
            : null,
      ),
      child: Row(
        children: [
          _buildShimmerBox(width: heightImage, height: heightImage),
          const SizedBox(width: SpaceDimens.space15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.w,
                ),
                _buildShimmerBox(
                  height: 14,
                  width: double.infinity,
                ),
                const SizedBox(height: 8),
                _buildShimmerBox(
                  height: 14,
                  width: 100,
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerBox({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.shimmerBase,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
