// Home App Bar
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_bold.dart';

class BuildSliverCommicAppBar extends StatelessWidget {
  final String? userName;
  const BuildSliverCommicAppBar({super.key, this.userName});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true, // Hiển thị lại AppBar khi nhích lên
      snap: true, // Đảm bảo AppBar sẽ ẩn hoặc hiện hoàn toàn
      title: TextMediumBold(textChild:TextFormat.capitalizeEachWord(AppContents.commic)),
      actions: [
        InkWell(
          onTap:(){Get.toNamed(Routes.search);},
          child: const Icon(Icons.search)),
        const SizedBox(width: SpaceDimens.spaceStandard),
      ],
      expandedHeight: 60.0,
    );
  }
}
