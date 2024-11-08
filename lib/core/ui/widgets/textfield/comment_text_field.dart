import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommentTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final TextEditingController ? controller;
  final String placeholder;
  const CommentTextField({
    super.key,
    this.placeholder = "Search ...",
    this.onChanged, 
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(SpaceDimens.space10),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 100.0,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            reverse: true, // Để cuộn tự động xuống cuối khi nhập văn bản
            child: TextField(
              controller: controller,
              cursorRadius: const Radius.circular(RadiusDimens.radiusFull),
              maxLines: null, // Cho phép TextField mở rộng chiều cao
              minLines: 1, // Cho phép TextField có ít nhất 1 dòng
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 5.w, top: 2.h, bottom: 2.h),
                hintText: placeholder,
                hintStyle: const TextStyle(fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(RadiusDimens.radiusFull),
                  borderSide: BorderSide.none,
                ),
                fillColor: AppColors.tertiaryDarkBg,
                filled: true,
              ),
              onChanged: onChanged,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
            ),
          ),
        ),
      ),
    );
  }
}
