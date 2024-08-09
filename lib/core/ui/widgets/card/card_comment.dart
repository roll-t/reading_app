import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_small.dart';
import 'package:reading_app/core/ui/widgets/avatar/avatar.dart';

class CardComment extends StatelessWidget {
  const CardComment({
    super.key,
  });

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

  // ignore: non_constant_identifier_names
  Row _BuildBottomLine() {
    return Row(
      children: [
        const TextSmall(
          textChild: "2 tháng trước",
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
    return const Expanded(
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        titleAlignment: ListTileTitleAlignment.top,
        title: TextSmall(
          textChild: "comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here comment writing this here",
          maxLinesChild: 2,
        ),
        subtitle: TextSmall(
          textChild: "${AppContents.chapter} 5",
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
