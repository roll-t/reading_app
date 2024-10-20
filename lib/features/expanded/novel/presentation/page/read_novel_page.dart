import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balloon_slider/flutter_balloon_slider.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/const/app_constants.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_large_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_bold.dart';
import 'package:reading_app/core/ui/widgets/modal/custom_bottom_sheet.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/features/expanded/novel/presentation/controller/read_novel_cotroller.dart';

class ReadNovelPage extends GetView<ReadNovelCotroller> {
  const ReadNovelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReadNovelCotroller>(
        id: "ControlThemeId",
        builder: (_) {
          return Scaffold(
            backgroundColor: controller.currentReadTheme?["backgroundColor"] ??
                AppColors.primaryDarkBg,
            drawer: _SideBar(),
            body: _BuildBodyChapter(context),
          );
        });
  }

  // ignore: non_constant_identifier_names
  Stack _BuildBodyChapter(BuildContext context) {
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
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: GetBuilder<ReadNovelCotroller>(
                id: "mainContentChapter",
                builder: (_) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 15),
                        child: TextLargeBold(
                          textChild: controller.chapterNovelModel.chapterName,
                          colorChild:
                              controller.currentReadTheme?["textColor"] ??
                                  AppColors.white,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextWidget(
                          text: controller.chapterNovelModel.chapterContent,
                          color: controller.currentReadTheme?["textColor"] ??
                              AppColors.white,
                          fontFamily: controller.fontReadTheme,
                          size: controller.textSizeReadTheme,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        _BuildLeadingIcon(),
        _BuildTagControlChapter(context), // Control buttons
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Container _BuildItemThemeRead(
      {required Color textColor,
      required Color backgroundColor,
      required String title,
      bool selected = false}) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(RadiusDimens.radiusSmall2),
          border: Border.all(
              color:
                  selected ? AppColors.accentColor : AppColors.secondaryDarkBg,
              width: selected ? 3 : 0)),
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
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    border: Border.all(
                        color: AppColors.white.withOpacity(.4), width: .6),
                    color: AppColors.gray2.withOpacity(.2)),
                child: IconButton(
                    onPressed: (){
                      print(controller.readingBookReturn.toJson());
                      Get.back(result: controller.readingBookReturn);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: IconsDimens.iconsSize18,
                    )),
              ),
            )));
  }

  // ignore: non_constant_identifier_names
  DropdownSearch<(IconData, String)> _BuildDropDown() {
    return DropdownSearch<(IconData, String)>(
      selectedItem: (Icons.circle, controller.fontReadTheme),
      compareFn: (item1, item2) => item1.$1 == item2.$2,
      items: (f, cs) =>
          controller.fonts.map((value) => (Icons.circle, value)).toList(),
      onChanged: (value) {
        if (value != null) {
          controller.changeFontReadTheme(font: value.$2);
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
    Timer? debounce;
    return CustomBottomSheetWidget(
      paddingContent: const EdgeInsets.all(SpaceDimens.space20),
      heightSheet: Get.height * .62,
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
              BalloonSlider(
                  // ignore: unnecessary_null_comparison
                  value: controller.textSizeReadTheme != null
                      ? ((controller.textSizeReadTheme) / 100)
                      : 0.16,
                  ropeLength: 55,
                  showRope: true,
                  onChangeStart: (val) {},
                  onChanged: (val) {
                    // Hủy debounce trước nếu đang hoạt động
                    if (debounce?.isActive ?? false) {
                      debounce?.cancel();
                    }
                    // Thực hiện debounce với khoảng trễ 300ms
                    debounce = Timer(const Duration(milliseconds: 300), () {
                      controller.changeTextSizeReadTheme(size: val * 100);
                    });
                  },
                  onChangeEnd: (val) {},
                  color: AppColors.accentColor)
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
              _BuildDropDown(),
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
              const TextMediumBold(textChild: "Chủ đề"),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<ReadNovelCotroller>(
                  id: "ListThemeReadID",
                  builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i = 0;
                            i < AppConstants.readThemeIds.length;
                            i++)
                          InkWell(
                            onTap: () {
                              controller.changeReadTheme(
                                  readTheme: AppConstants.readThemeIds[i]);
                            },
                            child: _BuildItemThemeRead(
                                selected: controller.currentReadTheme!["id"] ==
                                    AppConstants.readThemeIds[i]["id"],
                                title: AppConstants.readThemeIds[i]["name"],
                                backgroundColor: AppConstants.readThemeIds[i]
                                    ["backgroundColor"],
                                textColor: AppConstants.readThemeIds[i]
                                    ["textColor"]),
                          ),
                      ],
                    );
                  })
            ],
          ),
        ),
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
