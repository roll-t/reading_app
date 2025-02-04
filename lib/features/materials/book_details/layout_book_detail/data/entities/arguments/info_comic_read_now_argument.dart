class InfoComicReadNowArgumentModel {
  final String slug;
  final String title;
  final String thumb;

  InfoComicReadNowArgumentModel({
    required this.slug,
    required this.title,
    required this.thumb,
  });

  factory InfoComicReadNowArgumentModel.fromJson(Map<String, dynamic> json) {
    return InfoComicReadNowArgumentModel(
      slug: json['slug'] as String,
      title: json['title'] as String,
      thumb: json['thumb'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'title': title,
      'thumb': thumb,
    };
  }
}
