import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/service/api/dto/response/novel_response.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/images/image_widget.dart';

class NovelExplore extends StatelessWidget {
  final double widthCard;
  final double heightCard;
  final NovelResponse bookModel;

  const NovelExplore({
    super.key,
    required this.widthCard,
    required this.heightCard,
    required this.bookModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.novelDetail,
            arguments: {"novelId": bookModel.bookDataId});
      },
      child: SizedBox(
        height: heightCard,
        width: widthCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: heightCard * .65,
              child: ImageWidget(imageUrl: bookModel.thumbUrl ?? ""),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: SpaceDimens.space5,
                ),
                TextSmall(
                  textChild: bookModel.name ?? "",
                  maxLinesChild: 2,
                ),
                const Spacer(),
                TextSmall(
                  colorChild: AppColors.gray2,
                  textChild: bookModel.categorySlug?[0].toString() ?? "",
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
