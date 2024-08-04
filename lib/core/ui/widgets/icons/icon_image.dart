import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';

class IconImage {
  static Widget iconImageSub({
    required String iconUrl,
    String? sub,
  }) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Ensures Column takes up only needed space
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centers items horizontally
        children: [
          Image.asset(
            iconUrl,
            width: IconsDimens.semiSmall,
            height: IconsDimens.semiSmall,
          ),
          if (sub != null) ...[
            const SizedBox(height: SpaceDimens.space5),
            TextSmall(
              textChild: sub,
              colorChild: AppColors.gray1,
            ),
          ],
        ],
      ),
    );
  }

  static Widget iconImageNormal(
      {required String iconUrl, double size = IconsDimens.semiSmall}) {
    return Image.asset(
      iconUrl,
      width: size,
      height: size,
    );
  }
}
