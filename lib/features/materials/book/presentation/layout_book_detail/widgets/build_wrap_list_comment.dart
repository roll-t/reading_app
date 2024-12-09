import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/icons_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/service/api/dto/response/commentReponse.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/avatar/avatar.dart';
import 'package:reading_app/core/ui/widgets/card/card_comment.dart';
import 'package:reading_app/core/ui/widgets/text/expandable_text.dart';
import 'package:reading_app/core/ui/widgets/textfield/comment_text_field.dart';
import 'package:reading_app/core/utils/date_time.dart';
import 'package:reading_app/features/materials/book/model/comment_bottom_sheet_model.dart';

// ignore: must_be_immutable
class BuildWrapListComment extends StatelessWidget {
  String? bookTitle;
  final double heightWrapList;
  final String? novelId;
  final String? comicId;
  final String? titleList;
  final double widthCard;
  final EdgeInsetsGeometry margin;
  final List<CommentResponse> listComment;
  final VoidCallback? toDetail;
  final Axis scrollDirection;

  BuildWrapListComment({
    super.key,
    required this.heightWrapList,
    this.titleList,
    this.bookTitle,
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
                            Icon(
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
                        final commentBottomSheetModel = CommentBottomSheetModel(
                          userModel: listComment[index].user,
                          commentContent: listComment[index].content,
                          bookTitle: bookTitle,
                          commentTime: listComment[index].createdAt,
                          chapterName:
                              listComment[index].chapter?.chapterName ?? "",
                          photoUrl: listComment[index].user.photoURL,
                        );

                        CommentBottomSheet.show(
                            context, commentBottomSheetModel);
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
  final CommentBottomSheetModel? commentBottomSheetModel;

  const CommentBottomSheet({super.key, this.commentBottomSheetModel});

  static void show(BuildContext context, CommentBottomSheetModel model) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows customized height for BottomSheet
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(SpaceDimens.spaceStandard),
        ),
      ),
      builder: (context) => CommentBottomSheet(commentBottomSheetModel: model),
    );
  }

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
                _BuildContentAuthComment(),
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
          SizedBox(width: SpaceDimens.space10),
          Icon(Icons.send),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BuildAuthorComment(),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, bottom: 20),
            child: ExpandableText(
              colorText: AppColors.white,
              text: commentBottomSheetModel?.commentContent ?? "",
            ),
          ),
          const SizedBox(height: SpaceDimens.space15),
          Row(
            children: [
              TextSmall(
                textChild: DatetimeUtil.timeAgo(
                    commentBottomSheetModel?.commentTime ?? DateTime.now()),
                colorChild: AppColors.gray2,
              ),
              const SizedBox(width: SpaceDimens.space20),
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
          child: TextNormal(
            textChild: commentBottomSheetModel?.bookTitle ?? "Tên sách",
            maxLinesChild: 1,
          ),
        ),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: IconsDimens.iconsSize20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SpaceDimens.space10),
          child:
              TextNormal(textChild: commentBottomSheetModel?.chapterName ?? ""),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildAuthorComment() {
    return Row(
      children: [
        Avatar(
          radius: 40,
          url: commentBottomSheetModel?.photoUrl,
        ),
        const SizedBox(width: SpaceDimens.space10),
        TextNormal(
          textChild:
              commentBottomSheetModel?.userModel?.displayName ?? "Đọc giả",
          maxLinesChild: 1,
        ),
      ],
    );
  }
}
