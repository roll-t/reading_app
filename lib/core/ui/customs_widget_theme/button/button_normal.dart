import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';

// ignore: must_be_immutable
class ButtonNormal extends ButtonWidget {
  final String textChild;
  final VoidCallback onTap;
  final double  textSizeChild;
  final bool rounder;
  final Color ?backgroundChild;
  final EdgeInsetsGeometry paddingChild;
  
  ButtonNormal({
  super.key, required this.textChild, 
  required this.onTap,
  this.rounder=false, 
  this.backgroundChild = AppColors.secondaryColor, 
  this.textSizeChild=AppDimens.iconsSize20,
  this.paddingChild= const EdgeInsets.all(AppDimens.paddingSpace15),
  })
      : super(
            text: textChild,
            ontap: onTap,
            padding:paddingChild,
            fontWeight: FontWeight.w500,
            textSize: textSizeChild,
            borderRadius:  rounder ? 10000 : 10,
            backgroundColor: backgroundChild

            );
}