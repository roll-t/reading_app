import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/app_colors.dart';
import 'package:reading_app/core/ui/widgets/appbar/appbar_widget.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/book_read_controller.dart';

class BookReadPage extends GetView<BookReadController> {
  const BookReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Comic Reader',
        backgroundColor: AppColors.transparent,
        callbackLeading: Get.back,
        // menuItem: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.bookmark,
        //       color: AppColors.green25,
        //     ),
        //   )
        // ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.vertical,
            controller: controller.pageController,
            itemCount: controller.imageUrls.length,
            itemBuilder: (context, index) {
              return KeepAlivePage(
                imageUrl: controller.imageUrls[index],
              );
            },
          ),
          AnimatedBuilder(
            animation: controller.pageController,
            builder: (context, child) {
              final page = controller.pageController.hasClients
                  ? controller.pageController.page
                  : 0;
              double indicatorTop = page != null
                  ? (MediaQuery.of(context).size.height /
                          (controller.imageUrls.length - 1)) *
                      page
                  : 0;

              return Positioned(
                right: 0,
                top: indicatorTop.clamp(
                    20.0, MediaQuery.of(context).size.height - 130),
                child: Container(
                  width: 33,
                  height: 35,
                  decoration: BoxDecoration(
                    color: AppColors.gray,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0),
                    ),
                  ),
                  child: Center(
                    child: TextWidget(
                      text: '${controller.currentPage.value + 1}',
                      size: 12,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  final String imageUrl;

  const KeepAlivePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ClipRRect(
      // borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
