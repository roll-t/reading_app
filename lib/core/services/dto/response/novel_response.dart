class NovelResponse {
  String? novelId;
  String? name;
  String? slug;
  String? status;
  String? thumbUrl;
  bool? subDocQuyen;
  List<String>? categorySlug;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  NovelResponse({
    this.novelId,
    this.name,
    this.slug,
    this.status,
    this.thumbUrl,
    this.subDocQuyen,
    this.categorySlug,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  // From JSON
  factory NovelResponse.fromJson(Map<String, dynamic> json) {
    return NovelResponse(
      novelId: json['novelId'],
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
      'novelId': novelId,
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
