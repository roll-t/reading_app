class CategoryResponse {
  final int id;         // ID của danh mục
  final String name;    // Tên danh mục
  final String slug;    // Slug của danh mục

  // Constructor
  CategoryResponse({
    required this.id,
    required this.name,
    required this.slug,
  });

  // Phương thức factory để tạo đối tượng CategoryResponse từ JSON
  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  // Phương thức để chuyển đổi CategoryResponse thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }
}
