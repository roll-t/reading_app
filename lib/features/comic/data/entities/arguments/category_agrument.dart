class CategoryArgument {
  String? slug;
  CategoryArgument({this.slug});
  factory CategoryArgument.fromJson(Map<String, dynamic> json) {
    return CategoryArgument(
      slug: json['slugQuery'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slugQuery': slug,
    };
  }
}
