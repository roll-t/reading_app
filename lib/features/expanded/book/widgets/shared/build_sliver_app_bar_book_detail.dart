

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/database/data/model/comic_model.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/book_detail_controller.dart';
import 'package:reading_app/features/expanded/book/widgets/shared/build_tag_react.dart';

class BuildSliverAppBarBookDetail extends StatelessWidget {
  final ComicModel ? comicModel;
  final BookDetailController controller;
  const BuildSliverAppBarBookDetail({
    super.key, 
    required this.controller,
    this.comicModel, 
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: 350.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: Get.width * .1 + SpaceDimens.space20,
              child: CachedNetworkImage(
                width: Get.width,
                imageUrl:comicModel !=null? comicModel!.thumb : "https://img.faloo.com/Novel/498x705/0/357/000357913.jpg",
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Image.network(comicModel!.thumb,fit: BoxFit.cover);
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
                  gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(0, 24, 24, 24),
                        AppColors.black,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
              ),
            ),
            Positioned(
                left: SpaceDimens.spaceStandard,
                right: SpaceDimens.spaceStandard,
                bottom: SpaceDimens.space20,
                child: BuildTagReact(comicModel: comicModel,))
          ],
        ),
      ),
      leading: const leadingIconAppBar(),
      title: Obx(() => AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: controller.opacity.value,
        child: TextMedium(
          textChild: TextFormat.capitalizeEachWord(controller.title),
          maxLinesChild: 1,
        ),
      )),
    );
  }
}