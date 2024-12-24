abstract class Routes {
  static const home = "/"; // Trang chính
  static const splash = "/splash"; // Màn hình khởi động
  static const notFound = "/404"; // Trang không tìm thấy
  static const main = "/main"; // Trang chính sau khi đăng nhập

  // Authentication
  static const login = "/auth/login";
  static const register = "/auth/register";
  static const emailVerification = "/auth/email-verification";
  static const forgotPassword = "/auth/forgot-password";

  // Profile
  static const profile = "/profile";
  static const myInfo = "/profile/my-info";

  // Categories & Search
  static const category = "/category";
  static const search = "/search";
  static const categoryNovel = "/category/novel";
  static const findNovel = "/search/novels";

  // Notifications
  static const notification = "/notifications";

  // Books
  static const bookDetail = "/book/detail";
  static const readBook = "/book/read";

  // Novels
  static const novelDetail = "/novel/detail";
  static const readNovel = "/novel/read";

  // Comics
  static const comicDetail = "/comic/detail";

  // Comments
  static const comment = "/comments";

  // Find (general search page)
  static const find = "/find";

  // Login Request
  static const loginRequestSplash = "/auth/login-request-splash";
}
