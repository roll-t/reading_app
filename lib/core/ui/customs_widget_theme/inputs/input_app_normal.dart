import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Thêm import này để sử dụng FilteringTextInputFormatter
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal_light.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class InputAppNormal extends StatefulWidget {
  final String lable;
  final String placeholder;
  final bool isPassword;
  final bool isNumeric; // Thêm thuộc tính để xác định kiểu bàn phím
  final TextEditingController controller; // Sử dụng thuộc tính controller
  final String errorMess;
  final bool isBorderCustom;
  final bool isBorder;

  const InputAppNormal({
    super.key,
    this.lable = "",
    this.placeholder = "",
    this.isPassword = false,
    this.isNumeric = false,
    required this.controller,
    this.errorMess = "",
    this.isBorderCustom = false,
    this.isBorder = true,
  });

  @override
  // ignore: library_private_types_in_public_api
  _InputAppNormalState createState() => _InputAppNormalState();
}

class _InputAppNormalState extends State<InputAppNormal> {
  final FocusNode _focusNode = FocusNode();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.lable.isNotEmpty
            ? TextNormalLight(textChild: widget.lable)
            : const SizedBox(),
        Container(
          padding: const EdgeInsets.all(SpaceDimens.space5),
          margin: const EdgeInsets.only(top: SpaceDimens.space5),
          decoration: BoxDecoration(
              border: widget.isBorderCustom
                  ? Border.all(color: AppColors.white, width: 2)
                  : null,
              borderRadius: BorderRadius.circular(RadiusDimens.radiusSmall1),
              color: AppColors.black),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,

            obscureText: widget.isPassword ? _obscureText : false,
            textCapitalization: TextCapitalization.sentences,
            keyboardType:
                widget.isNumeric ? TextInputType.number : TextInputType.text,
            inputFormatters: widget.isNumeric
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1)
                  ]
                : null, // Hạn chế chỉ cho phép một ký tự số
            style: const TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              fillColor: AppColors.black,
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withOpacity(.6)),
              border: widget.isBorder
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: AppColors.white))
                  : InputBorder.none,
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: AppColors.accentColor)),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText =
                              !_obscureText;
                        });
                      },
                    )
                  : null,
            ),
            onEditingComplete: () {
              _focusNode.unfocus();
            },
          ),
        ),
        TextWidget(
          text: widget.errorMess,
          size: TextDimens.textSize12,
          color: AppColors.error,
          fontWeight: FontWeight.w300,
        )
      ],
    );
  }
}
