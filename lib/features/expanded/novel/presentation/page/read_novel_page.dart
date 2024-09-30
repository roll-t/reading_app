import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_bold.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/features/expanded/novel/presentation/controller/read_novel_cotroller.dart';

class ReadNovelPage extends GetView<ReadNovelCotroller> {
  const ReadNovelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextLargeBold(textChild: "Danh sách chương"),
            ),
            for (var i = 0; i < controller.listChapter.length; i++)
              InkWell(
                onTap: () {},
                child: Container(
                    decoration: BoxDecoration(
                      color: controller.chapterNovelModel.chapterId ==
                              controller.listChapter[i].chapterId
                          ? AppColors.accentColor
                          : null,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextWidget(
                        maxLines: 2,
                        text:
                            "${controller.listChapter[i].chapterName}: ${controller.listChapter[i].chapterTitle}")),
              ),
          ],
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTapUp: (TapUpDetails details) {
              if (details.localPosition.dy < Get.height / 2) {
                controller.scrollUp();
              } else {
                controller.scrollDown();
              }
            },
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
                    child: TextLargeBold(
                      textChild: controller.chapterNovelModel.chapterName,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextWidget(
                      text: controller.chapterNovelModel.chapterContent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(top: 30, left: 16, child: leadingIconAppBar()),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width * .6,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.white.withOpacity(.7),
                    ),
                    borderRadius:
                        BorderRadius.circular(RadiusDimens.radiusSmall2),
                    color: AppColors.gray3.withOpacity(.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      // Sử dụng Builder để có được ngữ cảnh chính xác
                      Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Icon(Icons.list),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.comment),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
