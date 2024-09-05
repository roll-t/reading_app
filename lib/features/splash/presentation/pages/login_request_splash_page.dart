import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/button/button_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/features/splash/presentation/controller/login_request_splash_controller.dart';

class LoginRequestSplashPage extends GetView<LoginRequestSplashController> {
  const LoginRequestSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const leadingIconAppBar(),),
      body: Padding(
        padding: const EdgeInsets.all(SpaceDimens.space40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextMediumSemiBold(textChild: "Đăng nhập để tiếp tục đọc"),
            const SizedBox(height: SpaceDimens.space25,),
            ButtonNormal(
              onTap: () {Get.offNamed(Routes.login);},
              textChild: "Đăng nhập",
            ),
          ],
        ),
      ),
    );
  }
}
