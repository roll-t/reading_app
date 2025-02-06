class CategoryModel {
  String? id;
  final String slug;
  final String name;

  CategoryModel({
    this.id,
    required this.slug,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? json['id'],
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'slug': slug,
      'name': name,
    };
  }
}
