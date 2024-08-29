
class HomeModel {
  String titleHead;
  String descriptionHead;
  String ogType;
  List<String> ogImage;

  HomeModel({
    required this.titleHead,
    required this.descriptionHead,
    required this.ogType,
    required this.ogImage,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      titleHead: json['titleHead'],
      descriptionHead: json['descriptionHead'],
      ogType: json['og_type'],
      ogImage: List<String>.from(json['og_image']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titleHead': titleHead,
      'descriptionHead': descriptionHead,
      'og_type': ogType,
      'og_image': ogImage,
    };
  }
}

class Category {
  String id;
  String name;
  String slug;

  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }
}

class Chapter {
  String filename;
  String chapterName;
  String chapterTitle;
  String chapterApiData;

  Chapter({
    required this.filename,
    required this.chapterName,
    required this.chapterTitle,
    required this.chapterApiData,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      filename: json['filename'],
      chapterName: json['chapter_name'],
      chapterTitle: json['chapter_title'] ?? '',
      chapterApiData: json['chapter_api_data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
      'chapter_name': chapterName,
      'chapter_title': chapterTitle,
      'chapter_api_data': chapterApiData,
    };
  }
}

class Item {
  String id;
  String name;
  String slug;
  List<String> originName;
  String status;
  String thumbUrl;
  bool subDocquyen;
  List<Category> category;
  String updatedAt;
  List<Chapter> chaptersLatest;

  Item({
    required this.id,
    required this.name,
    required this.slug,
    required this.originName,
    required this.status,
    required this.thumbUrl,
    required this.subDocquyen,
    required this.category,
    required this.updatedAt,
    required this.chaptersLatest,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      originName: List<String>.from(json['origin_name']),
      status: json['status'],
      thumbUrl: json['thumb_url'],
      subDocquyen: json['sub_docquyen'],
      category: (json['category'] as List)
          .map((item) => Category.fromJson(item))
          .toList(),
      updatedAt: json['updatedAt'],
      chaptersLatest: (json['chaptersLatest'] as List)
          .map((item) => Chapter.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
      'origin_name': originName,
      'status': status,
      'thumb_url': thumbUrl,
      'sub_docquyen': subDocquyen,
      'category': category.map((item) => item.toJson()).toList(),
      'updatedAt': updatedAt,
      'chaptersLatest': chaptersLatest.map((item) => item.toJson()).toList(),
    };
  }
}

class ApiResponse {
  String status;
  String message;
  HomeModel seoOnPage;
  List<Item> items;

  ApiResponse({
    required this.status,
    required this.message,
    required this.seoOnPage,
    required this.items,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      message: json['message'] ?? '',
      seoOnPage: HomeModel.fromJson(json['seoOnPage']),
      items: (json['items'] as List).map((item) => Item.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'seoOnPage': seoOnPage.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
