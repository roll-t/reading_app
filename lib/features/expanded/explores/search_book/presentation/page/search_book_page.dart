import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/textfield/custom_search_field.dart';
import 'package:reading_app/features/expanded/explores/search_book/presentation/controller/search_book_controller.dart';

class SearchBookPage extends GetView<SearchBookController> {
  const SearchBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            CustomScrollView(
              shrinkWrap: true, // Ensures CustomScrollView does not take all available space
              slivers: [
                SliverAppBar(
                  leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  title: const CustomSearchField(placeholder: AppContents.searchPlaceholder,),
                  bottom: const TabBar(
                    dividerColor: AppColors.black,
                    labelColor: AppColors.accentColor,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.accentColor,
                      ),
                    ),
                    tabs: [
                      Tab(text: "Tiểu thuyết"),
                      Tab(text: "Truyện tranh"),
                      Tab(text: "Truyện Audio"),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: controller.listPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
