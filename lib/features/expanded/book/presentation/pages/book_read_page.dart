import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/widgets/icons/icon_circle.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/book_read_controller.dart';

class BookReadPage extends GetView<BookReadController> {
  const BookReadPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: double.infinity,
                    child: TextNormal(textChild: "chuong ${index + 1}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () {
          return Stack(
            children: [
              CustomScrollView(
                controller: controller.scrollController,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return InkWell(
                          onTap: controller.scrollDown,
                          child: CachedNetworkImage(
                            imageUrl: controller.imageUrls[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(AppColors.primary),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.error, color: AppColors.error),
                                  SizedBox(height: 8),
                                  Text('Failed to load image',
                                      style: TextStyle(color: AppColors.error)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: controller.imageUrls.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Obx(() => controller.loading.value
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(AppColors.primary),
                              ),
                            ),
                          )
                        : const SizedBox.shrink()),
                  ),
                ],
              ),
              Positioned(
                top: SpaceDimens.spaceStandard + SpaceDimens.space15,
                left: SpaceDimens.spaceStandard,
                right: SpaceDimens.spaceStandard,
                child: Builder(
                  builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const leadingIconAppBar(),
                        IconCircle(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          iconChild: Icons.menu,
                          iconColor: AppColors.white,
                          background: AppColors.white.withOpacity(.2),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
