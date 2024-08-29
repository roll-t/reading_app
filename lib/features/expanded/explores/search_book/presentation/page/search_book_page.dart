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
      body: GetBuilder<SearchBookController>(
        id: "IDSeach",
        builder: (_) {
          return !controller.isLoading.value
              ? DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    controller: controller.scrollController,
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        floating: true,
                        pinned: true,
                        leading: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        title: const CustomSearchField(
                          placeholder: AppContents.searchPlaceholder,
                        ),
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
                            Tab(text: "Truyện tranh"),
                            Tab(text: "Tiểu thuyết"),
                          ],
                        ),
                      ),
                    ],
                    body: TabBarView(
                      children: controller.listPage,
                    ),
                  ),
                ):const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
