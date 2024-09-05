
class EndPointSetting {
  
   // Base URL of the API
  static const String _baseUrl = "http://10.0.2.2:8080/";

  static String comicDetailEndpoint({required String slug}) => "${_baseUrl}comic/detail/$slug";
  static String comicHomeEndpoint() => "${_baseUrl}comic/home";
  static String categoriesEndpoint() => "${_baseUrl}comic/categories";
  static String listByTypeEndpoint({required String slug,required int page}) => "${_baseUrl}comic/list/$slug?page=$page";
  static String categoriesBySlugEndpoint({required String slug,required int page}) => "${_baseUrl}comic/categories/$slug?page=$page";
  static String searchEndpoint() => "${_baseUrl}comic/search";
  static String searchBySlugEndpoint({required String slug,required int page}) => "${_baseUrl}comic/search/$slug?page=$page";
  static String get tokenEndpoint => "${_baseUrl}auth/token";

  // post method
  static String signInEndpoint()=> "${_baseUrl}users";
  
  static String getUserEndpoint({required String uid})=> "${_baseUrl}users/$uid";
  static String emailExistEndpoint({required String email})=> "${_baseUrl}users/email-exist/$email";

}