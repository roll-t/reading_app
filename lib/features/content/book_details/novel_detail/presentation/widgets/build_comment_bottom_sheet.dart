
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/services/api/data/entities/dto/response/commentReponse.dart';
import 'package:reading_app/features/content/book_details/novel_detail/presentation/controller/read_novel_cotroller.dart';
import 'package:reading_app/features/content/book_details/novel_detail/presentation/widgets/build_comment_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildCommentBottomSheet extends GetView<ReadNovelController> {
  final RxList<CommentResponse> listComment;
  const BuildCommentBottomSheet({
    super.key,
    required this.listComment,
  });

  static void show(BuildContext context, RxList<CommentResponse> comments) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(SpaceDimens.spaceStandard),
        ),
      ),
      builder: (context) => BuildCommentBottomSheet(
        listComment: comments,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: Padding(
          padding: EdgeInsets.only(bottom: keyboardPadding),
          child: Container(
            padding: const EdgeInsets.all(SpaceDimens.spaceStandard),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10.h),
                  width: double.infinity,
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: listComment.length,
                      itemBuilder: (context, index) {
                        return BuildCommentCard(
                          comment: listComment[index],
                          controller: controller,
                        ); // Render each comment
                      },
                    );
                  }),
                ),
                // BuildCommentBox(controller: controller),
                Obx(() {
                  return true
                      ? Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.gray3.withOpacity(.4)),
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ))
                      : const SizedBox.shrink();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
