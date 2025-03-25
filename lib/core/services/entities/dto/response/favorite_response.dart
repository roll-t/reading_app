class FavoriteResponse {
  final String id;
  final BookData bookData;
  final String userId;
  final DateTime favoriteDate;

  FavoriteResponse({
    required this.id,
    required this.bookData,
    required this.userId,
    required this.favoriteDate,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      id: json['id'],
      bookData: BookData.fromJson(json['bookData']),
      userId: json['userId'],
      favoriteDate: DateTime.parse(json['favoriteDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookData': bookData.toJson(),
      'userId': userId,
      'favoriteDate': favoriteDate.toIso8601String(),
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
  final String displayName;
  final String email;
  final String photoURL;
  final String creationTime;
  final List<Role> roles;
  final List<Book> books;

  User({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoURL,
    required this.creationTime,
    required this.roles,
    required this.books,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      photoURL: json['photoURL'],
      creationTime: json['creationTime'],
      roles:
          (json['roles'] as List).map((item) => Role.fromJson(item)).toList(),
      books:
          (json['books'] as List).map((item) => Book.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
      'creationTime': creationTime,
      'roles': roles.map((item) => item.toJson()).toList(),
      'books': books.map((item) => item.toJson()).toList(),
    };
  }
}

class Role {
  final String name;
  final String description;
  final List<Permission> permissions;

  Role({
    required this.name,
    required this.description,
    required this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      name: json['name'],
      description: json['description'],
      permissions: (json['permissions'] as List)
          .map((item) => Permission.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'permissions': permissions.map((item) => item.toJson()).toList(),
    };
  }
}

class Permission {
  final String name;
  final String description;

  Permission({
    required this.name,
    required this.description,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}

class Book {
  final String name;
  final String slug;

  Book({
    required this.name,
    required this.slug,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
    };
  }
}
