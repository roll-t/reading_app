import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/card/card_novel_full_info.dart';
import 'package:reading_app/core/ui/widgets/textfield/custom_search_field.dart';
import 'package:reading_app/features/expanded/explores/find/presentation/controller/find_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FindNovelPage extends GetView<FindController> {
  const FindNovelPage({super.key});

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
          placeholder: "Tên tiểu thuyết ....",
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
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: const TextSmall(
                      textChild: "Từ khóa tìm kiếm: Xuyên không",
                      colorChild: AppColors.gray2,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: const TextMediumSemiBold(textChild: "Truyện"),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >=
                          // ignore: invalid_use_of_protected_member
                          controller.listNovelSearch.value.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CardNovelFullInfo(
                        heightImage: 15.h,
                        // ignore: invalid_use_of_protected_member
                        bookModel: controller.listNovelSearch.value[index],
                        currentIndex: index,
                        last: index ==
                            // ignore: invalid_use_of_protected_member
                            controller.listNovelSearch.value.length - 1,
                      );
                    },
                    childCount: controller.isLoading.value
                        // ignore: invalid_use_of_protected_member
                        ? controller.listNovelSearch.value.length + 1
                        // ignore: invalid_use_of_protected_member
                        : controller.listNovelSearch.value.length,
                  ),
                ),
              ],
            );
          })),
    );
  }
}
