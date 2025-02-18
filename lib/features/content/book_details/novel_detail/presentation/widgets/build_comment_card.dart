import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/commentReponse.dart';
import 'package:reading_app/core/ui/widgets/avatar/avatar.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/text/expandable_text.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/utils/date_time_utils.dart';
import 'package:reading_app/features/content/book_details/novel_detail/presentation/controller/read_novel_cotroller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildCommentCard extends StatelessWidget {
  final CommentResponse comment;
  final ReadNovelController controller;

  const BuildCommentCard({
    super.key,
    required this.comment,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: SpaceDimens.space20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: SpaceDimens.space5,
              left: SpaceDimens.spaceStandard,
            ),
            child: Avatar(
              radius: 35,
              url: comment.user.photoURL,
            ),
          ),
          const SizedBox(width: SpaceDimens.space5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70.w,
                padding: const EdgeInsets.all(SpaceDimens.spaceStandard),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(RadiusDimens.radiusSmall2),
                  color: AppColors.secondaryDarkBg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextNormalSemiBold(
                      textChild: comment.user.displayName ?? "Đọc giả",
                      maxLineChild: 1,
                    ),
                    const SizedBox(height: SpaceDimens.space10),
                    ExpandableText(
                      text: comment.content,
                      colorText: AppColors.white,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 2.w, top: .5.h),
                width: 75.w,
                child: Row(
                  children: [
                    TextWidget(
                      color: AppColors.gray2,
                      size: TextDimens.textSize12,
                      text: DatetimeUtil.timeAgo(comment.createdAt),
                    ),
                    SizedBox(width: 5.w),
                    const TextWidget(
                      color: AppColors.gray2,
                      size: TextDimens.textSize12,
                      text: "Thích",
                    ),
                    SizedBox(width: 5.w),
                    controller.authID == comment.user.uid
                        ? InkWell(
                            onTap: () async {
                              // await controller.deleteComment(comment.commentId);
                            },
                            child: const TextWidget(
                              color: AppColors.primaryLight,
                              size: TextDimens.textSize12,
                              text: "Xóa",
                            ),
                          )
                        : const TextWidget(
                            color: AppColors.gray2,
                            size: TextDimens.textSize12,
                            text: "Phản hồi",
                          ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
