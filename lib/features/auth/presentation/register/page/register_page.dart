import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/ui/widgets/textfield/input_app_normal.dart';
import 'package:reading_app/features/auth/presentation/register/controller/register_controller.dart';
import 'package:reading_app/features/auth/presentation/widgets/build_share_auth.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BuildShareAuth.buildMainBodyPage(
        appbar: const leadingIconAppBar(),
        body: Column(
          children: [
            BuildShareAuth.buildTitle(
              title: AppContents.signUp,
              subTitle: AppContents.subSignUp,
            ),
            _BuildBody()
          ],
        ),
        isWaitProcess: controller.isLoading,
        isLoading: false.obs,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildBody() {
    return BuildShareAuth.buildBackgoundForm(
        childContent: Obx(
      () => Wrap(
        runSpacing: AppDimens.space20,
        children: [
          InputAppNormal(
            label: AppContents.name,
            placeholder: AppContents.placeholderName,
            controller: controller.nameController, // Cung cấp controller
            errorMess: controller.errorMessageName.value,
          ),
          InputAppNormal(
            label: AppContents.email,
            placeholder: AppContents.placeholderEmail,
            controller: controller.emailController, // Cung cấp controller
            errorMess: controller.errorMessageEmail.value,
          ),
          InputAppNormal(
            label: AppContents.password,
            placeholder: AppContents.placeholderPassword,
            isPassword: true,
            controller: controller.passwordController, // Cung cấp controller
            errorMess: controller.errorMessagePassword.value,
          ),
          InputAppNormal(
            label: AppContents.passwordConfirm,
            placeholder: AppContents.placeholderPassword,
            isPassword: true,
            controller:
                controller.passwordConfirmController, // Cung cấp controller
            errorMess: controller.errorMessagePasswordConfirm.value,
          ),
          ButtonWidget(
            onTap: () {
              controller.signUp();
            },
            textSize: 18,
            background: AppColors.accentColor,
            textColor: Colors.white,
            rounder: true,
            borderRadius: 20,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: TextWidget(
                fontWeight: FontWeight.w500,
                size: AppDimens.textSize18,
                text: AppContents.signUp),
          ),
        ],
      ),
    ));
  }
}
