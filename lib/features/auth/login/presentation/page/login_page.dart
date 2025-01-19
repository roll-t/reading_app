import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';
import 'package:reading_app/core/ui/widgets/button/elevated_button_widget.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/ui/widgets/textfield/input_app_normal.dart';
import 'package:reading_app/features/auth/login/presentation/controller/login_controller.dart';
import 'package:reading_app/features/auth/widgets/build_share_auth.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BuildShareAuth.buildMainBodyPage(
      body: SafeArea(
        child: _buildBody(),
      ),
      isWaitProcess: controller.isWaitProcess,
      isLoading: controller.isLoading,
    );
  }

  Column _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildShareAuth.buildTitle(
            title: AppContents.login, subTitle: AppContents.subLogin),
        BuildShareAuth.buildBackgoundForm(
          childContent: Wrap(
            children: [
              InputAppNormal(
                label: AppContents.email,
                placeholder: AppContents.placeholderEmail,
                controller: controller.emailController,
                errorMess: controller.errorMessageEmail.value,
                isBorder: true,
              ),
              InputAppNormal(
                label: AppContents.password,
                placeholder: AppContents.placeholderPassword,
                isPassword: true,
                controller: controller.passwordController,
                errorMess: controller.errorMessagePassword.value,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => CustomCheckBox(
                        onChanged: (value) {
                          controller.isCheckRememberLastLogin.value = value;
                        },
                        value: controller.isCheckRememberLastLogin.value,
                        borderColor: AppColors.gray3,
                        checkBoxSize: SpaceDimens.space25,
                        checkedFillColor: AppColors.accentColor,
                      )),
                  TextWidget(
                    text: AppContents.rememberMe,
                    color: AppColors.textLightActive,
                    fontWeight: FontWeight.w300,
                    size: 17.sp,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: ButtonWidget(
                    rounder: true,
                    padding: EdgeInsets.symmetric(vertical: 3.w),
                    textChild: AppContents.login,
                    onTap: () async {
                      await controller.handleLogin();
                    }),
              ),
              _buildLoginMethod()
            ],
          ),
        )
      ],
    );
  }

  Column _buildLoginMethod() {
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
              onTap: () {},
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
            controller.handleLoginWithGoogle();
          },
          text: "Đăng nhập với google",
          backgroundcolor: AppColors.white,
          textColor: AppColors.primary,
          borderRadius: 50.0,
        ),
      ],
    );
  }
}
