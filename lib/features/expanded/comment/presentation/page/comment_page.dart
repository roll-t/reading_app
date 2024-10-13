import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_normal_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/avatar/avatar.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/core/ui/widgets/text/expandable_text.dart';
import 'package:reading_app/core/ui/widgets/textfield/comment_text_field.dart';
import 'package:reading_app/features/expanded/comment/presentation/controller/comment_controller.dart';

class CommentPage extends GetView<CommentController> {
  const CommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: const leadingIconAppBar(), // Fixed casing issue
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.comment),
                const SizedBox(width: SpaceDimens.space10),
                TextMediumSemiBold(
                  textChild: TextFormat.capitalizeEachWord(
                    "9 ${AppContents.comment}",
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child:SizedBox(height: SpaceDimens.space25,),),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: SpaceDimens.space20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: SpaceDimens.space5,left: SpaceDimens.spaceStandard),
                        child: Avatar(radius: 35),
                      ),
                      const SizedBox(
                        width: SpaceDimens.space5,
                      ),
                      Container(
                          constraints: BoxConstraints(maxWidth: Get.width * .8),
                          padding: const EdgeInsets.only(
                              left: SpaceDimens.spaceStandard,
                              right: SpaceDimens.spaceStandard,
                              bottom: SpaceDimens.spaceStandard,
                              top: SpaceDimens.space5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  RadiusDimens.radiusSmall2),
                              color: AppColors.secondaryDarkBg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextNormalSemiBold(
                                textChild: "Ten tac gia viet ơ day",
                                maxLineChild: 1,
                              ),
                              const SizedBox(
                                height: SpaceDimens.space10,
                              ),
                              ExpandableText(
                                text:
                                    "Comnet viet ơ day nè Comnet viet ơ day nè Comnet viet ơ day nèComnet viet ơ day nèComnet viet ơ day nè",
                                colorText: AppColors.white,
                              ),
                            ],
                          ))
                    ],
                  ),
                );
              },
              childCount: 10, // Number of items in the list
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.gray3, width: .3))),
        padding: const EdgeInsets.symmetric(
            horizontal: SpaceDimens.spaceStandard,
            vertical: SpaceDimens.space5),
        child: const Row(
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
      ),
    );
  }
}
