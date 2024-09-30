import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/database/data/model/authentication_model.dart';
import 'package:reading_app/core/database/data/model/comic_model.dart';
import 'package:reading_app/core/database/data/model/list_category_model.dart';
import 'package:reading_app/core/database/data/model/list_comic_model.dart';
import 'package:reading_app/core/database/data/model/result.dart';

class ResponseApi {
  // trả về comic data
  static Result<ComicModel> handleResponseComic(int statusCode,
      {dynamic data}) {
    switch (statusCode) {
      case 200:
        if (data != null) {
          return Result.success(ComicModel.fromJson(data));
        } else {
          return Result.error(ApiError.serverError);
        }
      case 400:
        return Result.error(ApiError.badRequest);
      case 401:
        return Result.error(ApiError.unauthorized);
      case 404:
        return Result.error(ApiError.notFound);
      default:
        return Result.error(ApiError.serverError);
    }
  }

  static Result<List<ListCategoryModel>> handleResponseCategories(
      int statusCode,
      {dynamic data}) {
    switch (statusCode) {
      case 200:
        if (data != null) {
          try {
            if (data == null ||
                data["data"] == null ||
                data["data"]["items"] == null) {
              return Result.error(ApiError.serverError);
            }
            List<String> emptyCategory = [
              "adult",
              "action",
              "adventure",
              "comedy",
              "comic",
              "drama",
              "dam-my",
              "fantasy",
              "manhua",
              "manhwa",
              "mature",
              "mystery",
              "romance",
              "school-life",
              "shounen",
              "soft-yaoi",
              "soft-yuri",
              "supernatural",
              "truyen-mau",
              "webtoon",
            ];

            List<ListCategoryModel> categories = <ListCategoryModel>[];

            data["data"]["items"].forEach((value) {
              if (!emptyCategory.contains(value["slug"])) {
                categories.add(ListCategoryModel.fromJson(value));
              }
            });
            return Result.success(categories);
          } catch (e) {
            print(e);
          }
          return Result.error(ApiError.serverError);
        } else {
          return Result.error(ApiError.serverError);
        }
      case 400:
        return Result.error(ApiError.badRequest);
      case 401:
        return Result.error(ApiError.unauthorized);
      case 404:
        return Result.error(ApiError.notFound);
      default:
        return Result.error(ApiError.serverError);
    }
  }

  static Result<ListComicModel> handleResponseData(int statusCode,
      {dynamic data}) {
    if (statusCode == 200) {
      if (data == null ||
          data["data"] == null ||
          data["data"]["items"] == null) {
        return Result.error(ApiError.serverError);
      }
      try {
        String domainImage = data["data"]["APP_DOMAIN_CDN_IMAGE"] + "/uploads/comics/";
        String titlePage = data["data"]["titlePage"] ?? "";
        List<dynamic> listImage = data["data"]["items"];
        ListComicModel listDataModel = ListComicModel(
          domainImage: domainImage,
          titlePage: titlePage,
          items: listImage
              .map((comicJson) => ItemModel.fromJson(comicJson))
              .toList(),
        );
        return Result.success(listDataModel);
      } catch (e) {
        return Result.error(ApiError.badRequest);
      }
    }
    switch (statusCode) {
      case 400:
        return Result.error(ApiError.badRequest);
      case 401:
        return Result.error(ApiError.unauthorized);
      case 404:
        return Result.error(ApiError.notFound);
      default:
        return Result.error(ApiError.serverError);
    }
  }

  // trả về token authentication
  static Result<AuthenticationModel> handleResponseAUthentication(
      int statusCode,
      {dynamic data}) {
    switch (statusCode) {
      case 200:
        if (data != null) {
          return Result.success(AuthenticationModel.fromJson(data));
        } else {
          return Result.error(ApiError.serverError);
        }
      case 400:
        return Result.error(ApiError.badRequest);
      case 401:
        return Result.error(ApiError.unauthorized);
      case 404:
        return Result.error(ApiError.notFound);
      default:
        return Result.error(ApiError.serverError);
    }
  }
}
