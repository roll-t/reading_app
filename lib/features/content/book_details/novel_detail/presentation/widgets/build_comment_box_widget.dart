// import 'package:flutter/material.dart';
// import 'package:reading_app/core/configs/dimens/space_dimens.dart';
// import 'package:reading_app/core/configs/themes/app_colors.dart';
// import 'package:reading_app/core/ui/widgets/textfield/comment_text_field.dart';
// import 'package:reading_app/features/content/book_details/novels/presentation/controller/read_novel_cotronller.dart';

// class BuildCommentBox extends StatelessWidget {
//   const BuildCommentBox({
//     super.key,
//     required this.controller,
//   });

//   final ReadNovelController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: Container(
//         decoration: const BoxDecoration(
//           color: AppColors.primaryDarkBg,
//           border: Border(top: BorderSide(width: .5, color: AppColors.gray3)),
//         ),
//         child: Row(
//           children: [
//             CommentTextField(
//               placeholder: "Nhập bình luận ....",
//               controller: controller.commentController,
//               onChanged: (value) {
//                 controller.comment.value =
//                     value; // Use GetX state management for comment
//               },
//             ),
//             const SizedBox(width: SpaceDimens.space10),
//             IconButton(
//               icon: const Icon(Icons.send),
//               onPressed: () async {
//                 if (controller.comment.value.isNotEmpty) {
//                   await controller.addComment(
//                       contentComment: controller.comment.value);
//                   controller.comment.value = '';
//                   controller.commentController.clear();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
