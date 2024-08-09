
import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class CommentTextField extends StatelessWidget {
  final String placeholder;
  const CommentTextField({
    super.key, 
    this.placeholder = "Search ...",
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(SpaceDimens.space10),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 100.0, // Chiều cao tối đa tương ứng với 4 dòng
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            reverse: true, // Để cuộn tự động xuống cuối khi nhập văn bản
            child: TextField(
              cursorRadius: const Radius.circular(RadiusDimens.radiusFull),
              maxLines: null, // Cho phép TextField mở rộng chiều cao
              minLines: 1, // Cho phép TextField có ít nhất 1 dòng
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: const TextStyle(fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(RadiusDimens.radiusFull),
                  borderSide: BorderSide.none,
                ),
                fillColor: AppColors.tertiaryDarkBg,
                filled: true,
              ),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
            ),
          ),
        ),
      ),
    );
  }
}
