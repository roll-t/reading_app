class ListComicModel {
  String titlePage;
  String domainImage;
  List<ItemModel> items;

  ListComicModel({
    required this.titlePage,
    required this.domainImage,
    required this.items,
  });

  factory ListComicModel.fromJson(Map<String, dynamic> json) {
    return ListComicModel(
      titlePage: json['titlePage'],
      domainImage: json['domainImage'],
      items: (json['items'] as List)
          .map((itemJson) => ItemModel.fromJson(itemJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titlePage': titlePage,
      'domainImage': domainImage,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class ItemModel {
  final String id;
  final String name;
  final String slug;
  final List<String> originName;
  final String status;
  final String thumbUrl;
  final bool subDocQuyen;
  final List<CategoryModel> category;
  final DateTime updatedAt;
  final List<ChapterListModel> chaptersLatest;

  ItemModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.originName,
    required this.status,
    required this.thumbUrl,
    required this.subDocQuyen,
    required this.category,
    required this.updatedAt,
    required this.chaptersLatest,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      originName: List<String>.from(json['origin_name']),
      status: json['status'],
      thumbUrl: json['thumb_url'],
      subDocQuyen: json['sub_docquyen'],
      category: (json['category'] as List)
          .map((categoryJson) => CategoryModel.fromJson(categoryJson))
          .toList(),
      updatedAt: DateTime.parse(json['updatedAt']),
      chaptersLatest: (json['chaptersLatest'] as List)
          .map((chapterJson) => ChapterListModel.fromJson(chapterJson))
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
      'sub_docquyen': subDocQuyen,
      'category': category.map((category) => category.toJson()).toList(),
      'updatedAt': updatedAt.toIso8601String(),
      'chaptersLatest':
          chaptersLatest.map((chapter) => chapter.toJson()).toList(),
    };
  }
}

class CategoryModel {
  final String id;
  final String slug;
  final String name;

  CategoryModel({
    required this.id,
    required this.slug,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
    };
  }
}

class ChapterListModel {
  final String filename;
  final String chapterName;
  final String chapterTitle;
  final String chapterApiData;

  ChapterListModel({
    required this.filename,
    required this.chapterName,
    required this.chapterTitle,
    required this.chapterApiData,
  });

  factory ChapterListModel.fromJson(Map<String, dynamic> json) {
    return ChapterListModel(
      filename: json['filename'],
      chapterName: json['chapter_name'],
      chapterTitle: json['chapter_title'] ?? "",
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
