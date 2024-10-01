import 'package:flutter/material.dart';
import 'package:flutter_balloon_slider/flutter_balloon_slider.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_bold.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/core/ui/widgets/modal/custom_bottom_sheet.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/features/expanded/novel/presentation/controller/read_novel_cotroller.dart';

class ReadNovelPage extends GetView<ReadNovelCotroller> {
  const ReadNovelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _SideBar(),
      body: _BuildBodyChapter(context),
    );
  }

  // ignore: non_constant_identifier_names
  Stack _BuildBodyChapter(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTapUp: (TapUpDetails details) {
            if (details.localPosition.dy < Get.height / 2) {
              controller.scrollUp();
            } else {
              controller.scrollDown();
            }
          },
          onLongPress: () {
            controller.toggleControlVisibility(); // Toggle visibility
          },
          child: SingleChildScrollView(
            controller: controller.scrollController,
            child: GetBuilder<ReadNovelCotroller>(
              id: "mainContentChapter",
              builder: (_) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: Get.height * .7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.settings),
                              SizedBox(
                                width: 10,
                              ),
                              TextLargeBold(textChild: "Tùy chỉnh",)
                            ],
                          ),
                          const SizedBox(
                            height: SpaceDimens.space10,
                          ),
                          Container(
                            width: Get.width,
                            padding:
                                const EdgeInsets.all(SpaceDimens.spaceStandard),
                            decoration: BoxDecoration(
                              color: AppColors.tertiaryDarkBg,
                              borderRadius: BorderRadius.circular(
                                  RadiusDimens.radiusSmall2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextMediumBold(textChild: "Cỡ chữ"),
                                BalloonSlider(
                                    value: 0.16,
                                    ropeLength: 55,
                                    showRope: true,
                                    onChangeStart: (val) {
                                      val = 10;
                                    },
                                    onChanged: (val) {},
                                    onChangeEnd: (val) {
                                      val = 20;
                                    },
                                    color: AppColors.accentColor)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
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
                );
              },
            ),
          ),
        ),
        Positioned(
            top: 30,
            left: 16,
            child: Obx(() => AnimatedSlide(
                  offset: controller.isControlsVisible.value
                      ? const Offset(0, 0)
                      : const Offset(-1.5, 0),
                  curve: Curves.bounceInOut,
                  duration: const Duration(milliseconds: 200),
                  child: const leadingIconAppBar(),
                ))),
        _BuildTagControlChapter(context), // Control buttons
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Positioned _BuildTagControlChapter(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Obx(() {
        return AnimatedSlide(
          curve: Curves.bounceInOut,
          duration: const Duration(milliseconds: 200),
          offset: controller.isControlsVisible.value
              ? const Offset(0, 0)
              : const Offset(0, 1.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * .7,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: AppColors.white.withOpacity(.4),
                  ),
                  borderRadius:
                      BorderRadius.circular(RadiusDimens.radiusSmall2),
                  color: AppColors.gray3.withOpacity(.9),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextWidget(
                        text: controller.chapterNovelModel.chapterTitle,
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.clickControl();
                            controller.preChapter(
                                chapterId:
                                    controller.chapterNovelModel.chapterId);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        Builder(
                          builder: (BuildContext context) {
                            return IconButton(
                              onPressed: () {
                                controller.clickControl();
                                Scaffold.of(context).openDrawer();
                              },
                              icon: const Icon(Icons.list),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            controller.clickControl();
                          }, // Placeholder for comments
                          icon: const Icon(Icons.comment),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.clickControl();
                            _BuildButtomSheet(context).show(context);
                          }, // Placeholder for comments
                          icon: const Icon(Icons.settings),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.clickControl();
                            controller.nextChapter(
                                chapterId:
                                    controller.chapterNovelModel.chapterId);
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ignore: non_constant_identifier_names
  CustomBottomSheetWidget _BuildButtomSheet(BuildContext context) {
    return CustomBottomSheetWidget(
      paddingContent: const EdgeInsets.all(SpaceDimens.space20),
      heightSheet: Get.height * .7,
      context,
      viewItems: const [
        Row(
          children: [
            Icon(Icons.settings),
            SizedBox(
              width: 10,
            ),
            TextLargeBold(textChild: "Tùy chỉnh")
          ],
        )
      ],
    );
  }

  // Build the sidebar
  // ignore: non_constant_identifier_names
  Drawer _SideBar() {
    return Drawer(
      child: GetBuilder<ReadNovelCotroller>(
        id: "listSelected",
        builder: (_) {
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextLargeBold(textChild: "Danh sách chương"),
              ),
              for (var i = 0; i < controller.listChapter.length; i++)
                InkWell(
                  onTap: () {
                    controller.changChapter(
                        chapterId: controller.listChapter[i].chapterId);
                  },
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
                          "${controller.listChapter[i].chapterName}: ${controller.listChapter[i].chapterTitle}",
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
