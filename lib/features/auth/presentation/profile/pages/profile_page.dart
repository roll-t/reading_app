import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/configs/assets/app_vectors.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/widgets/avatar/avatar.dart';
import 'package:reading_app/core/ui/widgets/background/custom_container.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';
import 'package:reading_app/core/ui/widgets/loading.dart';
import 'package:reading_app/core/ui/widgets/svg_icon_widget.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_medium.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_small.dart';
import 'package:reading_app/features/auth/presentation/profile/controllers/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () {
            return controller.isLogin.value
                ? _buildBodyAccount()
                : _loginRequest();
          },
        ),
      ),
    );
  }

  Widget _loginRequest() {
    return Loading(
        isLoading: controller.isLoading,
        bodyBuilder: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.space30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                textChild: AppContents.login,
                onTap: () async {
                  await controller.handleLogin();
                },
              ),
            ],
          ),
        ));
  }

  Widget _buildBodyAccount() {
    return Loading(
      isLoading: controller.isLoading,
      bodyBuilder: GetBuilder<ProfileController>(
        id: "bodyId",
        builder: (_) => Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.spaceStandard),
          child: CustomScrollView(
            slivers: [
              _buildSpacer(),
              _buildProfileHeader(),
              _buildSpacer(),
              _buildDarkModeSetting(),
              _buildSpacer(),
              _buildDarkLanguageSetting(),
              _buildSpacer(),
              SliverToBoxAdapter(
                child: CustomContainer.customBackgroundBox(
                  childBuilder: const Row(
                    children: [Text("Theme Setting")],
                  ),
                ),
              ),
              _buildSpacer(),
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return SliverToBoxAdapter(
      child: CustomContainer.customBackgroundBox(
        childBuilder: Row(
          children: [
            Avatar(
              radius: 70,
              url: controller.userModel.value.photoURL,
            ),
            const SizedBox(width: AppDimens.spaceStandard),
            _buildProfileInfo(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.gray2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Expanded(
      child: InkWell(
        onTap: () async {
          var result = await Get.toNamed(Routes.myInfo,
              arguments: controller.userModel.value);
          if (result == true) {
            await controller.reloadData();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextMedium(
              textChild: controller.userModel.value.displayName ?? "UserName",
            ),
            TextSmall(
              textChild: controller.userModel.value.email,
              maxLinesChild: 1,
              colorChild: AppColors.gray2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDarkModeSetting() {
    return SliverToBoxAdapter(
      child: CustomContainer.customBackgroundBox(
        childBuilder: Row(
          children: [
            const SvgIconWidget(
              svgUrl: AppVectors.vDark,
            ),
            const SizedBox(
              width: 20,
            ),
            const TextNormal(
              textChild: "Chế độ ban đêm",
            ),
            const Spacer(),
            Switch(
              value: true,
              onChanged: (value) {},
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDarkLanguageSetting() {
    return SliverToBoxAdapter(
      child: CustomContainer.customBackgroundBox(
        childBuilder: Row(
          children: [
            SvgPicture.asset(
              width: 25,
              AppVectors.vLanguage,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const TextNormal(
              textChild: "Ngôn ngữ",
            ),
            const Spacer(),
            Row(
              children: [
                _buildIconLanguage(
                  iconUrl: AppImages.iVnFlag,
                  active: true,
                  onTap: () {},
                ),
                const SizedBox(
                  width: 15,
                ),
                _buildIconLanguage(
                  iconUrl: AppImages.iUkFlag,
                  active: false,
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  InkWell _buildIconLanguage({
    required String iconUrl,
    double size = 30,
    bool active = false,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        decoration: BoxDecoration(
          border: Border.all(
            width: active ? 2 : 0,
            color: AppColors.white,
          ),
          borderRadius: BorderRadius.circular(1000),
        ),
        child: Opacity(
          opacity: active ? 1 : 0.5,
          child: Image.asset(
            iconUrl,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SliverToBoxAdapter(
      child: ButtonWidget(
        textChild: AppContents.logout,
        onTap: () async {
          await controller.logout();
        },
        rounder: true,
        padding: const EdgeInsets.symmetric(vertical: AppDimens.space10),
      ),
    );
  }

  Widget _buildSpacer() {
    return const SliverToBoxAdapter(
      child: SizedBox(height: AppDimens.space20),
    );
  }
}
