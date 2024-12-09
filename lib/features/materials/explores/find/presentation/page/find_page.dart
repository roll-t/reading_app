import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/card/card_full_info_follow_row.dart';
import 'package:reading_app/core/ui/widgets/textfield/custom_search_field.dart';
import 'package:reading_app/features/materials/explores/find/presentation/controller/find_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FindPage extends GetView<FindController> {
  const FindPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        backgroundColor: AppColors.black,
        title: CustomSearchField(
          onChanged: (value) async {
            controller.handleSearch(searchContent: value);
          },
          placeholder: "Tên truyện tranh ....",
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(
            left: 3.w,
            right: 3.w,
            top: 3.w,
          ),
          child: Obx(() {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: SpaceDimens.space20),
                    child: TextSmall(
                      textChild: controller.listComicSearch.value.titlePage,
                      colorChild: AppColors.gray2,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: SpaceDimens.space20),
                    child: TextMediumSemiBold(textChild: "Truyện"),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >=
                          controller.listComicSearch.value.items.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CardFullInfoFollowRow(
                        heightImage: 15.h,
                        bookModel:
                            controller.listComicSearch.value.items[index],
                        currentIndex: index,
                        last: index ==
                            controller.listComicSearch.value.items.length - 1,
                        domain: controller.listComicSearch.value.domainImage,
                      );
                    },
                    childCount: controller.isLoading.value
                        ? controller.listComicSearch.value.items.length + 1
                        : controller.listComicSearch.value.items.length,
                  ),
                ),
              ],
            );
          })),
    );
  }
}
