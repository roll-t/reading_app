import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
class SimpleInputTextField extends StatelessWidget {
  final double height;
  final Color? hintColor;
  final String? hintText;
  final bool obscureText;
  final Color? backgroundColor;
  final Color? focusedColor;
  final double? focusedWidth;
  final Color? enableColor;
  final double? enableWidth;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function? onChanged;
  final Function? onCompleted;
  final Color? textColor;
  final Function()? onTap;
  final FocusNode? focusNode;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isShowBorder;
  final bool enable;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  const SimpleInputTextField({
    super.key,
    this.height = 44.0,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    required this.obscureText,
    this.backgroundColor,
    this.focusedWidth = 1,
    this.enableWidth = 1,
    this.controller,
    this.hintText,
    this.hintColor,
    this.focusedColor = AppColors.gray3,
    this.enableColor = AppColors.gray3,
    this.onTap,
    this.focusNode,
    this.labelText,
    this.textColor,
    this.onCompleted,
    this.keyboardType,
    this.isShowBorder = true,
    this.enable = true,
    this.maxLength,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        enabled: enable,
        maxLength: maxLength,
        keyboardType: keyboardType,
        controller: controller,
        onChanged: (String valueOnChanged) {
          if (onChanged != null) onChanged!(valueOnChanged);
        },
        onSubmitted: (String value) {
          if (onCompleted != null) onCompleted!(value);
        },
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        focusNode: focusNode,
        style: TextStyle(
            fontSize: TextDimens.textNormal,
            color: textColor ?? AppColors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 15.0),
          labelText: labelText,
          labelStyle: const TextStyle(
              color: AppColors.primaryHover, fontSize: TextDimens.textNormal),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          filled: backgroundColor == null ? false : true,
          fillColor: backgroundColor,
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: TextDimens.textNormal, color: hintColor),
          enabledBorder: isShowBorder
              ? OutlineInputBorder(
                  borderSide:
                      BorderSide(width: enableWidth!, color: enableColor!),
                  borderRadius: BorderRadius.circular(10.0),
                )
              : null,
          focusedBorder: isShowBorder
              ? OutlineInputBorder(
                  borderSide:
                      BorderSide(width: focusedWidth!, color: focusedColor!),
                  borderRadius: BorderRadius.circular(10.0),
                )
              : null,
        ),
      ),
    );
  }
}
