class ApiResponse {
  final String status;
  final String message;
  final ApiData data;

  ApiResponse({required this.status, required this.message, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      message: json['message'],
      data: ApiData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ApiData {
  final SeoOnPage seoOnPage;
  final List<Breadcrumb> breadCrumb;
  final String titlePage;
  final List<Item> items;

  ApiData({
    required this.seoOnPage,
    required this.breadCrumb,
    required this.titlePage,
    required this.items,
  });

  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      seoOnPage: SeoOnPage.fromJson(json['seoOnPage']),
      breadCrumb: (json['breadCrumb'] as List)
          .map((i) => Breadcrumb.fromJson(i))
          .toList(),
      titlePage: json['titlePage'],
      items: (json['items'] as List)
          .map((i) => Item.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seoOnPage': seoOnPage.toJson(),
      'breadCrumb': breadCrumb.map((i) => i.toJson()).toList(),
      'titlePage': titlePage,
      'items': items.map((i) => i.toJson()).toList(),
    };
  }
}

class SeoOnPage {
  final String ogType;
  final String titleHead;
  final String descriptionHead;
  final List<String> ogImage;
  final String ogUrl;

  SeoOnPage({
    required this.ogType,
    required this.titleHead,
    required this.descriptionHead,
    required this.ogImage,
    required this.ogUrl,
  });

  factory SeoOnPage.fromJson(Map<String, dynamic> json) {
    return SeoOnPage(
      ogType: json['og_type'],
      titleHead: json['titleHead'],
      descriptionHead: json['descriptionHead'],
      ogImage: List<String>.from(json['og_image']),
      ogUrl: json['og_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'og_type': ogType,
      'titleHead': titleHead,
      'descriptionHead': descriptionHead,
      'og_image': ogImage,
      'og_url': ogUrl,
    };
  }
}

class Breadcrumb {
  final String name;
  final String slug;
  final bool isCurrent;
  final int position;

  Breadcrumb({
    required this.name,
    required this.slug,
    required this.isCurrent,
    required this.position,
  });

  factory Breadcrumb.fromJson(Map<String, dynamic> json) {
    return Breadcrumb(
      name: json['name'],
      slug: json['slug'],
      isCurrent: json['isCurrent'],
      position: json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
      'isCurrent': isCurrent,
      'position': position,
    };
  }
}

class Item {
  final String id;
  final String name;
  final String slug;
  final List<String> originName;
  final String status;
  final String thumbUrl;
  final bool subDocquyen;
  final List<Category> category;
  final String updatedAt;
  final List<Chapter> chaptersLatest;

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
          .map((i) => Category.fromJson(i))
          .toList(),
      updatedAt: json['updatedAt'],
      chaptersLatest: (json['chaptersLatest'] as List)
          .map((i) => Chapter.fromJson(i))
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
      'category': category.map((i) => i.toJson()).toList(),
      'updatedAt': updatedAt,
      'chaptersLatest': chaptersLatest.map((i) => i.toJson()).toList(),
    };
  }
}

class Category {
  final String id;
  final String name;
  final String slug;

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
  final String filename;
  final String chapterName;
  final String chapterTitle;
  final String chapterApiData;

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
      chapterTitle: json['chapter_title'],
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
