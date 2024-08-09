import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/appbar/appbar_widget.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/book_read_controller.dart';

class BookReadPage extends GetView<BookReadController> {
  const BookReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        leading: leadingIconAppBar(),
        backgroundColor: AppColors.transparentColor,
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
                onTap: () {
                  // Chuyển sang trang kế tiếp
                  if (index < controller.imageUrls.length - 1) {
                    controller.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
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
                  decoration: const BoxDecoration(
                    color: AppColors.gray3,
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
  final VoidCallback onTap;

  const KeepAlivePage({super.key, required this.imageUrl, required this.onTap});

  @override
  // ignore: library_private_types_in_public_api
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: widget.onTap, // Lắng nghe sự kiện click
      child: ClipRRect(
        child: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          fit: BoxFit.contain,
          width: double.infinity,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
