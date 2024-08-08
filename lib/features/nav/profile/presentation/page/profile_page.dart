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
import 'package:reading_app/core/ui/widgets/images/image_widget.dart';
import 'package:reading_app/features/nav/profile/presentation/controller/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpaceDimens.spaceStandard),
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
      ),
    );
  }

  Widget _buildProfileHeader() {
    return SliverToBoxAdapter(
      child: CustomContainer.customBackgroudBox(
        childBuilder: Row(
          children: [
            _buildProfileImage(),
            const SizedBox(width: SpaceDimens.spaceStandard),
            _buildProfileInfo(),
            const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.gray2),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
      ),
      child: const ClipOval(
        child: ImageWidget(
          imageUrl: "https://th.bing.com/th/id/R.7c0985982d01910e15155653b42383fe?rik=ztlbiol8pb1R1w&pid=ImgRaw&r=0",
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Expanded(
      child: InkWell(
        onTap: (){Get.toNamed(Routes.myInfo);},
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextMedium(textChild: "P T"),
            TextSmall(
              textChild: "phuoctruong727@gmail.com",
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
        childBuilder: const TextNormal(textChild: "Đang nghiên cứu", colorChild: AppColors.gray2),
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
      onTap: (){Get.toNamed(Routes.notification);},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: SpaceDimens.spaceStandard),
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
        onTap: () {},
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
