import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/database/data/model/chapter_novel_model.dart';
import 'package:reading_app/core/database/data/model/novel_model.dart';

class DefaultData {
  static NovelModel defaultNovel = NovelModel(
    bookDataId: "default-book-id",
    name: "Default Novel Name",
    slug: "default-novel-slug",
    status: "draft", // Hoặc có thể là "published", "in-progress", v.v.
    thumbUrl: AppImages.iNoImage,
    subDocQuyen: false,
    categorySlug: ["default-category-1", "default-category-2"],
    userId: "default-user-id",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  static ChapterNovelModel defaultChapter = ChapterNovelModel(
  chapterId: "default-chapter-id",
  chapterName: "Default Chapter Name",
  chapterTitle: "Default Chapter Title",
  chapterContent: "This is the default content of the chapter.",
  createAt: DateTime.now(),
  bookDataId: "default-book-id",
);
}
