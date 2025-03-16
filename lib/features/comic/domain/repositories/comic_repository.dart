import 'package:reading_app/core/services/api/data/entities/models/comic_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';

abstract class ComicRepository {
  /// get the comic list of home page
  Future<ListComicModel?> fetchHomeData();

  /// get a list of comic completed
  Future<ComicModel?> fetchListComplete();

  /// get a list comic by status
  Future<ListComicModel?> fetchListByStatus(String status);

  /// get a list of comics by category slug
  Future<ListComicModel?> fetchComicsByCategorySlug(String slug);

  /// Lấy danh sách comics khi chuyển danh mục
  Future<ComicModel?> fetchComicsByChangeCategory(String slug);

  /// Lấy slug của danh mục dựa trên tên
  String? getSlugByCategoryTitle(String title);
}
