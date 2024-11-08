import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/database/model/reading_book_case_model.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_bold.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/features/expanded/comic/presentation/controllers/read_comic_controller.dart';

class ReadComicPage extends GetView<ReadComicController> {
  const ReadComicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _SideBar(),
      body: Obx(
        () {
          return Stack(
            children: [
              GestureDetector(
                onTapUp: (TapUpDetails details) {
                  controller.isControlsVisible.value = false;
                  if (details.localPosition.dy < Get.height / 2) {
                    controller.scrollUp();
                  } else {
                    controller.scrollDown();
                  }
                },
                onLongPress: () {
                  controller.toggleControlVisibility();
                },
                child: Scrollbar(
                  thickness: 2,
                  child: CustomScrollView(
                    controller: controller.scrollController,
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return CachedNetworkImage(
                              imageUrl: controller.imageUrls[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(AppColors.primary),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.error, color: AppColors.error),
                                    SizedBox(height: 8),
                                    Text('Failed to load image',
                                        style:
                                            TextStyle(color: AppColors.error)),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: controller.imageUrls.length,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Obx(() {
                          if (controller.loading.value) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(AppColors.primary),
                                ),
                              ),
                            );
                          } else if (controller.imageUrls.length ==
                              controller.chapterModel?.chapterImages.length) {
                            // Kiểm tra nếu đã tới trang cuối
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: TextWidget(
                                  text: 'Chapter tiếp theo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              _BuildLeadingIcon(),
              _BuildTagControlChapter()
            ],
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Positioned _BuildLeadingIcon() {
    return Positioned(
        top: 30,
        left: 16,
        child: Obx(() => AnimatedSlide(
              offset: controller.isControlsVisible.value
                  ? const Offset(0, 0)
                  : const Offset(-1.5, 0),
              curve: Curves.bounceInOut,
              duration: const Duration(milliseconds: 200),
              child: Center(
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      border: Border.all(
                          color: AppColors.white.withOpacity(.4), width: .6),
                      color: AppColors.gray2.withOpacity(.2)),
                  child: IconButton(
                      onPressed: () {
                        Get.back(
                            result: ReadingComicBookCaseModel(
                                bookDataId: "",
                                slug: "",
                                uid: "",
                                chapterName: controller.currentChapterArguments
                                    .value["chapter_name"],
                                chapterApiData: controller
                                    .currentChapterArguments
                                    .value["chapter_api_data"],
                                readingDate: DateTime.now().toIso8601String(),
                                positionReading:
                                    controller.scrollController.position.pixels,
                                thumbUrl: "",
                                comicName: ""));
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: IconsDimens.iconsSize18,
                      )),
                ),
              ),
            )));
  }

  // ignore: non_constant_identifier_names
  Drawer _SideBar() {
    return Drawer(
      child: GetBuilder<ReadComicController>(
        id: "listSelected",
        builder: (_) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextLargeBold(textChild: "Danh sách chương"),
              ),
              for (var i = 0; i < controller.listChapterArgument.length; i++)
                InkWell(
                  onTap: () {
                    controller.changChapter(
                        chapterId: controller.listChapterArgument[i]
                            ["chapter_name"]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: controller
                                  .currentChapterArguments
                                  // ignore: invalid_use_of_protected_member
                                  .value["chapter_name"] ==
                              controller.listChapterArgument[i]["chapter_name"]
                          ? AppColors.accentColor
                          : null,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextWidget(
                      maxLines: 2,
                      text:
                          "Chương: ${controller.listChapterArgument[i]["chapter_name"]}: ${controller.listChapterArgument[i]["chapter_title"] != "" ? controller.listChapterArgument[i]["chapter_title"] : controller.listChapterArgument[i]["filename"]}",
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Positioned _BuildTagControlChapter() {
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
                        text:
                            // ignore: invalid_use_of_protected_member
                            "Chương ${controller.currentChapterArguments.value["chapter_name"]}",
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.preChapter(
                                chapterId: controller
                                    .currentChapterArguments
                                    // ignore: invalid_use_of_protected_member
                                    .value["chapter_name"]);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
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
                          onPressed: () {}, // Placeholder for comments
                          icon: const Icon(Icons.comment),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.nextChapter(
                                chapterId: controller
                                    .currentChapterArguments
                                    // ignore: invalid_use_of_protected_member
                                    .value["chapter_name"]);
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
}
