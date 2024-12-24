// Home App Bar
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_medium_bold.dart';

class BuildSliverAppBar extends StatelessWidget {
  final String? userName;
  const BuildSliverAppBar({super.key, this.userName});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.primary,
      floating: true,
      snap: true,
      title: userName != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const TextMediumBold(textChild: AppContents.hello),
                const SizedBox(
                  height: SpaceDimens.space5,
                ),
                TextMediumBold(textChild: userName ?? ""),
              ],
            )
          : const InkWell(
              child: TextMediumBold(
                textChild: AppContents.login,
              ),
            ),
      actions: [
        InkWell(
            onTap: () {
              Get.toNamed(Routes.search);
            },
            child: const Icon(Icons.search)),
        const SizedBox(width: SpaceDimens.spaceStandard),
        InkWell(
          onTap: (){Get.toNamed(Routes.notification);},
          child: const Icon(Icons.notifications)),
        const SizedBox(width: SpaceDimens.spaceStandard)
      ],
      expandedHeight: 60.0,
    );
  }
}
