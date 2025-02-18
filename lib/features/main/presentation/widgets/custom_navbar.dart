import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/features/main/presentation/controller/main_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomNavbar extends GetView<MainController> {
  final double radiusFull = RadiusDimens.radiusFull;
  final Color primaryColor = AppColors.primary;
  final Color whiteColor = Colors.white;
  const CustomNavbar({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 1.5.h,
      left: 10.w,
      right: 10.w,
      child: Obx(
        () => AnimatedOpacity(
          opacity: controller.navbarOpacity.value,
          duration: const Duration(milliseconds: 500),
          child: GestureDetector(
            onTap: () {
              // controller.resetOpacityTimer();
            },
            onPanUpdate: (details) {
              // controller.resetOpacityTimer();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.sp),
              decoration: BoxDecoration(
                color: AppColors.primary
                    .withOpacity(controller.navbarOpacity.value),
                borderRadius: BorderRadius.circular(radiusFull),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.gray3.withOpacity(.1), blurRadius: 2),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(
                      icon: Icons.home,
                      title: AppContents.home,
                      index: 0,
                      controller: controller),
                  _buildIconButton(
                      icon: Icons.menu_book,
                      title: AppContents.comic,
                      index: 1,
                      controller: controller),
                  _buildIconButton(
                      icon: Icons.book,
                      title: AppContents.bookCase,
                      index: 2,
                      controller: controller),
                  _buildIconButton(
                      icon: Icons.person,
                      title: AppContents.account,
                      index: 3,
                      controller: controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String title,
    required int index,
    required MainController controller,
  }) {
    bool isActive = controller.currentIndex.value == index;
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: isActive ? AppColors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(RadiusDimens.radiusFull),
      ),
      child: InkWell(
        onTap: () {
          controller.onChangeItemBottomBar(index);
          // controller.resetOpacityTimer();
        },
        child: Column(
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: isActive ? AppColors.primary : AppColors.white,
            ),
            SizedBox(
              height: 4.sp,
            ),
            TextWidget(
              text: title,
              size: 12.sp,
              color: isActive ? AppColors.primary : AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
