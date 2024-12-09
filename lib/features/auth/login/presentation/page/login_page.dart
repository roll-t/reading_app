import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/input_app_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal_light.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';
import 'package:reading_app/core/ui/widgets/button/elevated_button_widget.dart';
import 'package:reading_app/features/auth/login/presentation/controller/login_controller.dart';
import 'package:reading_app/features/auth/shared/build_share_auth.dart';

class LoginPage extends GetView<LogInController> {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BuildShareAuth.buildMainBodyPage(
      body: SafeArea(
        child: _BuildBody(),
      ),
      isLoading: controller.isLoading,
    );
  }

  // ignore: non_constant_identifier_names
  Column _BuildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildShareAuth.buildTitle(
            title: AppContents.login, subTitle: AppContents.subLogin),
        BuildShareAuth.buildBackgoundForm(
          childContent: Wrap(
            children: [
              Obx(
                () => InputAppNormal(
                  lable: AppContents.email,
                  placeholder: AppContents.placeholderEmail,
                  controller: controller.emailController,
                  errorMess: controller.errorMessageEmail.value,
                  isBorder: true,
                ),
              ),
              Obx(
                () => InputAppNormal(
                  lable: AppContents.password,
                  placeholder: AppContents.placeholderPassword,
                  isPassword: true,
                  controller: controller.passwordController,
                  errorMess: controller.errorMessagePassword.value,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => CustomCheckBox(
                      onChanged: (value) {
                        controller.toggleCheck();
                      },
                      value: controller.isCheckRememberAccount.value,
                      borderColor: AppColors.gray3,
                      checkBoxSize: SpaceDimens.space25,
                      checkedFillColor: AppColors.accentColor,
                    ),
                  ),
                  const TextNormalLight(
                      textChild: AppContents.rememberMe,
                      colorChild: AppColors.textLightActive),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        Get.toNamed(Routes.forgotPassword);
                      },
                      child: const TextNormalLight(
                          textChild: AppContents.forgotPassword,
                          colorChild: AppColors.accentColor)),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: ButtonWidget(
                    textChild: AppContents.login,
                    onTap: () async {
                      await controller.handleLogin();
                    }),
              ),
              _BuildLoginMethod()
            ],
          ),
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Column _BuildLoginMethod() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextNormal(textChild: AppContents.dontHaveAnAccount),
            InkWell(
              onTap: controller.toSignUp,
              child: const TextNormal(
                textChild: AppContents.createHere,
                colorChild: AppColors.accentColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: SpaceDimens.space10,
        ),
        const TextNormal(textChild: AppContents.or),
        const SizedBox(
          height: SpaceDimens.space10,
        ),
        ElevatedButtonWidget(
          icon: AppImages.iGoogle,
          ontap: () async {
            await controller.handleSignInWithGoogle();
          },
          text: "Sign in with Google",
          backgroundcolor: AppColors.white,
          textColor: AppColors.primary,
          borderRadius: 50.0,
        ),
      ],
    );
  }
}
