import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_icons.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/database/data/model/list_comic_model.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/icons/icon_image.dart';
import 'package:reading_app/core/ui/widgets/images/Image_widget.dart';

class CardFullInfoFollowRow extends StatelessWidget {
  
  final int currentIndex;
  final double heightImage;
  final ItemModel bookModel;
  final String domain;
  final bool last;

  const CardFullInfoFollowRow({
    super.key,
    required this.heightImage,
    required this.bookModel,
    required this.currentIndex,
    this.last = false,
    required this.domain,
  });

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.bookDetail, arguments: {"slug": bookModel.slug});
      },
      child: Container(
        height: heightImage + SpaceDimens.space25,
        width: Get.width,
        margin: currentIndex != 0
            ? const EdgeInsets.only(top: SpaceDimens.space25)
            : null,
        padding: const EdgeInsets.only(bottom: SpaceDimens.space25),
        decoration: BoxDecoration(
            border: !last
                ? const Border(
                    bottom: BorderSide(color: AppColors.gray3, width: 1))
                : null),
        child: Row(
          children: [
            SizedBox(
              width: heightImage,
              height: heightImage,
              child: ImageWidget(imageUrl: domain + bookModel.thumbUrl),
            ),
            const SizedBox(
              width: SpaceDimens.space10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextNormal(textChild: bookModel.name),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: SpaceDimens.space10),
                    child: Row(
                      children: [
                        const TextSmall(
                          textChild: "60.4k ${AppContents.views}",
                          colorChild: AppColors.gray1,
                        ),
                        const SizedBox(
                          width: SpaceDimens.space40,
                        ),
                        Row(
                          children: [
                            const TextSmall(
                              textChild: "5.0/5",
                              colorChild: AppColors.gray1,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            IconImage.iconImageNormal(
                                iconUrl: AppIcons.iStar,
                                size: IconsDimens.iconsSize18)
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  TextSmall(
                    textChild: bookModel.name,
                    maxLinesChild: 3,
                    colorChild: AppColors.gray2,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
