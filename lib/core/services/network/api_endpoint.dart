import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPointSetting {
  
  static final String _baseUrl = dotenv.env['BASE_URL'] ?? '';

  static String _buildQuery(Map<String, dynamic> params) {
    return params.entries
        .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');
  }

  
  // Endpoint truyện tranh
  static String comicDetailEndpoint({required String slug}) =>
      "${_baseUrl}comic/detail/$slug";
  static String comicHomeEndpoint() => "${_baseUrl}comic/home";
  static String categoriesEndpoint() => "${_baseUrl}comic/categories";
  static String listByTypeEndpoint({required String slug, required int page}) =>
      "${_baseUrl}comic/list/$slug?${_buildQuery({'page': page})}";
  static String categoriesBySlugEndpoint({required String slug, required int page}) =>
      "${_baseUrl}comic/categories/$slug?${_buildQuery({'page': page})}";
  static String searchEndpoint() => "${_baseUrl}comic/search";
  static String searchBySlugEndpoint({required String slug, required int page}) =>
      "${_baseUrl}comic/search/$slug?${_buildQuery({'page': page})}";



  // Token và cấu hình auth
  static String get tokenEndpoint => "${_baseUrl}auth/token";
  static String introspect = "${_baseUrl}auth/introspect";



  // Upload ảnh
  static String uploadImage = "${_baseUrl}images/upload";
  static String deleteImage = "${_baseUrl}images/delete";



  // Bình luận
  static String getAllCommentByChapterId({required String chapterId}) =>
      '${_baseUrl}comment/chapter/$chapterId';




  // Tài khoản và người dùng
  static String signInEndpoint = "${_baseUrl}users";
  static String getUserEndpoint({required String uid}) =>
      "${_baseUrl}users/$uid";
  static String emailExistEndpoint({required String email}) =>
      "${_baseUrl}users/email-exist/$email";

  // Truyện và danh mục
  static String getListNovelEnpoint = "${_baseUrl}book-data";
  static String getNovelByIdEnpoint({required String id}) =>
      "${_baseUrl}book-data/$id";
  static String getListChapterOfBookEndpoint({required String slug}) =>
      "${_baseUrl}chapter/book/$slug";
  static String getNovelByCategoryAndStatus({
    required String categorySlug,
    required String status,
    int page = 0,
    int size = 20,
  }) =>
      "${_baseUrl}book-data/category/$categorySlug/status/$status?${_buildQuery({'page': page, 'size': size})}";




  // Quản lý tủ sách
  static String addReadingBookCase = "${_baseUrl}book-case";
  static String getReadingBookCaseWithId({required String uid}) =>
      "${_baseUrl}book-case/$uid";
  static String deleteBookCase({required String bcId}) =>
      "${_baseUrl}book-case/$bcId";



  // Trạng thái và tìm kiếm
  static String getNovelByStatus({required String statusName}) =>
      "${_baseUrl}book-data/status/$statusName";
  static String searchNovelByNameOrSlug({required String text}) =>
      "${_baseUrl}book-data/search/$text";
  static String getNovelByCategory({required String categoryName}) =>
      "${_baseUrl}book-data/category/$categoryName";
  static String getNovelByListSlug({required List<String> listSlug}) {
    String slugsQuery = listSlug.map((slug) => "slugs=$slug").join("&");
    return "${_baseUrl}book-data/slugs?$slugsQuery";
  }

  // Danh mục
  static String getAllCategory = "${_baseUrl}category";

  // Bình luận
  static String addComment({required String bookId}) =>
      "${_baseUrl}comment/$bookId/create";
  static String addCommentComic = "${_baseUrl}comic/comments/create";
  static String getAllCommentByBookId({required String bookId}) =>
      "${_baseUrl}comment/$bookId";
  static String getAllCommentComicByBookId({required String bookId}) =>
      "${_baseUrl}comic/comments/all/$bookId";
  static String deleteComment({required String cmId}) =>
      "${_baseUrl}comment/$cmId";
  static String deleteCommentComic({required String cmId}) =>
      "${_baseUrl}comic/comments/$cmId";




  // Quản lý yêu thích
  static String unlikeBook({required String bookDataId, required String userId}) =>
      '${_baseUrl}book-case/favorite/$bookDataId/$userId';
  static String getAllFavoriteBooks({required String userId}) =>
      '${_baseUrl}book-case/favorites/$userId';
  static String checkIfBookLiked({required String bookDataId, required String userId}) =>
      '${_baseUrl}book-case/favorite/$bookDataId/$userId';
  static String likeBook = '${_baseUrl}book-case/favorite';
}
