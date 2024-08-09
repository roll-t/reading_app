import 'package:flutter/widgets.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/button/elevated_button_widget.dart';

class ButtonElevated extends ElevatedButtonWidget {
  final VoidCallback onTap;
  final String iconChild;
  final String textChild;
  const ButtonElevated(
      {super.key,
      required this.onTap,
      required this.iconChild,
      required this.textChild
      })
      : super(
            ontap: onTap,
            icon: iconChild,
            text: textChild,
            padding: const EdgeInsets.all(SpaceDimens.space15),
            fontWeight: FontWeight.w500,
            textSize: IconsDimens.iconsSize20,
            backgroundcolor: AppColors.light,
            textColor: AppColors.textNormal,
            borderRadius: RadiusDimens.radiusLarge2
            );
}
