import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/data/database/model/list_comic_model.dart';
import 'package:reading_app/core/data/dto/response/category_response.dart';
import 'package:reading_app/core/data/dto/response/commentReponse.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/customs_widget_theme/texts/text_medium_semi_bold.dart';
import 'package:reading_app/core/ui/widgets/tags/tag_category.dart';
import 'package:reading_app/core/ui/widgets/text/expandable_text.dart';
import 'package:reading_app/features/expanded/book/presentation/layout_book_detail/widgets/build_wrap_list_comment.dart';
import 'package:reading_app/features/expanded/novel/presentation/controller/novel_detail_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildContentBookDetail extends StatelessWidget {
  final NovelDetailController? novelController;
  final String? novelId;
  final List<CategoryModel> categories;
  final List<CategoryResponse>? categoriesNovel;
  final String? description;
  final List<CommentResponse> listComment;
  final SliverToBoxAdapter? listRelate;

  const BuildContentBookDetail({
    super.key,
    this.categories = const [],
    this.description,
    this.listRelate,
    this.categoriesNovel,
    this.listComment = const [],
    this.novelId,
    this.novelController,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (novelController != null) {
          await novelController!.loadNovelDetails();
        }
      },
      child: CustomScrollView(
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
                        width: 100.w,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColors.gray3, width: .5))),
                        child: Wrap(
                          spacing: SpaceDimens.space10,
                          runSpacing: SpaceDimens.space10,
                          children: [
                            for (var value in categories)
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.category,
                                      arguments: {"slugQuery": value.slug});
                                },
                                child: TagCategory(
                                  categoryName: value.name,
                                ),
                              ),
                            if (categoriesNovel != null)
                              for (var value in categoriesNovel ?? [])
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.categoryNovel,
                                        arguments: {"slugQuery": value.slug});
                                  },
                                  child: TagCategory(
                                    categoryName: value.name,
                                  ),
                                )
                          ],
                        ),
                      )
                    ],
                  ),
                  const TextMediumSemiBold(textChild: AppContents.description),
                  const SizedBox(
                    height: SpaceDimens.space10,
                  ),
                  ExpandableText(text: description ?? ""),
                  const SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BuildWrapListComment(
              novelId: novelId,
              listComment: listComment,
              titleList: AppContents.comment,
              heightWrapList: 24.h,
              widthCard: 70.w,
              toDetail: () async {
                var result = await Get.toNamed(Routes.comment,
                    arguments: {"novelId": novelId});
                if (result != null) {
                  if (novelController != null) {
                    await novelController!.loadNovelDetails();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
