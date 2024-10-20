class ReadingBookCaseResponse {
  final int id;
  final String bookDataId;
  final String uid;
  final String chapterName;
  final DateTime readingDate;
  final double positionReading;
  final BookData bookData;

  ReadingBookCaseResponse({
    required this.id,
    required this.bookDataId,
    required this.uid,
    required this.chapterName,
    required this.readingDate,
    required this.positionReading,
    required this.bookData,
  });

  factory ReadingBookCaseResponse.fromJson(Map<String, dynamic> json) {
    return ReadingBookCaseResponse(
      id: json["id"],
      bookDataId: json['bookDataId'],
      uid: json['uid'],
      chapterName: json['chapterName'],
      readingDate: DateTime.parse(json['readingDate']),
      positionReading: json['positionReading'].toDouble(),
      bookData: BookData.fromJson(json['bookData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'bookDataId': bookDataId,
      'uid': uid,
      'chapterName': chapterName,
      'readingDate': readingDate.toIso8601String(),
      'positionReading': positionReading,
      'bookData': bookData.toJson(),
    };
  }
}

class BookData {
  final String bookDataId;
  final String name;
  final String slug;
  final String status;
  final String thumbUrl;
  final bool subDocQuyen;
  final List<Category> category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  BookData({
    required this.bookDataId,
    required this.name,
    required this.slug,
    required this.status,
    required this.thumbUrl,
    required this.subDocQuyen,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory BookData.fromJson(Map<String, dynamic> json) {
    return BookData(
      bookDataId: json['bookDataId'],
      name: json['name'],
      slug: json['slug'],
      status: json['status'],
      thumbUrl: json['thumbUrl'],
      subDocQuyen: json['subDocQuyen'],
      category: (json['category'] as List)
          .map((item) => Category.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookDataId': bookDataId,
      'name': name,
      'slug': slug,
      'status': status,
      'thumbUrl': thumbUrl,
      'subDocQuyen': subDocQuyen,
      'category': category.map((item) => item.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'user': user.toJson(),
    };
  }
}

class Category {
  final int id;
  final String name;
  final String slug;

  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }
}

class User {
  final String uid;
  final String? displayName;
  final String email;
  final String password;
  final String? photoURL;
  final String? creationTime;
  final List<dynamic> roles;
  final List<dynamic> books;

  User({
    required this.uid,
    this.displayName,
    required this.email,
    required this.password,
    this.photoURL,
    this.creationTime,
    required this.roles,
    required this.books,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      password: json['password'],
      photoURL: json['photoURL'],
      creationTime: json['creationTime'],
      roles: json['roles'] ?? [],
      books: json['books'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'password': password,
      'photoURL': photoURL,
      'creationTime': creationTime,
      'roles': roles,
      'books': books,
    };
  }
}
