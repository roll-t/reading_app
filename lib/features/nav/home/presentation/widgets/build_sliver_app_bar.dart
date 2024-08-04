// Home App Bar
import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_bold.dart';

class BuildSliverAppBar extends StatelessWidget {
  final String? userName;
  const BuildSliverAppBar({super.key, this.userName});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.primary,
      floating: true, // Hiển thị lại AppBar khi nhích lên
      snap: true, // Đảm bảo AppBar sẽ ẩn hoặc hiện hoàn toàn
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
      actions: const [
        Icon(Icons.search),
        SizedBox(width: SpaceDimens.spaceStandard),
        Icon(Icons.notifications),
        SizedBox(width: SpaceDimens.spaceStandard)
      ],
      expandedHeight: 60.0,
    );
  }
}
