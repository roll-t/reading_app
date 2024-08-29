import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_icons.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/services/data/model/comic_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/icons/icon_image.dart';
import 'package:reading_app/features/expanded/book/widgets/shared/icon_rounder.dart';

class BuildTagReact extends StatelessWidget {
  final ComicModel ? comicModel;

  const BuildTagReact({
    super.key, 
    this.comicModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3)),
      ], borderRadius: BorderRadius.circular(10), color: AppColors.black),
      padding: const EdgeInsets.symmetric(
          horizontal: SpaceDimens.spaceStandard, vertical: SpaceDimens.space15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextMediumSemiBold(
            textChild:comicModel!=null ? comicModel!.title: "",maxLinesChild: 3,
          ),
          const SizedBox(
            height: SpaceDimens.space15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  IconsRounder(
                    iconData: Icons.remove_red_eye_outlined,
                  ),
                  SizedBox(
                    width: SpaceDimens.space10,
                  ),
                  Column(
                    children: [
                      TextSmall(
                        textChild: AppContents.read,
                        colorChild: AppColors.gray2,
                      ),
                      TextNormal(textChild: "78.3K")
                    ],
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  showRatingBottomSheet(context);
                },
                child: Row(
                  children: [
                    const IconsRounder(
                      iconData: Icons.thumb_up_alt_outlined,
                    ),
                    const SizedBox(
                      width: SpaceDimens.space10,
                    ),
                    Column(
                      children: [
                        const TextSmall(
                          textChild: AppContents.rating,
                          colorChild: AppColors.gray2,
                        ),
                        Row(
                          children: [
                            const TextNormal(textChild: "4.3"),
                            const SizedBox(
                              width: 2,
                            ),
                            IconImage.iconImageNormal(
                                iconUrl: AppIcons.iStar,
                                size: IconsDimens.iconsSize18)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Row(
                children: [
                  IconsRounder(
                    iconData: Icons.list_alt,
                  ),
                  SizedBox(
                    width: SpaceDimens.space10,
                  ),
                  Column(
                    children: [
                      TextSmall(
                        textChild: AppContents.chapter,
                        colorChild: AppColors.gray2,
                      ),
                      TextNormal(textChild: "120")
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showRatingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(RadiusDimens.radiusMedium2),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          width: Get.width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                AppContents.ratingBook,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star_rounded,
                  color: AppColors.yellow,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(height: SpaceDimens.spaceStandard),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Handle submit rating
                  },
                  child: const TextMediumSemiBold(
                    textChild: AppContents.send,
                    colorChild: AppColors.accentColor,
                  )),
            ],
          ),
        );
      },
    );
  }
}
