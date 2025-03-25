class CategoryArgumentModel {
  String? slug;
  CategoryArgumentModel({this.slug});
  factory CategoryArgumentModel.fromJson(Map<String, dynamic> json) {
    return CategoryArgumentModel(
      slug: json['slugQuery'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slugQuery': slug,
    };
  }
}
