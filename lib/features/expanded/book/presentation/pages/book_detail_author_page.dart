import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/appbar/appbar_widget.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/book_detail_author_controller.dart';
import 'package:reading_app/features/expanded/book/presentation/pages/podcast_detail_page.dart';

class BookDetailAuthorPage extends StatelessWidget {
  const BookDetailAuthorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String tag =
        'BookDetailAuthor ${DateTime.now().microsecondsSinceEpoch}';
    final BookDetailAuthorController bookDetailAuthorController =
        Get.put(BookDetailAuthorController(), tag: tag);
    return BookDetailAuthorBody(
      tag: tag,
      controller: bookDetailAuthorController,
    );
  }
}

class BookDetailAuthorBody extends StatelessWidget {
  const BookDetailAuthorBody(
      {super.key, required this.tag, required this.controller});
  final String tag;
  final BookDetailAuthorController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Author',
        backgroundColor: AppColors.transparentColor,
        callbackLeading: Get.back,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [buildInforAuthor(), buildTabChapter(context)],
      ),
    );
  }

  Widget buildInforAuthor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 180.0,
                width: 140,
                // margin: const EdgeInsets.only(top: 10.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: 'Robinton Misty',
                    fontWeight: FontWeight.bold,
                    size: 26,
                  ),
                  const SizedBox(height: 10.0),
                  const Row(
                    children: [
                      TextWidget(
                        text: '1 Books',
                        fontWeight: FontWeight.bold,
                        size: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 5.0),
                        child: Icon(
                          Icons.circle,
                          size: 10,
                        ),
                      ),
                      TextWidget(
                        text: '2 Followers',
                        fontWeight: FontWeight.bold,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ButtonWidget(
                    ontap: () {},
                    text: 'Follow',
                    borderRadius: 25,
                    backgroundColor: AppColors.accentColor,
                    fontWeight: FontWeight.w600,
                    width: 120.0,
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 20.0),
          const TextWidget(
            text: 'About',
            fontWeight: FontWeight.w500,
            size: 16,
          ),
          const SizedBox(height: 5.0),
          const TextWidget(
            text: 'About',
            size: 12,
          ),
        ],
      ),
    );
  }

  Widget buildTabChapter(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50.0,
          color: AppColors.white,
          margin: const EdgeInsets.only(top: 10.0),
          child: TabBar(
            controller: controller.tabController,
            isScrollable: false,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.normal),
            labelColor: AppColors.accentColor,
            unselectedLabelColor: AppColors.black.withOpacity(0.5),
            indicatorColor: AppColors.accentColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(color: AppColors.accentColor, width: 2.0),
              insets: EdgeInsets.only(bottom: 0.0),
            ),
            tabs: [
              Tab(text: "Books".tr),
              Tab(text: 'Podcast'.tr),
            ],
            onTap: (value) {},
          ),
        ),
        SizedBox(
            height: 500.0,
            child: TabBarView(
              controller: controller.tabController,
              children: [tabBarChapter(context), tabBarReview(context)],
            ))
      ],
    );
  }

  Widget tabBarChapter(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        itemCount: 10,
        itemBuilder: (_, index) {
          return buildItem();
        });
  }

  Widget tabBarReview(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        itemCount: 10,
        itemBuilder: (_, index) {
          return buildItem();
        });
  }

  Widget buildItem() {
    return InkWell(
      onTap: () {
        // Get.toNamed();
      },
      child: Card(
        color: AppColors.gray3,
        child: Padding(
          padding: const EdgeInsets.only(right: 3.0),
          child: Row(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 155.0,
                    width: 130,
                    // margin: const EdgeInsets.only(top: 10.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 13.0,
                    left: 7.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5.0),
                      child: const TextWidget(
                        text: "Free",
                        size: 10.0,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWidget(
                      text: 'A Find Balance',
                      fontWeight: FontWeight.w600,
                      size: 16,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 5.0),
                        TextWidget(
                          text: '4.1',
                          fontWeight: FontWeight.w400,
                          size: 15,
                        ),
                      ],
                    ),
                    ExpandableText(
                      fontSize: 7,
                      trimLines: 2,
                      fontSizeReadMore: 14,
                      colorText: AppColors.black.withOpacity(0.5),
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque id orci sem. Donec viverra nisi a augue convallis, in vehicula libero varius. Praesent sed consequat est, nec aliquam lectus. Fusce ultrices, magna non rhoncus commodo, eros justo vestibulum elit, non gravida elit nisi id ligula. Integer nec dictum magna, nec laoreet lorem. Phasellus ut elit sem. Nullam sit amet enim id est vestibulum laoreet. Ut at odio ut tortor ultricies tempor.',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
