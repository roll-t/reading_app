import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/features/materials/book/model/info_book_detail_model.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/shared/build_tag_react.dart';

class BuildSliverAppBarBookDetail extends StatelessWidget {
  final RxDouble opacityAppBarTitle;
  final InfoBookDetailModel infoBookDetailModel;

  const BuildSliverAppBarBookDetail({
    super.key,
    required this.infoBookDetailModel,
    required this.opacityAppBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: 400.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: Get.width * .1 + SpaceDimens.space20,
              child: CachedNetworkImage(
                imageUrl: infoBookDetailModel.thumbImage,
                fit: BoxFit.fitHeight,
                errorWidget: (context, url, error) {
                  return Image.asset(AppImages.iNoImage, fit: BoxFit.cover);
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 150,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(0, 24, 24, 24),
                    AppColors.black,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              ),
            ),
            Positioned(
                left: SpaceDimens.spaceStandard,
                right: SpaceDimens.spaceStandard,
                bottom: SpaceDimens.space20,
                child: BuildTagReact(
                  title: infoBookDetailModel.bookTitle,
                  countChapters: infoBookDetailModel.countChapter,
                  countView: infoBookDetailModel.view,
                  rating: infoBookDetailModel.rating,
                ))
          ],
        ),
      ),
      leading: const leadingIconAppBar(),
      title: Obx(() => AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: opacityAppBarTitle.value,
          child: TextWidget(
            text: TextFormat.capitalizeEachWord(infoBookDetailModel.bookTitle),
            size: TextDimens.textMedium,
            fontWeight: FontWeight.w500,
          ))),
    );
  }
}
