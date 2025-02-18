import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/card/card_row_widget.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_small.dart';
import 'package:reading_app/core/ui/widgets/textfield/custom_search_field.dart';
import 'package:reading_app/features/content/searches/presentation/controller/search_comic_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchComicPage extends GetView<SearchComicController> {
  const SearchComicPage({super.key});

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
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
        child: Obx(() {
          final listComics = controller.listComicSearch?.value?.items ?? [];
          final isLoading = controller.isLoading.value;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: SpaceDimens.space20),
                  child: TextSmall(
                    textChild:
                        controller.listComicSearch.value?.titlePage ?? "",
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
              if (isLoading)
                const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (listComics.isEmpty)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: TextMediumSemiBold(
                          textChild: "Không tìm thấy truyện nào."),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final isLastItem = index == listComics.length - 1;

                      return CardRowWidget(
                        heightImage: 15.h,
                        bookModel: listComics[index],
                        currentIndex: index,
                        last: isLastItem,
                      );
                    },
                    childCount: listComics.length,
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
