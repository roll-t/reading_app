import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/core/ui/widgets/card/comic_card_widget.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal_light.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class BuildListComic extends StatelessWidget {
  final ListComicModel listBookData;
  final bool? isLoading;
  const BuildListComic({
    super.key,
    required this.listBookData,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return _buildShimmerEffect();
    }

    return listBookData.items.isEmpty
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
                horizontal: SpaceDimens.space20, vertical: SpaceDimens.space15),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3.w,
                mainAxisSpacing: 3.w,
                childAspectRatio: 1.6 / 3,
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                    alignment: Alignment.center,
                    child: ComicCardWidget(
                      width: 14.h,
                      slug: listBookData.items[index].slug,
                      comicId: listBookData.items[index].id,
                      heightImage: 18.h,
                      thumbUrl: listBookData.items[index].thumbUrl,
                      comicTitle: listBookData.items[index].name,
                    ));
              }, childCount: listBookData.items.length),
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
