import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';
import 'package:reading_app/core/ui/widgets/textfield/input_app_normal.dart';
import 'package:reading_app/features/auth/login/presentation/controller/login_controller.dart';
import 'package:reading_app/features/auth/shared/build_share_auth.dart';

class ForgotPasswordPage extends GetView<LogInController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BuildShareAuth.buildMainBodyPage(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildShareAuth.buildTitle(
              title: AppContents.forgotPasswordTitle,
              subTitle: AppContents.subForgotPasswordTitle),
          _BuildBody()
        ],
      ),
      isLoading: false.obs,
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildBody() {
    return BuildShareAuth.buildBackgoundForm(
      childContent: Column(
        children: [
          SizedBox(
            height: Get.height * .08,
          ),
          InputAppNormal(
            lable: AppContents.email,
            placeholder: AppContents.placeholderEmail,
            controller: TextEditingController(),
          ),
          SizedBox(
            height: Get.height * .03,
          ),
          ButtonWidget(textChild: AppContents.sendCode, onTap: () {})
        ],
      ),
    );
  }
}
