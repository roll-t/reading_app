import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal_light.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildEmptySateBookcase extends StatelessWidget {
  const BuildEmptySateBookcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 5.h),
          const Icon(Icons.import_contacts, color: AppColors.gray2, size: 23),
          SizedBox(height: 1.h),
          const TextNormalLight(
            textChild: AppContents.bookcaseIsEmpty,
            colorChild: AppColors.gray2,
          ),
        ],
      ),
    );
  }
}
