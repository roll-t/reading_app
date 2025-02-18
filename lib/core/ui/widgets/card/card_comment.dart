import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/commentReponse.dart';
import 'package:reading_app/core/ui/widgets/avatar/avatar.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_small.dart';
import 'package:reading_app/core/utils/date_time_utils.dart';

// ignore: must_be_immutable
class CardComment extends StatelessWidget {
  final CommentResponse commentData;
  CardComment({super.key, required this.commentData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SpaceDimens.spaceStandard),
      margin: const EdgeInsets.only(right: SpaceDimens.space20),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray2, width: .5),
          color: AppColors.tertiaryDarkBg,
          borderRadius: BorderRadius.circular(10)),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BuildAuthorComment(),
          const SizedBox(
            height: SpaceDimens.space15,
          ),
          _BuildContentComment(),
          const Spacer(),
          _BuildBottomLine()
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildAuthorComment() {
    return Row(
      children: [
        Avatar(
          radius: 40,
          url: commentData.user.photoURL,
        ),
        const SizedBox(
          width: SpaceDimens.space10,
        ),
        TextNormal(
          textChild: commentData.user.displayName ?? "Đọc giả",
          maxLinesChild: 1,
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Row _BuildBottomLine() {
    return Row(
      children: [
        TextSmall(
          textChild: DatetimeUtil.timeAgo(commentData.createdAt),
          colorChild: AppColors.gray2,
        ),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(
              Icons.more_vert,
              size: 14,
              color: AppColors.gray2,
            ),
            const SizedBox(
              width: SpaceDimens.space10,
            ),
            _BuildReactTagComment(
              iconChildData: Icons.thumb_up_outlined,
            ),
            const SizedBox(
              width: SpaceDimens.space20,
            ),
            _BuildReactTagComment(
              iconChildData: Icons.message_sharp,
            ),
          ],
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Expanded _BuildContentComment() {
    return Expanded(
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        titleAlignment: ListTileTitleAlignment.top,
        title: TextSmall(
          textChild: commentData.content,
          maxLinesChild: 2,
        ),
        subtitle: TextSmall(
          textChild: commentData.chapter?.chapterName ?? "",
          maxLinesChild: 1,
          colorChild: AppColors.gray2,
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildReactTagComment(
      {required IconData iconChildData, int quantity = 0}) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(
            iconChildData,
            size: 14,
            color: AppColors.gray2,
          ),
          const SizedBox(
            width: 2,
          ),
          TextSmall(
            textChild: "$quantity",
            colorChild: AppColors.gray2,
          )
        ],
      ),
    );
  }
}
