import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small_light.dart';
import 'package:reading_app/core/ui/widgets/avatar/avatar.dart';
import 'package:reading_app/features/nav/profile/presentation/controller/my_info_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyInfoPage extends GetView<MyInfoController> {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(result: controller.isUpdated),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: TextMedium(
          textChild: TextFormat.capitalizeEachWord(AppContents.myInfo),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<MyInfoController>(
        id: "bodyId",
        builder: (_)=>
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SpaceDimens.spaceStandard),
              child: Column(
                children: [
                  Obx(() {
                    return _BuildItemSetting(
                      title: "Ảnh đại diện",
                      isAvatar: true,
                      info: controller.userModel.value.photoURL ??
                          AppImages.iAvatarDefault,
                      event: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(
                                  child: TextLargeSemiBold(
                                      textChild: "Chọn ảnh đại diện")),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final ImagePicker _picker = ImagePicker();
                                      final XFile? pickedFile = await _picker
                                          .pickImage(source: ImageSource.gallery);
        
                                      if (pickedFile != null) {
                                        controller.uploadImage(pickedFile.path);
                                      }
        
                                      Navigator.pop(context);
                                    },
                                    child: const TextNormal(
                                      textChild: "Chọn ảnh từ thư viện",
                                      colorChild: AppColors.accentColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final ImagePicker _picker = ImagePicker();
                                      final XFile? pickedFile = await _picker
                                          .pickImage(source: ImageSource.camera);
        
                                      if (pickedFile != null) {
                                        controller.uploadImage(pickedFile.path);
                                      }
        
                                      Navigator.pop(context);
                                    },
                                    child: const TextNormal(
                                      textChild: "Chụp ảnh mới",
                                      colorChild: AppColors.accentColor,
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: const TextMedium(
                                    textChild: "Hủy",
                                    colorChild: AppColors.accentColor,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  }),
                  _BuildItemSetting(
                    title: "Tên hiển thị",
                    info: controller.userModel.value.displayName ?? "username",
                    event: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Đổi tên"),
                            content: SizedBox(
                              height: 10.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextField(
                                    controller: controller.textController,
                                    decoration: const InputDecoration(
                                      fillColor: AppColors.secondaryDarkBg,
                                    ),
                                    onChanged: controller.onDisplayNameChanged,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: .5.h, right: 1.w),
                                    child: Obx(() => TextSmallLight(
                                          textChild:
                                              "${controller.displayName.value.length}/20",
                                          colorChild: controller
                                                      .displayName.value.length >=
                                                  20
                                              ? Colors.red
                                              : Colors.grey,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: const TextNormal(
                                  textChild: "Hủy",
                                  colorChild: AppColors.gray2,
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await controller.updateDisplayName(
                                      controller.displayName.value);
                                },
                                child: const TextNormal(
                                  textChild: "Lưu",
                                  colorChild: AppColors.accentColor,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  _BuildItemSetting(
                      title: "Email",
                      info: controller.userModel.value.email,
                      isEdit: false),
                ],
              ),
            ),
            Obx(() {
              return controller.isLoading.value
                  ? Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration:
                            BoxDecoration(color: AppColors.gray3.withOpacity(.5)),
                        child: const Center(child: CircularProgressIndicator()),
                      ))
                  : const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildItemSetting({
    required String title,
    required String info,
    bool isEdit = true,
    bool isAvatar = false,
    VoidCallback? event,
  }) {
    return InkWell(
      onTap: event,
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: SpaceDimens.spaceStandard),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.gray3, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextNormal(textChild: title),
            Row(
              children: [
                isAvatar
                    ? Avatar(
                        radius: 40,
                        url: info,
                      )
                    : TextSmall(
                        textChild: info,
                        colorChild: AppColors.gray2,
                      ),
                const SizedBox(width: SpaceDimens.space10),
                isEdit
                    ? const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.gray2,
                      )
                    : const SizedBox.shrink(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
