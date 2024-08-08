import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/card/card_by_category.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/book_detail_controller.dart';
import 'package:reading_app/features/expanded/book/presentation/widgets/shared/build_wrap_list_card.dart';
import 'package:reading_app/features/expanded/book/presentation/widgets/shared/build_wrap_list_comment.dart';
import 'package:reading_app/features/expanded/book/presentation/widgets/shared/expandable_text.dart';

class BuildContentBookDetail extends GetView<BookDetailController> {
  const BuildContentBookDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: SpaceDimens.spaceStandard),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: SpaceDimens.space20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextMediumSemiBold(textChild: AppContents.type),
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: SpaceDimens.space10,
                          top: SpaceDimens.space10),
                      margin:
                          const EdgeInsets.only(bottom: SpaceDimens.space30),
                      width: Get.width,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.gray3, width: .5))),
                      child: const Wrap(
                        spacing: SpaceDimens.space10,
                        children: [
                          TagCategory(categoryName: "Hoàn thành"),
                          TagCategory(categoryName: "Huyền thoại"),
                          TagCategory(categoryName: "Đô thị"),
                        ],
                      ),
                    )
                  ],
                ),
                const TextMediumSemiBold(textChild: AppContents.description),
                const SizedBox(
                  height: SpaceDimens.space10,
                ),
                const ExpandableText(
                    text:
                        "Một thế giới huyền bí đang chờ đón bạn! Ẩn sau những lớp màn bí mật, cuộc phiêu lưu của chúng ta bắt đầu từ một vùng đất xa xôi, nơi mà những điều kỳ diệu và hiểm nguy luôn song hành. Lorem ipsum dolor sit amet kể về hành trình đầy gian nan của những anh hùng vô danh, những người dám đứng lên đối đầu với số phận để tìm ra sự thật ẩn giấu và bảo vệ những gì họ yêu thương. Cùng theo chân họ, ta sẽ bước vào một thế giới đầy màu sắc với những mối quan hệ phức tạp, những trận chiến căng thẳng, và những khoảnh khắc lắng đọng đầy cảm xúc. Hãy chuẩn bị tinh thần để đắm mình trong câu chuyện đầy lôi cuốn và không thể đoán trước được của Lorem ipsum dolor sit amet"),
                const SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),


        // Build list có thể bạn sẽ thích
        SliverToBoxAdapter(
          child: BuildWrapListComment(
            titleList: AppContents.comment,
            heightWrapList: 200,
            widthCard: 150,
            toDetail: () {
              Get.toNamed(Routes.category,
                  arguments: {"titleCategory": "Có thể bạn sẽ thích"});
            },
          ),
        ),
        // Build list có thể bạn sẽ thích
        SliverToBoxAdapter(
          child: BuildWrapListCard(
            listBookData: controller.listValueCardContinue,
            titleList: "Có thể bạn sẽ thích",
            heightWrapList: 270,
            widthCard: 150,
            seeMore: () {
              Get.toNamed(Routes.category,
                  arguments: {"titleCategory": "Có thể bạn sẽ thích"});
            },
            cardBuilder: (double widthCard, bookModel) {
              return CardByCategory(
                widthCard: widthCard,
                heightImage: 190,
                bookModel: bookModel,
              );
            },
          ),
        ),
      ],
    );
  }
}
