import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_light.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal_light.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small_light.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small_semi_bold.dart';
import 'package:reading_app/features/nav/profile/presentation/controller/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text Large
              TextLargeBold(textChild: "Phạm Phước Trường"),
              TextLargeSemiBold(textChild: "Phạm Phước Trường"),
              TextLarge(textChild: "Phạm Phước Trường"),
              TextLargeLight(textChild: "Phạm Phước Trường"),
          
              // Text Normal
              TextNormalBold(textChild: "Phạm Phước Trường"),
              TextNormalSemiBold(textChild: "Phạm Phước Trường"),
              TextNormal(textChild: "Phạm Phước Trường"),
              TextNormalLight(textChild: "Phạm Phước Trường"),
          
              // Text Small
              TextSmallBold(textChild: "Phạm Phước Trường"),
              TextSmallSemiBold(textChild: "Phạm Phước Trường"),
              TextSmall(textChild: "Phạm Phước Trường"),
              TextSmallLight(textChild: "Phạm Phước Trường"),
          
            ],
          ),
        ),
      ),
    );
  }
}
