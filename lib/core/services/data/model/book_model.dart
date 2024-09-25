class BookModel {
  final String bid;
  final String title;
  final String imageUrl;
  final String? subtitle;
  final String? description;

  BookModel({
    required this.bid,
    required this.title,
    required this.imageUrl,
    this.subtitle,
    this.description
  });

  // Phương thức từ JSON
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      bid: json['bid'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      subtitle: json['subtitle'],
      description: json['description'],
    );
  }

  // Phương thức sang JSON
  Map<String, dynamic> toJson() {
    return {
      'bid': bid,
      'title': title,
      'imageUrl': imageUrl,
      'subtitle': subtitle,
      'description': description,
    };
  }
}
