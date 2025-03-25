class ComicModel {
  final String title;
  final String description;
  final String thumb;
  final List<dynamic>? chapters;
  final List<dynamic>? category;

  ComicModel({
    required this.title,
    required this.description,
    required this.thumb,
    this.chapters,
    this.category,
  });

  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      title: json['title'] as String,
      description: json['description'] as String,
      thumb: json['thumb'] as String,
      chapters: json['chapters'] as List<dynamic>?,
      category: json['category'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'thumb': thumb,
      'chapters': chapters,
      'category': category,
    };
  }
}
