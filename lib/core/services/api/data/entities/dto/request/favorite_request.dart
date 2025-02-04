class FavoriteRequest {
  final String bookDataId;
  final String userId;

  FavoriteRequest({required this.bookDataId, required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'bookDataId': bookDataId,
      'userId': userId,
    };
  }
}
