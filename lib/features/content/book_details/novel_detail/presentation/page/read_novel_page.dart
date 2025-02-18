import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/configs/const/app_constants.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/services/api/data/entities/models/chapter_novel_model.dart';
import 'package:reading_app/core/ui/dialogs/custom_bottom_sheet.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_large_bold.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_medium_bold.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/features/content/book_details/novel_detail/presentation/controller/read_novel_cotroller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReadNovelPage extends GetView<ReadNovelController> {
  const ReadNovelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideBar(),
      body: Stack(
        children: [
          _buildBody(context),
          ..._buildOverlayLayer(context),
        ],
      ),
    );
  }

  Drawer _buildSideBar() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextLargeBold(textChild: AppContents.listChapter),
          ),
          ...controller.listChapter.asMap().entries.map((entry) {
            var value = entry.value;
            return InkWell(
              onTap: () {
                controller.changeChapter(value, entry.key);
              },
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: controller.chaptersDisplay.value.chapterId ==
                            value.chapterId
                        ? AppColors.accentColor
                        : null,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextWidget(
                    maxLines: 2,
                    text: "${value.chapterName}: ${value.chapterTitle}",
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() {
      final theme = controller.readThemeColorModel.value;
      final textSize = controller.textSizeReadTheme.value;
      final fontFamily = controller.fontReadTheme.value;

      return Container(
        color: theme.backgroundColor,
        padding: const EdgeInsets.only(left: 5, right: 5, top: 30),
        constraints: BoxConstraints(minWidth: 100.w, minHeight: 100.h),
        child: GestureDetector(
          onLongPress: controller.toggleOverlayLayerVisibility,
          onTapUp: (details) => controller.tapToAutoScroll(details, context),
          child: Scrollbar(
            controller: controller.scrollController,
            thickness: 1,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  controller: controller.scrollController,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildChapterItem(
                          controller.chaptersDisplay,
                          theme.textColor,
                          textSize,
                          fontFamily,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }

  Widget buildChapterItem(
    Rx<ChapterNovelModel> chapter,
    Color textColor,
    double textSize,
    String fontFamily,
  ) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 40),
            child: TextWidget(
              color: textColor,
              fontFamily: fontFamily,
              text:
                  "${chapter.value.chapterName}: ${chapter.value.chapterTitle}",
              fontWeight: FontWeight.w500,
              size: 20.sp,
            ),
          ),
          TextWidget(
            color: textColor,
            text: chapter.value.chapterContent,
            size: textSize,
            fontFamily: fontFamily,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 40),
            child: Image.asset(
              AppImages.iAdvertise,
              width: 100.w,
              fit: BoxFit.contain,
            ),
          ),
          if (controller.isLastChapter)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.isWaiting,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextWidget(
                    text: "Đây là chapter mới nhất",
                    size: 20.sp,
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
            )
        ],
      ),
    );
  }

  List<Positioned> _buildOverlayLayer(BuildContext context) {
    return <Positioned>[
      _buildLeadingIcon(),
      _buildControllerTag(context),
      _buildLoadingChapterProgress()
    ];
  }

  Positioned _buildLoadingChapterProgress() {
    return Positioned(
      child: Obx(
        () => controller.isLoadingChapter.value
            ? Container(
                width: 100.w,
                height: 100.h,
                color: AppColors.black.withOpacity(.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Positioned _buildControllerTag(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Obx(() {
        return AnimatedSlide(
          curve: Curves.bounceInOut,
          duration: const Duration(milliseconds: 200),
          offset: !controller.isOverlayLayerVisible.value
              ? const Offset(0, 0)
              : const Offset(0, 1.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70.w,
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
                          text: controller.chaptersDisplay.value.chapterName),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: controller.loadPreviousChapter,
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        Builder(builder: (context) {
                          return IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Icon(Icons.list),
                          );
                        }),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.comment),
                        ),
                        IconButton(
                          onPressed: () {
                            _buildBottomSheet(context).show(context);
                          },
                          icon: const Icon(Icons.settings),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                          onPressed: controller.loadNextChapter,
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

  CustomBottomSheetWidget _buildBottomSheet(BuildContext context) {
    return CustomBottomSheetWidget(
      paddingContent: const EdgeInsets.all(SpaceDimens.space20),
      heightSheet: 65.h,
      context,
      viewItems: [
        const Row(
          children: [
            Icon(Icons.settings),
            SizedBox(
              width: 10,
            ),
            TextLargeBold(
              textChild: "Tùy chỉnh",
            )
          ],
        ),
        const SizedBox(
          height: SpaceDimens.space10,
        ),
        Container(
          width: Get.width,
          padding: const EdgeInsets.all(SpaceDimens.spaceStandard),
          decoration: BoxDecoration(
            color: AppColors.tertiaryDarkBg,
            borderRadius: BorderRadius.circular(RadiusDimens.radiusSmall2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextMediumBold(textChild: "Cỡ chữ"),
              Obx(
                () => Slider(
                  activeColor: AppColors.accentColor,
                  value: controller.textSizeReadTheme.value,
                  min: 16,
                  max: 40.0,
                  divisions: 24,
                  label: "${controller.textSizeReadTheme.value} px",
                  onChanged: (value) {
                    controller.changeSizeText(value);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: Get.width,
          padding: const EdgeInsets.all(SpaceDimens.spaceStandard),
          decoration: BoxDecoration(
            color: AppColors.tertiaryDarkBg,
            borderRadius: BorderRadius.circular(RadiusDimens.radiusSmall2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextMediumBold(textChild: "Font chữ"),
              const SizedBox(
                height: 10,
              ),
              _buildDropDown(),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: 100.w,
          padding: const EdgeInsets.all(SpaceDimens.spaceStandard),
          decoration: BoxDecoration(
            color: AppColors.tertiaryDarkBg,
            borderRadius: BorderRadius.circular(RadiusDimens.radiusSmall2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextMediumBold(textChild: "Chủ đề"),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: AppConstants.listReadTheme
                      .map(
                        (value) => InkWell(
                          onTap: () {
                            controller.changeReadTheme(value);
                          },
                          child: _buildItemThemeRead(
                              selected: value.id ==
                                  controller.readThemeColorModel.value.id,
                              title: value.name,
                              backgroundColor: value.backgroundColor,
                              textColor: value.textColor),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Container _buildItemThemeRead({
    required Color textColor,
    required Color backgroundColor,
    required String title,
    bool selected = false,
  }) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(RadiusDimens.radiusSmall2),
        border: Border.all(
            color: selected ? AppColors.accentColor : AppColors.secondaryDarkBg,
            width: selected ? 3 : 0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextWidget(
            text: "aA",
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          TextWidget(
            text: title,
            size: 12,
            color: textColor,
          ),
        ],
      ),
    );
  }

  DropdownSearch<(IconData, String)> _buildDropDown() {
    return DropdownSearch<(IconData, String)>(
      selectedItem: (Icons.circle, controller.fontReadTheme.value),
      // ignore: unrelated_type_equality_checks
      compareFn: (item1, item2) => item1.$1 == item2.$2,
      items: (f, cs) =>
          AppConstants.listFont.map((value) => (Icons.circle, value)).toList(),
      onChanged: (value) {
        if (value != null) {
          controller.changeFontText(value.$2);
        }
      },
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          filled: true,
          fillColor: AppColors.secondaryDarkBg,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      dropdownBuilder: (context, selectedItem) {
        return ListTile(
          leading: Icon(selectedItem!.$1, color: Colors.white),
          title: Text(
            selectedItem.$2,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      },
      popupProps: PopupProps.menu(
        itemBuilder: (context, item, isDisabled, isSelected) {
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
            leading: Icon(item.$1, color: Colors.white),
            title: Text(
              item.$2,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          );
        },
        fit: FlexFit.loose,
        menuProps: const MenuProps(
          backgroundColor: Colors.transparent,
          elevation: 0,
          margin: EdgeInsets.only(top: 5),
        ),
        containerBuilder: (ctx, popupWidget) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryDarkBg,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: popupWidget,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Positioned _buildLeadingIcon() {
    return Positioned(
      left: 5.w,
      top: 10.w,
      child: Obx(
        () => AnimatedSlide(
          offset: !controller.isOverlayLayerVisible.value
              ? const Offset(0, 0)
              : const Offset(-1.8, 0),
          curve: Curves.bounceInOut,
          duration: const Duration(milliseconds: 200),
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
                Get.back(result: controller.readingBookReturn);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: IconsDimens.iconsSize18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}









// import 'dart:async';

// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_balloon_slider/flutter_balloon_slider.dart';
// import 'package:get/get.dart';
// import 'package:reading_app/core/configs/const/app_constants.dart';
// import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
// import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
// import 'package:reading_app/core/configs/dimens/space_dimens.dart';
// import 'package:reading_app/core/configs/themes/app_colors.dart';
// import 'package:reading_app/core/ui/dialogs/custom_bottom_sheet.dart';
// import 'package:reading_app/core/ui/widgets/text/customs/text_large_bold.dart';
// import 'package:reading_app/core/ui/widgets/text/customs/text_medium_bold.dart';
// import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
// import 'package:reading_app/features/content/book_details/novels/presentation/controller/read_novel_cotronller.dart';
// import 'package:reading_app/features/content/book_details/novels/presentation/widgets/build_comment_bottom_sheet.dart';

// class ReadNovelPage extends GetView<ReadNovelController> {
//   const ReadNovelPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: controller.currentReadTheme?["backgroundColor"] ??
//           AppColors.primaryDarkBg,
//       drawer: Drawer(
//         child: GetBuilder<ReadNovelController>(
//           id: "listSelected",
//           builder: (_) {
//             return ListView(
//               padding: EdgeInsets.zero,
//               children: <Widget>[
//                 const SizedBox(height: 20),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   child: TextLargeBold(textChild: "Danh sách chương"),
//                 ),
//                 for (var i = 0; i < controller.listChapter.length; i++)
//                   InkWell(
//                     onTap: () {
//                       controller.changChapter(
//                           chapterId: controller.listChapter[i].chapterId);
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: controller.chapterNovelModel?.value.chapterId ==
//                                 controller.listChapter[i].chapterId
//                             ? AppColors.accentColor
//                             : null,
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 20),
//                       child: TextWidget(
//                         maxLines: 2,
//                         text:
//                             "${controller.listChapter[i].chapterName}: ${controller.listChapter[i].chapterTitle}",
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//       body: PopScope(
//         canPop: false,
//         onPopInvokedWithResult: (didPop, result) {
//           if (didPop) return;
//           Get.back(result: controller.readingBookReturn);
//         },
//         child: Stack(
//           children: [
//             GestureDetector(
//               onTapUp: (TapUpDetails details) {
//                 controller.isControlsVisible.value = false;
//                 if (details.localPosition.dy < Get.height / 2) {
//                   controller.scrollUp();
//                 } else {
//                   controller.scrollDown();
//                 }
//               },
//               onLongPress: () {
//                 controller.toggleControlVisibility();
//               },
//               child: Scrollbar(
//                 thickness: 2,
//                 child: SingleChildScrollView(
//                   controller: controller.scrollController,
//                   child: GetBuilder<ReadNovelController>(
//                     id: "mainContentChapter",
//                     builder: (_) {
//                       return Column(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.only(top: 20, bottom: 15),
//                             child: TextLargeBold(
//                               textChild: controller
//                                       .chapterNovelModel?.value.chapterName ??
//                                   "",
//                               colorChild:
//                                   controller.currentReadTheme?["textColor"] ??
//                                       AppColors.white,
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: TextWidget(
//                               text: controller.chapterNovelModel?.value
//                                       .chapterContent ??
//                                   "",
//                               color:
//                                   controller.currentReadTheme?["textColor"] ??
//                                       AppColors.white,
//                               fontFamily: controller.fontReadTheme,
//                               size: controller.textSizeReadTheme,
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 30,
//               left: 16,
//               child: Obx(
//                 () => AnimatedSlide(
//                   offset: controller.isControlsVisible.value
//                       ? const Offset(0, 0)
//                       : const Offset(-1.5, 0),
//                   curve: Curves.bounceInOut,
//                   duration: const Duration(milliseconds: 200),
//                   child: Container(
//                     width: 35,
//                     height: 35,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(1000),
//                         border: Border.all(
//                             color: AppColors.white.withOpacity(.4), width: .6),
//                         color: AppColors.gray2.withOpacity(.2)),
//                     child: IconButton(
//                       onPressed: () {
//                         Get.back(result: controller.readingBookReturn);
//                       },
//                       icon: Icon(
//                         Icons.arrow_back_ios_new_rounded,
//                         size: IconsDimens.iconsSize18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 20,
//               left: 0,
//               right: 0,
//               child: Obx(() {
//                 return AnimatedSlide(
//                   curve: Curves.bounceInOut,
//                   duration: const Duration(milliseconds: 200),
//                   offset: controller.isControlsVisible.value
//                       ? const Offset(0, 0)
//                       : const Offset(0, 1.5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: Get.width * .7,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             width: 1,
//                             color: AppColors.white.withOpacity(.4),
//                           ),
//                           borderRadius:
//                               BorderRadius.circular(RadiusDimens.radiusSmall2),
//                           color: AppColors.gray3.withOpacity(.9),
//                         ),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 20),
//                               child: TextWidget(
//                                 text: controller.chapterNovelModel?.value
//                                         .chapterTitle ??
//                                     "",
//                                 maxLines: 1,
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 IconButton(
//                                   onPressed: () {
//                                     controller.clickControl();
//                                     controller.preChapter(
//                                         chapterId: controller.chapterNovelModel
//                                             ?.value.chapterId);
//                                   },
//                                   icon: const Icon(
//                                       Icons.arrow_back_ios_new_rounded),
//                                 ),
//                                 Builder(
//                                   builder: (BuildContext context) {
//                                     return IconButton(
//                                       onPressed: () {
//                                         controller.clickControl();
//                                         Scaffold.of(context).openDrawer();
//                                       },
//                                       icon: const Icon(Icons.list),
//                                     );
//                                   },
//                                 ),
//                                 IconButton(
//                                   onPressed: () async {
//                                     controller.clickControl();
//                                     if (controller
//                                         // ignore: invalid_use_of_protected_member
//                                         .listComment
//                                         .value
//                                         .isEmpty) {
//                                       await controller.fetchListComment();
//                                     }
//                                     BuildCommentBottomSheet.show(
//                                         // ignore: use_build_context_synchronously
//                                         context,
//                                         controller.listComment);
//                                   },
//                                   icon: const Icon(Icons.comment),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     controller.clickControl();
//                                     _buildBottomSheet(context).show(context);
//                                   },
//                                   icon: const Icon(Icons.settings),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     controller.clickControl();
//                                     controller.nextChapter(
//                                         chapterId: controller.chapterNovelModel
//                                             ?.value.chapterId);
//                                   },
//                                   icon: const Icon(
//                                       Icons.arrow_forward_ios_rounded),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Container _buildItemThemeRead(
//       {required Color textColor,
//       required Color backgroundColor,
//       required String title,
//       bool selected = false}) {
//     return Container(
//       width: 70,
//       height: 70,
//       decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(RadiusDimens.radiusSmall2),
//           border: Border.all(
//               color:
//                   selected ? AppColors.accentColor : AppColors.secondaryDarkBg,
//               width: selected ? 3 : 0)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           TextWidget(
//             text: "aA",
//             fontWeight: FontWeight.w500,
//             color: textColor,
//           ),
//           TextWidget(
//             text: title,
//             size: 12,
//             color: textColor,
//           ),
//         ],
//       ),
//     );
//   }

//   DropdownSearch<(IconData, String)> _buildDropDown() {
//     return DropdownSearch<(IconData, String)>(
//       selectedItem: (Icons.circle, controller.fontReadTheme),
//       // ignore: unrelated_type_equality_checks
//       compareFn: (item1, item2) => item1.$1 == item2.$2,
//       items: (f, cs) =>
//           controller.fonts.map((value) => (Icons.circle, value)).toList(),
//       onChanged: (value) {
//         if (value != null) {
//           controller.changeFontReadTheme(font: value.$2);
//         }
//       },
//       decoratorProps: DropDownDecoratorProps(
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.symmetric(vertical: 0),
//           filled: true,
//           fillColor: AppColors.secondaryDarkBg,
//           border: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.transparent),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.transparent),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.transparent),
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//       ),
//       dropdownBuilder: (context, selectedItem) {
//         return ListTile(
//           leading: Icon(selectedItem!.$1, color: Colors.white),
//           title: Text(
//             selectedItem.$2,
//             style: const TextStyle(
//                 color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         );
//       },
//       popupProps: PopupProps.menu(
//         itemBuilder: (context, item, isDisabled, isSelected) {
//           return ListTile(
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
//             leading: Icon(item.$1, color: Colors.white),
//             title: Text(
//               item.$2,
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold),
//             ),
//           );
//         },
//         fit: FlexFit.loose,
//         menuProps: const MenuProps(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           margin: EdgeInsets.only(top: 5),
//         ),
//         containerBuilder: (ctx, popupWidget) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Flexible(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: AppColors.secondaryDarkBg,
//                     shape: BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: popupWidget,
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   CustomBottomSheetWidget _buildBottomSheet(BuildContext context) {
//     Timer? debounce;
//     return CustomBottomSheetWidget(
//       paddingContent: const EdgeInsets.all(SpaceDimens.space20),
//       heightSheet: Get.height * .62,
//       context,
//       viewItems: [
//         const Row(
//           children: [
//             Icon(Icons.settings),
//             SizedBox(
//               width: 10,
//             ),
//             TextLargeBold(
//               textChild: "Tùy chỉnh",
//             )
//           ],
//         ),
//         const SizedBox(
//           height: SpaceDimens.space10,
//         ),
//         Container(
//           width: Get.width,
//           padding: const EdgeInsets.all(SpaceDimens.spaceStandard),
//           decoration: BoxDecoration(
//             color: AppColors.tertiaryDarkBg,
//             borderRadius: BorderRadius.circular(RadiusDimens.radiusSmall2),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const TextMediumBold(textChild: "Cỡ chữ"),
//               BalloonSlider(
//                   // ignore: unnecessary_null_comparison
//                   value: controller.textSizeReadTheme != null
//                       ? ((controller.textSizeReadTheme) / 100)
//                       : 0.16,
//                   ropeLength: 55,
//                   showRope: true,
//                   onChangeStart: (val) {},
//                   onChanged: (val) {
//                     // Hủy debounce trước nếu đang hoạt động
//                     if (debounce?.isActive ?? false) {
//                       debounce?.cancel();
//                     }
//                     // Thực hiện debounce với khoảng trễ 300ms
//                     debounce = Timer(const Duration(milliseconds: 300), () {
//                       controller.changeTextSizeReadTheme(size: val * 100);
//                     });
//                   },
//                   onChangeEnd: (val) {},
//                   color: AppColors.accentColor)
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Container(
//           width: Get.width,
//           padding: const EdgeInsets.all(SpaceDimens.spaceStandard),
//           decoration: BoxDecoration(
//             color: AppColors.tertiaryDarkBg,
//             borderRadius: BorderRadius.circular(RadiusDimens.radiusSmall2),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const TextMediumBold(textChild: "Font chữ"),
//               const SizedBox(
//                 height: 10,
//               ),
//               _buildDropDown(),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Container(
//           width: Get.width,
//           padding: const EdgeInsets.all(SpaceDimens.spaceStandard),
//           decoration: BoxDecoration(
//             color: AppColors.tertiaryDarkBg,
//             borderRadius: BorderRadius.circular(RadiusDimens.radiusSmall2),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const TextMediumBold(textChild: "Chủ đề"),
//               const SizedBox(
//                 height: 10,
//               ),
//               GetBuilder<ReadNovelCotroller>(
//                   id: "ListThemeReadID",
//                   builder: (_) {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         for (var i = 0;
//                             i < AppConstants.readThemeIds.length;
//                             i++)
//                           InkWell(
//                             onTap: () {
//                               controller.changeReadTheme(
//                                   readTheme: AppConstants.readThemeIds[i]);
//                             },
//                             child: _buildItemThemeRead(
//                                 selected: controller.currentReadTheme!["id"] ==
//                                     AppConstants.readThemeIds[i]["id"],
//                                 title: AppConstants.readThemeIds[i]["name"],
//                                 backgroundColor: AppConstants.readThemeIds[i]
//                                     ["backgroundColor"],
//                                 textColor: AppConstants.readThemeIds[i]
//                                     ["textColor"]),
//                           ),
//                       ],
//                     );
//                   })
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
