import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';

// ignore: must_be_immutable
class ButtonTranparent extends ButtonWidget {
  final String textChild;
  final VoidCallback onTap;
  final Color textColorChild;
  ButtonTranparent({super.key, required this.textChild, required this.onTap,this.textColorChild=AppColors.textNormal})
      : super(
            text: textChild,
            ontap: onTap,
            padding: const EdgeInsets.all(SpaceDimens.space15),
            fontWeight: FontWeight.w900,
            textSize: IconsDimens.iconsSize20,
            backgroundColor: AppColors.white.withOpacity(0),
            textColor: textColorChild
            );
}
