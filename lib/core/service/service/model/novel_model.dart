class NovelModel {
  String? bookDataId;
  String name;
  String? slug;
  String? status;
  String thumbUrl;
  bool? subDocQuyen;
  List<String>? categorySlug;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  NovelModel({
    this.bookDataId,
    required this.name,
    this.slug,
    this.status,
    required this.thumbUrl,
    this.subDocQuyen,
    this.categorySlug,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  // From JSON
  factory NovelModel.fromJson(Map<String, dynamic> json) {
    return NovelModel(
      bookDataId: json['bookDataId'],
      name: json['name'],
      slug: json['slug'],
      status: json['status'],
      thumbUrl: json['thumbUrl'],
      subDocQuyen: json['subDocQuyen'],
      categorySlug: List<String>.from(json['categorySlug']),
      userId: json['userId'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'bookDataId': bookDataId,
      'name': name,
      'slug': slug,
      'status': status,
      'thumbUrl': thumbUrl,
      'subDocQuyen': subDocQuyen,
      'categorySlug': categorySlug,
      'userId': userId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
