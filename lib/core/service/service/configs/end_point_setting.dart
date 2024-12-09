class EndPointSetting {
  // Base URL of the API
  static const String _baseUrl = "http://14.225.218.46:8080/";



  
  static String comicDetailEndpoint({required String slug}) =>
      "${_baseUrl}comic/detail/$slug";
  static String comicHomeEndpoint() => "${_baseUrl}comic/home";
  static String categoriesEndpoint() => "${_baseUrl}comic/categories";
  static String listByTypeEndpoint({required String slug, required int page}) =>
      "${_baseUrl}comic/list/$slug?page=$page";
  static String categoriesBySlugEndpoint(
          {required String slug, required int page}) =>
      "${_baseUrl}comic/categories/$slug?page=$page";
  static String searchEndpoint() => "${_baseUrl}comic/search";
  static String searchBySlugEndpoint(
          {required String slug, required int page}) =>
      "${_baseUrl}comic/search/$slug?page=$page";

  static String get tokenEndpoint => "${_baseUrl}auth/token";

  static String introspect = "${_baseUrl}auth/introspect";

  static String uploadImage = "${_baseUrl}images/upload";

  static String getAllCommentByChapterId({required String chapterId}) =>
      '${_baseUrl}comment/chapter/$chapterId';

  // configs auth end point
  static String signInEndpoint = "${_baseUrl}users";
  static String getUserEndpoint({required String uid}) =>
      "${_baseUrl}users/$uid";
  static String emailExistEndpoint({required String email}) =>
      "${_baseUrl}users/email-exist/$email";

  // configs novel end point
  static String getListNovelEnpoint = "${_baseUrl}book-data";
  static String getNovelByIdEnpoint({required String id}) =>
      "${_baseUrl}book-data/$id";

  // chapter endpoint
  static String getListChapterOfBookEndpoint({required String slug}) =>
      "${_baseUrl}chapter/book/$slug";

  static String getNovelByCategoryAndStatus(
          {required String categorySlug,
          required String status,
          int page = 0,
          int size = 20}) =>
      "${_baseUrl}book-data/category/$categorySlug/status/$status?page=$page&size=$size";

  //bookcase Endpoint
  static String addReadingBookCase = "${_baseUrl}book-case";
  static String getReadingBookCaseWithId({required String uid}) =>
      "${_baseUrl}book-case/$uid";

  static String deleteBookCase({required String bcId}) =>
      "${_baseUrl}book-case/$bcId";

  static String getNovelByStatus({required String statusName}) =>
      "${_baseUrl}book-data/status/$statusName";

  static String searchNovelByNameOrSlug({required String text}) =>
      "${_baseUrl}book-data/search/$text";

  static String getNovelByCategory({required String categoryName}) =>
      "${_baseUrl}book-data/category/$categoryName";

  // lấy danh sách truyện dự trên danh sách slug
  static String getNovelByListSlug({required List<String> listSlug}) {
    String slugsQuery = listSlug.map((slug) => "slugs=$slug").join("&");
    return "${_baseUrl}book-data/slugs?$slugsQuery";
  }

  // category
  static String getAllCategory = "${_baseUrl}category";

  // comment
  static String addComment({required String bookId}) =>
      "${_baseUrl}comment/$bookId/create";
  // comment
  static String addCommentComic = "${_baseUrl}comic/comments/create";

  static String getAllCommentByBookId({required String bookId}) =>
      "${_baseUrl}comment/$bookId";

  static String getAllCommentComicByBookId({required String bookId}) =>
      "${_baseUrl}comic/comments/all/$bookId";

  static String deleteComment({required String cmId}) =>
      "${_baseUrl}comment/$cmId";

  static String deleteCommentComic({required String cmId}) =>
      "${_baseUrl}comic/comments/$cmId";

  // Endpoint to unlike a book
  static String unlikeBook(
          {required String bookDataId, required String userId}) =>
      '${_baseUrl}book-case/favorite/$bookDataId/$userId';

  // Endpoint to get all favorite books of a user
  static String getAllFavoriteBooks({required String userId}) =>
      '${_baseUrl}book-case/favorites/$userId';

  // Endpoint to check if a book is liked by a user
  static String checkIfBookLiked(
          {required String bookDataId, required String userId}) =>
      '${_baseUrl}book-case/favorite/$bookDataId/$userId';
  // Endpoint to like a book
  static String likeBook = '${_baseUrl}book-case/favorite';
}
