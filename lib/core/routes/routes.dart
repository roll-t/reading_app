abstract class Routes {
  static const home = "/";
  static const splash = "/splash";
  static const notFound = "/404";
  static const main = "/main";

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
  static const explore = "/explore";
  static const categoryNovel = "/category/novel";

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
  static const searchComic = "/explore/searchComic";
  static const searchNovel = "/explore/searchNovels";
  // Login Request
  static const loginRequestSplash = "/auth/login-request-splash";
}
