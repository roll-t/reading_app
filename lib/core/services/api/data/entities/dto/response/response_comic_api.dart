import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/services/api/data/entities/models/authentication_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/category_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/list_comic_model.dart';
import 'package:reading_app/core/services/api/data/entities/models/result.dart';

class ResponseComicApi {
  static Result<T> handleResponse<T>(int statusCode,
      {dynamic data, T Function(dynamic)? parse}) {
    if (data == null) {
      return Result.error(ApiError.serverError);
    }
    switch (statusCode) {
      case 200:
        return Result.success(parse != null ? parse(data) : data);
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

  static Result<List<CategoryModel>> handleResponseCategories(int statusCode,
      {dynamic data}) {
    return handleResponse(statusCode, data: data, parse: (data) {
      try {
        if (data["data"] == null || data["data"]["items"] == null) {
          return [];
        }

        List<String> emptyCategory = ["adventure"];
        List<CategoryModel> categories = [];

        for (var value in data["data"]["items"]) {
          if (!emptyCategory.contains(value["slug"])) {
            categories.add(CategoryModel.fromJson(value));
          }
        }
        return categories;
      } catch (e) {
        return [];
      }
    });
  }

  // Handle response for list of comics
  static Result<ListComicModel> handleResponseData(int statusCode,
      {dynamic data}) {
    return handleResponse(statusCode, data: data, parse: (data) {
      if (data["data"] != null) {
        return _parseListComicData(data["data"]);
      } else {
        throw ApiError.serverError;
      }
    });
  }

  static ListComicModel _parseListComicData(dynamic data) {
    try {
      String domainImage = data["APP_DOMAIN_CDN_IMAGE"] ?? "";
      String titlePage = data["titlePage"] ?? "";
      List<dynamic> listImage = data["items"] ?? [];
      List<Map<String, dynamic>> listImageMap =
          listImage.cast<Map<String, dynamic>>();
          
      return ListComicModel(
        domainImage: domainImage,
        titlePage: titlePage,
        items: listImageMap.map((comicJson) {
          return ItemModel(
            id: comicJson["_id"] ?? "",
            name: comicJson["name"] ?? "",
            slug: comicJson["slug"] ?? "",
            originName: comicJson["originName"] ?? [],
            status: comicJson["status"] ?? "Unknown",
            thumbUrl: comicJson["thumb_url"] ?? "",
            subDocQuyen: comicJson["sub_docquyen"] ?? false,
            category: (comicJson["category"] as List<dynamic>?)
                    ?.map(
                        (categoryJson) => CategoryModel.fromJson(categoryJson))
                    .toList() ??
                [],
            updatedAt: DateTime.now(),
            chaptersLatest: [],
          );
        }).toList(),
      );
    } catch (e) {
      throw ApiError.serverError;
    }
  }

  static Result<AuthenticationModel> handleResponseAuthentication(
      int statusCode,
      {dynamic data}) {
    return handleResponse(statusCode, data: data, parse: (data) {
      if (data["data"] != null) {
        return AuthenticationModel.fromJson(data["data"]);
      } else {
        throw ApiError.serverError;
      }
    });
  }
}
