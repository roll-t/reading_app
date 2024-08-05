import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/card/card_full_info_follow_row.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/features/category/presentation/controller/category_controller.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.headerBackground,
            floating: true,
            snap: true,
            title: TextMediumSemiBold(
              textChild: capitalizeEachWord((controller.title.value).isEmpty?"untitle":controller.title.value),
            ),
            centerTitle: true,
            expandedHeight: 60.0,
            leading: const leadingIconAppBar(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: SpaceDimens.space25,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: SpaceDimens.spaceStandard),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // Ensure the index is within bounds
                  if (index >= controller.listValueCardContinue.length) {
                    return const SizedBox.shrink();
                  }
                  return CardFullInfoFollowRow(
                    heightImage: 120,
                    bookModel: controller.listValueCardContinue[index],
                    currentIndex: 0,
                    last: true,
                  );
                },
                childCount: controller.listValueCardContinue.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String capitalizeEachWord(String text) {
    if (text.isEmpty) {
      return text;
    }

    return text.split(' ').map((word) {
      // Kiểm tra nếu từ đã viết hoa hoàn toàn
      if (word == word.toUpperCase()) {
        return word; // Giữ nguyên từ nếu đã viết hoa hoàn toàn
      }

      // Viết hoa chữ cái đầu tiên và chuyển các chữ còn lại thành chữ thường
      return word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : word;
    }).join(' ');
  }

  String capitalizeFirstLetter(String text) {
    if (text == null || text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }
}
