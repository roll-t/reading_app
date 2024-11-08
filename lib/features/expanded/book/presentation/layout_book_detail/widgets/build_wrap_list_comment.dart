import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/avatar/avatar.dart';
import 'package:reading_app/core/ui/widgets/card/card_comment.dart';
import 'package:reading_app/core/ui/widgets/text/expandable_text.dart';
import 'package:reading_app/core/ui/widgets/textfield/comment_text_field.dart';

class BuildWrapListComment extends StatelessWidget {
  final double heightWrapList;
  final String? novelId;
  final String? comicId;
  final String? titleList;
  final double widthCard;
  final EdgeInsetsGeometry margin;
  final List<CommentResponse> listComment;
  final VoidCallback? toDetail;
  final Axis scrollDirection;

  const BuildWrapListComment({
    super.key,
    required this.heightWrapList,
    this.titleList,
    this.novelId,
    required this.widthCard,
    this.margin = const EdgeInsets.only(top: SpaceDimens.space20),
    this.toDetail,
    this.scrollDirection = Axis.horizontal,
    this.listComment = const [],
    this.comicId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: titleList != null
          ? heightWrapList + SpaceDimens.space10 + TextDimens.textLarge
          : heightWrapList,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titleList != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: SpaceDimens.spaceStandard,
                      bottom: SpaceDimens.space10),
                  child: TextMediumSemiBold(textChild: titleList!),
                ),
                if (toDetail != null)
                  Padding(
                    padding: const EdgeInsets.only(
                        right: SpaceDimens.spaceStandard,
                        bottom: SpaceDimens.space10),
                    child: InkWell(
                        onTap: toDetail,
                        child: Row(
                          children: [
                            TextSmall(
                                textChild:
                                    "${listComment.length} ${AppContents.comment}",
                                colorChild: AppColors.gray2),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: IconsDimens.iconsSize18,
                              color: AppColors.gray2,
                            )
                          ],
                        )),
                  ),
              ],
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SpaceDimens.spaceStandard),
              child: ListView.builder(
                scrollDirection: scrollDirection,
                itemCount: listComment.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        CommentBottomSheet.show(context);
                      },
                      child: CardComment(
                        commentData: listComment[index],
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommentBottomSheet extends StatelessWidget {
  const CommentBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
        padding: const EdgeInsets.all(SpaceDimens.spaceStandard),
        child: Stack(
          children: [
            Column(
              children: [
                _BuildHeadlineCommentSheet(context),
                _BuildContentAuthComment()
              ],
            ),
            _BuildCommentBox(),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Positioned _BuildCommentBox() {
    return const Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        children: [
          CommentTextField(
            placeholder: "Nhập bình luận ....",
          ),
          SizedBox(
            width: SpaceDimens.space10,
          ),
          Icon(Icons.send)
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container _BuildContentAuthComment() {
    return Container(
      padding: const EdgeInsets.only(bottom: SpaceDimens.spaceStandard),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: AppColors.gray3, width: .5))),
      child: Column(
        children: [
          _BuildAuthorComment(),
          const SizedBox(
            height: SpaceDimens.space15,
          ),
          ExpandableText(
            colorText: AppColors.white,
            text:
                "comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here",
          ),
          const SizedBox(
            height: SpaceDimens.space15,
          ),
          const Row(
            children: [
              TextSmall(
                textChild: "2 Tháng trước",
                colorChild: AppColors.gray2,
              ),
              SizedBox(
                width: SpaceDimens.space20,
              ),
              TextSmall(textChild: "Thích", colorChild: AppColors.gray2),
            ],
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row _BuildHeadlineCommentSheet(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: Get.width * 0.4,
          child: const TextNormal(
            textChild: "Trường dinh bất tử từ trẩm yêu trừ ma",
            maxLinesChild: 1,
          ),
        ),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          size: IconsDimens.iconsSize20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: SpaceDimens.space10),
          child: TextNormal(textChild: "${AppContents.chapter} 43"),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildAuthorComment() {
    return const Row(
      children: [
        Avatar(
          radius: 40,
          url: null,
        ),
        SizedBox(
          width: SpaceDimens.space10,
        ),
        TextNormal(
          textChild: "user name",
          maxLinesChild: 1,
        )
      ],
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Cho phép BottomSheet mở rộng chiều cao tùy chỉnh
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(SpaceDimens.spaceStandard),
        ),
      ),
      builder: (BuildContext context) {
        return const CommentBottomSheet();
      },
    );
  }
}
