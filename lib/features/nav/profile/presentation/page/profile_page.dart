import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/button/button_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/custom_backgound/custom_container.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/avatar/avatar.dart';
import 'package:reading_app/core/ui/widgets/loading.dart';
import 'package:reading_app/features/nav/profile/presentation/controller/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return controller.isLogin.value ? _BuildBodyAccount() : _LoginRequest();
    }));
  }

  // ignore: non_constant_identifier_names
  Widget _LoginRequest() {
    return Loading(
        isLoading: controller.isLoading,
        bodyBuilder: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SpaceDimens.space30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonNormal(
                textChild: AppContents.login,
                onTap: () async {
                  await controller.handleLogin();
                },
              ),
            ],
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Widget _BuildBodyAccount() {
    return Loading(
        isLoading: controller.isLoading,
        bodyBuilder: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: SpaceDimens.spaceStandard),
          child: CustomScrollView(
            slivers: [
              _buildSpacer(),
              _buildProfileHeader(),
              _buildSpacer(),
              _buildResearchStatus(),
              _buildSpacer(),
              _buildResearchStatus(),
              _buildSpacer(),
              _buildSettings(),
              _buildSpacer(),
              _buildLogoutButton(),
            ],
          ),
        ));
  }

  Widget _buildProfileHeader() {
    return SliverToBoxAdapter(
      child: CustomContainer.customBackgroudBox(
        childBuilder: Row(
          children: [
            Avatar(
              radius: 70,
              url: controller.userModel.value.photoURL,
            ),
            const SizedBox(width: SpaceDimens.spaceStandard),
            _buildProfileInfo(),
            const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.gray2),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.myInfo);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextMedium(
                textChild: controller.userModel.value.displayName ?? "no name"),
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

  Widget _buildResearchStatus() {
    return SliverToBoxAdapter(
      child: CustomContainer.customBackgroudBox(
        childBuilder: const TextNormal(
            textChild: "Đang nghiên cứu", colorChild: AppColors.gray2),
      ),
    );
  }

  Widget _buildSettings() {
    return SliverToBoxAdapter(
      child: CustomContainer.customBackgroudBox(
        childBuilder: Column(
          children: [
            _buildSettingItem(AppContents.notification, Icons.notifications),
            _buildSettingItem(AppContents.referFriend, Icons.share),
            _buildSettingItem(AppContents.ratingApp, Icons.star),
            _buildSettingItem(AppContents.setting, Icons.settings),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(String title, IconData icon) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.notification);
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: SpaceDimens.spaceStandard),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.gray3, width: 1)),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: SpaceDimens.space20),
            Expanded(child: TextNormal(textChild: title)),
            const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.gray2),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SliverToBoxAdapter(
      child: ButtonNormal(
        textChild: AppContents.logout,
        onTap: () async {
          await controller.logout();
        },
        rounder: true,
        paddingChild: const EdgeInsets.symmetric(vertical: SpaceDimens.space10),
      ),
    );
  }

  Widget _buildSpacer() {
    return const SliverToBoxAdapter(
      child: SizedBox(height: SpaceDimens.space20),
    );
  }
}
