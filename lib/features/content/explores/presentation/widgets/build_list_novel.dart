import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/novel_response.dart';
import 'package:reading_app/core/ui/widgets/card/novel_explore.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal_light.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class BuildListNovel extends StatelessWidget {
  final List<NovelResponse> listBookData;
  final bool? isLoading;
  const BuildListNovel({
    super.key,
    required this.listBookData,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? _buildShimmerEffect()
        : listBookData.isEmpty
            ? SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: const Center(
                      child: TextNormalLight(
                    textChild: "Không có truyện",
                    colorChild: AppColors.gray2,
                  )),
                ),
              )
            : SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: SpaceDimens.space20,
                    vertical: SpaceDimens.space15),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.6 / 3,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                          alignment: Alignment.center,
                          child: NovelExplore(
                            widthCard: 14.h,
                            heightCard: 25.h,
                            bookModel: listBookData[index],
                          ));
                    },
                    childCount: listBookData.length,
                  ),
                ),
              );
  }

  Widget _buildShimmerEffect() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
          horizontal: SpaceDimens.space20, vertical: SpaceDimens.space15),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 3.w,
          childAspectRatio: 1.6 / 3,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Shimmer.fromColors(
              baseColor: AppColors.shimmerBase,
              highlightColor: AppColors.shimmerHighlight,
              child: Container(
                width: 14.h,
                height: 16.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
          childCount: 9, // Show 6 shimmer placeholders
        ),
      ),
    );
  }
}
