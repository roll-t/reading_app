class EndPointSetting {
  // Base URL of the API
  static const String _baseUrl = "http://10.0.2.2:8080/";

  // configs end point
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

  // configs auth end point
  static String signInEndpoint() => "${_baseUrl}users";
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

  static String getAllCommentByBookId({required String bookId}) =>
      "${_baseUrl}comment/$bookId";

  static String deleteComment({required String cmId}) =>
      "${_baseUrl}comment/$cmId";
}
