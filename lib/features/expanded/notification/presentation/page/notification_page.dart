import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        centerTitle: true,
        title: TextMediumSemiBold(
          textChild: TextFormat.capitalizeEachWord(AppContents.notification),
        ),
      ),
      body: const Center(
        child: TextNormal(
          textChild: "Không có thông báo nào",
        ),
      ),
    );
  }
}
