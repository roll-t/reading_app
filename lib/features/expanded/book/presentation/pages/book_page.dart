import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/app_colors.dart';
import 'package:reading_app/core/ui/widgets/carousel_slider/slider_image.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/ui/widgets/text_input/simple_input_textfield.dart';

import '../controller/book_controller.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(
      backgroundColor: Colors.white,
      body: BookBody(),
    );
  }
}

class BookBody extends GetView<BookController> {
  const BookBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: false,
          pinned: true,
          centerTitle: true,
          title: const TextWidget(
            text: 'Book',
          ),
          // leading: IconButton(
          //   icon: Icon(Icons.menu),
          //   onPressed: () {},
          // ),
          actions: [
            IconButton(
              color: AppColors.primary,
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: buildInputSearch(),
        ),
        SliverToBoxAdapter(
          child: componentSliderImage(),
        ),
        SliverToBoxAdapter(
          child: buildListCategories(),
        ),
        SliverToBoxAdapter(
          child: buildListBook(),
        ),
        SliverToBoxAdapter(
          child: buildListPodcast(),
        ),
      ],
    );
  }

  componentSliderImage() {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: const SliderImage(
        imgList: [
          'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
          'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
          'https://images.unsplash.com/photo-1470770841072-f978cf4d019e',
          'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0',
        ],
      ),
    );
  }

  buildListCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextWidget(
                text: 'Categories',
                size: 16.0,
                fontWeight: FontWeight.w500,
              ),
              TextWidget(
                text: 'See All',
                size: 12.0,
                fontWeight: FontWeight.w500,
                color: AppColors.primary.withOpacity(0.9),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 78.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (_, index) {
                  return Container(
                    width: 65.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7.0, vertical: 12.0),
                    margin: const EdgeInsets.only(right: 5.0),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(5.0)
                        // gradient: LinearGradient(
                        //   colors: [
                        //     AppColors.primary,
                        //     // AppColors.white,
                        //     // AppColors.primary,
                        //   ], // Các màu pha trộn
                        //   begin:
                        //       Alignment.centerLeft, // Điểm bắt đầu của gradient
                        //   end:
                        //       Alignment.centerRight, // Điểm kết thúc của gradient
                        // ),
                        ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
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
                  );
                }),
          ),
        ],
      ),
    );
  }

  buildListBook() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextWidget(
                text: 'New Books',
                size: 16.0,
                fontWeight: FontWeight.w500,
              ),
              TextWidget(
                text: 'See All',
                size: 12.0,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 236.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (_, index) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: 135.0,
                        child: Card(
                          // color: AppColors.gray36,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 145.0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15.0),
                                    topLeft: Radius.circular(15.0),
                                  ),
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
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 5.0, top: 2.0, right: 7.0),
                                child: Column(
                                  children: [
                                    TextWidget(
                                      text: 'Hello world world ddd world ddd',
                                      maxLines: 2,
                                      fontWeight: FontWeight.w500,
                                      size: 14,
                                    ),
                                    TextWidget(
                                      text: 'Hello world world ddd world ddd',
                                      maxLines: 1,
                                      size: 11.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 3.0, left: 5.0),
                                child: Container(
                                  height: 20.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: AppColors.primaryHover,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 3.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 12.0,
                                        color: AppColors.primary,
                                      ),
                                      const TextWidget(
                                        text: '4.6',
                                        fontWeight: FontWeight.normal,
                                        size: 11,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10.0,
                        left: 10.0,
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
                      Positioned(
                        bottom: 7.0,
                        right: 10.0,
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.black, width: 1.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            // color: AppColors.white,
                            size: 10.0,
                          ),
                          // padding: const EdgeInsets.all(10.0),
                          height: 13.0,
                          width: 13.0,
                        ),
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  buildListPodcast() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextWidget(
                text: 'New Podcasts',
                size: 16.0,
                fontWeight: FontWeight.w500,
              ),
              TextWidget(
                text: 'See All',
                size: 12.0,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 236.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (_, index) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: 170.0,
                        child: Card(
                          // color: AppColors.gray36,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 135.0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15.0),
                                    topLeft: Radius.circular(15.0),
                                  ),
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
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 5.0, top: 2.0, right: 7.0),
                                child: Column(
                                  children: [
                                    TextWidget(
                                      text: 'Hello world world ddd world ddd',
                                      maxLines: 2,
                                      fontWeight: FontWeight.w500,
                                      size: 14,
                                    ),
                                    TextWidget(
                                      text: 'Hello world world ddd world ddd',
                                      maxLines: 1,
                                      size: 11.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 3.0, left: 5.0),
                                child: Container(
                                  height: 20.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: AppColors.primary,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 3.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 12.0,
                                        color: AppColors.primary,
                                      ),
                                      const TextWidget(
                                        text: '4.6',
                                        fontWeight: FontWeight.normal,
                                        size: 11,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10.0,
                        left: 10.0,
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
                      Positioned(
                        bottom: 10.0,
                        right: 10.0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.primary, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.play_arrow,
                            color: AppColors.white,
                            size: 18.0,
                          ),
                          // padding: const EdgeInsets.all(10.0),
                          height: 25.0,
                          width: 25.0,
                        ),
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  buildInputSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SimpleInputTextField(
        height: 56.0,
        enableColor: Colors.transparent,
        focusedColor: Colors.transparent,
        backgroundColor: AppColors.primary,
        hintColor: AppColors.black.withOpacity(0.9),
        hintText: 'Search for books amd podcasts'.tr,
        controller: controller.searchController,
        onChanged: (String value) {},
        obscureText: false,
        prefixIcon: IconButton(
          iconSize: 20.0,
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        suffixIcon: IconButton(
          iconSize: 20.0,
          onPressed: () {},
          icon: const Icon(Icons.keyboard_voice),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // Change color based on the scroll offset
              double scrollOffset = constraints.biggest.height;
              Color appBarColor = scrollOffset > 100 ? Colors.blue : Colors.red;

              return FlexibleSpaceBar(
                title: const Text('Title'),
                background: Container(
                  color: appBarColor,
                ),
              );
            },
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListTile(
                title: Text('Item #$index'),
              );
            },
            childCount: 50, // Number of items in the list
          ),
        ),
      ],
    );
  }
}
