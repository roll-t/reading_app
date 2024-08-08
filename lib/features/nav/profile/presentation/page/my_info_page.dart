import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/images/image_widget.dart';
import 'package:reading_app/features/nav/profile/presentation/controller/my_info_controller.dart';

class MyInfoPage extends GetView<MyInfoController> {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: TextMedium(
          textChild: TextFormat.capitalizeEachWord(AppContents.myInfo),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: SpaceDimens.spaceStandard),
        child: Column(
          children: [
            _BuildItemSetting(
                title: "Ảnh đại diện",
                info:
                    "https://th.bing.com/th/id/R.7c0985982d01910e15155653b42383fe?rik=ztlbiol8pb1R1w&pid=ImgRaw&r=0"),
            _BuildItemSetting(title: "Tên", info: "Phuoc Truong"),
            _BuildItemSetting(title: "Email", info: "phuoc.truong@example.com"),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildItemSetting({
    required String title,
    required String info,
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
                FutureBuilder<bool>(
                  future: controller.isImageUrl(info),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Hiển thị vòng tròn tải khi dữ liệu đang được tải
                      return const SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      // Xử lý lỗi nếu có
                      return const TextSmall(
                        textChild: 'Lỗi',
                        colorChild: AppColors.gray2,
                      );
                    } else if (snapshot.hasData && snapshot.data!) {
                      // Nếu URL là hình ảnh, hiển thị ảnh
                      return SizedBox(
                        width: 40,
                        height: 40,
                        child: ClipOval(
                          child: ImageWidget(
                            imageUrl: info,
                          ),
                        ),
                      );
                    } else {
                      // Nếu không phải là hình ảnh, hiển thị văn bản
                      return TextSmall(
                        textChild: info,
                        colorChild: AppColors.gray2,
                      );
                    }
                  },
                ),
                const SizedBox(width: SpaceDimens.space10),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.gray2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


}
