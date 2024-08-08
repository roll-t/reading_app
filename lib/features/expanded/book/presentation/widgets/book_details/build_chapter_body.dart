

import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small_light.dart';

class BuildChapterBody extends StatelessWidget {
  const BuildChapterBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 40,
        itemBuilder: (_, index) {
          return ListTile(
            leading: TextNormal(
                textChild: "${AppContents.chapter} $index:"),
            title: Row(
              children: [
                Expanded(
                    child: TextNormal(
                  textChild:
                      'Review Review Revie wRevi ewRe viewR eviewR eviewR eview Review Review$index',
                  maxLinesChild: 1,
                )),
                const SizedBox(
                  width: SpaceDimens.space10,
                ),
                const TextSmallLight(
                  textChild: "11/02/2024",
                  colorChild: AppColors.gray2,
                  maxLinesChild: 1,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}