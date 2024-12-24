import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/radius_dimens.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/dimens/text_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/extensions/text_format.dart';
import 'package:reading_app/core/service/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/ui/widgets/avatar/avatar.dart';
import 'package:reading_app/core/ui/widgets/icons/leading_icon_app_bar.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/text/customs/text_normal_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/text/expandable_text.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/ui/widgets/textfield/comment_text_field.dart';
import 'package:reading_app/core/utils/date_time_utils.dart';
import 'package:reading_app/features/materials/comment/presentation/controller/comment_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommentPage extends GetView<CommentController> {
  const CommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchComments();
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        leading: leadingIconAppBar(back: () {
                          Get.back(
                              result: {"manipulate": controller.isManipulate});
                        }),
                        centerTitle: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.comment),
                            const SizedBox(width: SpaceDimens.space10),
                            Obx(() {
                              return TextMediumSemiBold(
                                textChild: TextFormat.capitalizeEachWord(
                                  "${controller.listComment.length} ${AppContents.comment}",
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: SpaceDimens.space25,
                        ),
                      ),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const SliverToBoxAdapter(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: controller.listComment.length,
                            (BuildContext context, int index) {
                              final CommentResponse comment =
                                  controller.listComment[index];
                              return CommentCard(comment);
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: AppColors.gray3, width: .3)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: SpaceDimens.spaceStandard,
                  vertical: SpaceDimens.space5,
                ),
                child: Row(
                  children: [
                    CommentTextField(
                      controller: commentController,
                      placeholder: "Nhập bình luận ....",
                      onChanged: (value) {
                        controller.commentValue = value;
                      },
                    ),
                    const SizedBox(width: SpaceDimens.space10),
                    InkWell(
                      onTap: () async {
                        if (controller.commentValue?.trim().isNotEmpty ??
                            false) {
                          await controller
                              .addComment(controller.commentValue!.trim());
                          commentController.clear();
                          controller.commentValue = "";
                        }
                      },
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Obx(() {
            return controller.isLoadingProcess.value
                ? Positioned(
                    child: Container(
                    decoration:
                        BoxDecoration(color: AppColors.gray3.withOpacity(.5)),
                    child: const Center(child: CircularProgressIndicator()),
                  ))
                : const SizedBox.shrink();
          })
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container CommentCard(CommentResponse comment) {
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
          const SizedBox(
            width: SpaceDimens.space5,
          ),
          Column(
            children: [
              Container(
                width: 80.w,
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
                width: 80.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      color: AppColors.gray2,
                      size: TextDimens.textSize12,
                      text: DatetimeUtil.timeAgo(comment.createdAt),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    const TextWidget(
                      color: AppColors.gray2,
                      size: TextDimens.textSize12,
                      text: "Thích",
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    controller.auth.value?["uid"] == comment.user.uid
                        ? InkWell(
                            onTap: () {
                              controller.deleteComment(comment.commentId);
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
