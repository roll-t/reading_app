


class ListCategoryModel {
  final String id;
  final String slug;
  final String name;

  ListCategoryModel({
    required this.id,
    required this.slug,
    required this.name,
  });

  factory ListCategoryModel.fromJson(Map<String, dynamic> json) {
    return ListCategoryModel(
      id: json['_id'],
      slug: json['slug'],
      name: json['name'],
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