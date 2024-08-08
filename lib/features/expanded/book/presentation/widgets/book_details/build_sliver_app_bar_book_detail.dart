

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/features/expanded/book/presentation/widgets/book_details/build_tag_react.dart';

class BuildSliverAppBarBookDetail extends StatelessWidget {
  const BuildSliverAppBarBookDetail({
    super.key,
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
                imageUrl:
                    "https://truyenaudio.org/upload/pro/Le-Tinh-Truyen-Ngan-Tinh-Yeu.jpg",
                fit: BoxFit.cover,
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
            const Positioned(
                left: SpaceDimens.spaceStandard,
                right: SpaceDimens.spaceStandard,
                bottom: SpaceDimens.space20,
                child: BuildTagReact())
          ],
        ),
      ),
      leading: const leadingIconAppBar(),
      title: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity:
            1.0, // You can customize this based on the scroll position
        child: TextMedium(
          textChild: TextFormat.capitalizeEachWord(
              "Tiêu đề cuốn sách được viết ở đây "),
          maxLinesChild: 1,
        ),
      ),
    );
  }
}
