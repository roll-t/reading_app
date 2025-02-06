class ComicDetailArguments {
  final String? comicId;
  final String? slug;

  ComicDetailArguments({this.comicId, this.slug});

  factory ComicDetailArguments.fromMap(Map<String, dynamic> map) {
    return ComicDetailArguments(
      comicId: map["comicId"] as String?,
      slug: map["slug"] as String?,
    );
  }
}
