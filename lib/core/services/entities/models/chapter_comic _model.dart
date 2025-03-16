// ignore: file_names
class ChapterComicModel {
  String domain;
  String chapterPath;
  List<ChapterImage> chapterImages;

  ChapterComicModel({
    required this.domain,
    required this.chapterPath,
    required this.chapterImages,
  });

  factory ChapterComicModel.fromJson(Map<String, dynamic> json) {
    return ChapterComicModel(
      domain: json['domain_cdn'] as String,
      chapterPath: json['item']['chapter_path'] as String,
      chapterImages: (json['item']['chapter_image'] as List)
          .map((image) => ChapterImage.fromJson(image))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'domain_cdn': domain,
      'item': {
        'chapter_path': chapterPath,
        'chapter_image': chapterImages.map((image) => image.toJson()).toList(),
      },
    };
  }
}

class ChapterImage {
  String imageFile;

  ChapterImage({required this.imageFile});

  factory ChapterImage.fromJson(Map<String, dynamic> json) {
    return ChapterImage(
      imageFile: json['image_file'] as String,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'image_file': imageFile,
    };
  }
}
