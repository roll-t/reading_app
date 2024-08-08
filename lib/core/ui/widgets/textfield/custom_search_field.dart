


import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class CustomSearchField extends StatelessWidget {
  final String? placeholder;
  const CustomSearchField({
    super.key, 
    this.placeholder = "Search ...",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
          decoration: InputDecoration(
            hintText:placeholder,
            hintStyle: const TextStyle(fontWeight: FontWeight.w400),
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColors.tertiaryDarkBg,
          ),
        );
  }
}

