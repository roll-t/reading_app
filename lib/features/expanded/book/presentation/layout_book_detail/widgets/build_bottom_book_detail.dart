import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_bold.dart';

class BuildBottomNavBookDetail extends StatelessWidget {
  const BuildBottomNavBookDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: SpaceDimens.space5, horizontal: SpaceDimens.spaceStandard),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: SpaceDimens.space10,
            children: [
              Container(
                padding: const EdgeInsets.all(SpaceDimens.space5),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.gray3),
                    borderRadius:
                        BorderRadius.circular(RadiusDimens.radiusFull)),
                child: const Icon(Icons.download),
              ),
              Container(
                padding: const EdgeInsets.all(SpaceDimens.space5),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.gray3),
                    borderRadius:
                        BorderRadius.circular(RadiusDimens.radiusFull)),
                child: const Icon(Icons.favorite_border_sharp),
              ),
            ],
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.readBook);
              },
              child: Container(
                margin: const EdgeInsets.only(left: SpaceDimens.space20),
                padding:
                    const EdgeInsets.symmetric(horizontal: SpaceDimens.space30),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(RadiusDimens.radiusFull),
                    color: AppColors.accentColor),
                height: 50,
                child: const Center(
                    child: TextLargeBold(
                  textChild: AppContents.readNow,
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
