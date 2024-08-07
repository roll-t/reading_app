import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';

class BuildButtomToExplore extends StatelessWidget {
  const BuildButtomToExplore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Get.toNamed(Routes.search);},
      child: Container(
          margin: const EdgeInsets.only(top: SpaceDimens.space40),
          padding: const EdgeInsets.symmetric(
              horizontal: SpaceDimens.space50),
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: SpaceDimens.space10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.secondaryColor,
            ),
            child: const InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book),
                  SizedBox(
                    width: SpaceDimens.space5,
                  ),
                  TextNormal(
                    textChild: AppContents.exploreMore,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
