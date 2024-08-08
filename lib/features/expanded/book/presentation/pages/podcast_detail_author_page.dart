import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/app_colors.dart';
import 'package:reading_app/core/ui/widgets/appbar/appbar_widget.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/podcast_detail_author_controller.dart';
import 'package:reading_app/features/expanded/book/presentation/pages/podcast_detail_page.dart';
import 'package:reading_app/features/expanded/book/presentation/widgets/item_book_podcast.dart';
import 'package:reading_app/features/expanded/book/presentation/widgets/item_podcast.dart';

class PodcastDetailAuthorPage extends StatelessWidget {
  const PodcastDetailAuthorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String tag =
        'PodcastDetailAuthor ${DateTime.now().microsecondsSinceEpoch}';
    final PodcastDetailAuthorController podcastDetailAuthorController =
        Get.put(PodcastDetailAuthorController(), tag: tag);
    return PodcastDetailAuthorBody(
      tag: tag,
      controller: podcastDetailAuthorController,
    );
  }
}

class PodcastDetailAuthorBody extends StatelessWidget {
  const PodcastDetailAuthorBody(
      {super.key, required this.tag, required this.controller});
  final String tag;
  final PodcastDetailAuthorController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '',

        backgroundColor: AppColors.primary.withOpacity(0.5),
        callbackLeading: Get.back,
        // menuItem: [
        //   Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
        //     margin: const EdgeInsets.only(right: 10.0),
        //     decoration: BoxDecoration(
        //       color: AppColors.blue3,
        //       borderRadius: BorderRadius.circular(15),
        //     ),
        //     child: TextWidget(
        //       text: 'Author',
        //       color: AppColors.white,
        //       size: 10,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   )
        // ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildInforAuthor(),
          buildFollower(),
          buildTabChapter(context)
        ],
      ),
    );
  }

  Widget buildFollower() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15, right: 15.0, top: 10.0, bottom: 60),
      child: Column(
        children: [
          TextWidget(
            text: 'Follow us on:',
            color: AppColors.primary,
            size: 14,
            fontWeight: FontWeight.w600,
          ),
          Row(
            children: [
              Image.asset(
                "assets/icons/instagram.png",
                height: 30,
                width: 30,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Image.asset(
                "assets/icons/facebook.png",
                height: 25,
                width: 25,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Image.asset(
                "assets/icons/threads.png",
                height: 25,
                width: 25,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildInforAuthor() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      // color: AppColors.primary.withOpacity(0.5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.5),
            AppColors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // AvatarComponent(
              //   isBorder: false,
              //   height: 90,
              //   width: 90,
              //   url:
              //       'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
              // ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidget(
                    text: 'Robinton Misty',
                    fontWeight: FontWeight.bold,
                    size: 17,
                    color: AppColors.primary,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    "assets/icons/verify.png",
                    height: 20,
                    width: 20,
                    color: AppColors.black4,
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              ButtonWidget(
                ontap: () {},
                text: 'Follow',
                borderRadius: 25,
                backgroundColor: AppColors.primary,
                fontWeight: FontWeight.w600,
                width: 120.0,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      TextWidget(
                        text: '1',
                        fontWeight: FontWeight.w500,
                        size: 16,
                      ),
                      TextWidget(
                        text: 'Audio Series',
                        size: 11,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextWidget(
                        text: '1',
                        fontWeight: FontWeight.w500,
                        size: 16,
                      ),
                      TextWidget(
                        text: 'Followers',
                        size: 11,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          TextWidget(
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
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.black.withOpacity(0.5),
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: AppColors.primary, width: 2.0),
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
    return GridView.builder(
      padding: const EdgeInsets.only(top: 25.0),
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        mainAxisSpacing: 10.0, // Spacing between rows
        crossAxisSpacing: 10.0, // Spacing between columns
        childAspectRatio: 0.90, // Aspect ratio of the grid items
      ),
      itemBuilder: (_, index) {
        return ItemBookPodCast();
      },
    );
  }

  Widget tabBarReview(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 25.0),
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        mainAxisSpacing: 10.0, // Spacing between rows
        crossAxisSpacing: 10.0, // Spacing between columns
        childAspectRatio: 0.90, // Aspect ratio of the grid items
      ),
      itemBuilder: (_, index) {
        return ItemPodCast();
      },
    );
  }

  Widget buildItem() {
    return Card(
      color: AppColors.gray,
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
                  TextWidget(
                    text: 'A Find Balance',
                    fontWeight: FontWeight.w600,
                    size: 16,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 5.0),
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
    );
  }
}
