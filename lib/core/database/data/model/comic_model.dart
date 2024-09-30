class ComicModel {
  final String title;
  final String description;
  final String thumb;
  final List<dynamic>? chapters; // Use `List<dynamic>?` if the list can be null
  final List<dynamic>? category; // Use `List<dynamic>?` if the list can be null

  ComicModel({
    required this.title,
    required this.description,
    required this.thumb,
    this.chapters,
    this.category,
  });

  // Factory method to create a Comic instance from JSON
  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      title: json['title'] as String,
      description: json['description'] as String,
      thumb: json['thumb'] as String,
      chapters: json['chapters'] as List<dynamic>?,
      category: json['category'] as List<dynamic>?,
    );
  }

  // Method to convert a Comic instance to JSON
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
