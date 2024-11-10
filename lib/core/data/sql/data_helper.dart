import 'package:path/path.dart';
import 'package:reading_app/core/data/database/model/reading_book_case_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'bookara.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE readingComicBookCase (
        id TEXT,
        bookDataId TEXT,
        slug TEXT,
        uid TEXT,
        chapterName TEXT,
        chapterApiData TEXT,
        readingDate TEXT,  -- Lưu ngày dưới dạng chuỗi
        positionReading REAL,
        thumbUrl TEXT,
        comicName TEXT
      )
    ''');
    // Create any other tables here
    await db.execute('''
      CREATE TABLE book (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER
      )
    ''');
  }

  // On upgrade method to handle schema changes
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // If upgrading from version 1 to 2, add the 'slug' column
      await db.execute(
          '''ALTER TABLE readingComicBookCase ADD COLUMN slug TEXT;''');
    }
    if (oldVersion < 3) {}
  }

  Future<int> insertReadingComic(ReadingComicBookCaseModel comic) async {
    final db = await database;

    // Check if a record with the same slug already exists
    List<Map<String, dynamic>> existingComics = await db.query(
      'readingComicBookCase',
      where: 'slug = ?',
      whereArgs: [comic.slug],
    );

    if (existingComics.isEmpty) {
      // If no record exists, insert the new comic
      return await db.insert('readingComicBookCase', comic.toJson());
    } else {
      // If record exists, update the existing comic using the slug
      return await db.update(
        'readingComicBookCase',
        comic.toJson(),
        where: 'slug = ?',
        whereArgs: [comic.slug], // Using comic.slug directly
      );
    }
  }

  Future<List<ReadingComicBookCaseModel>> getReadingComicBookCases() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('readingComicBookCase');
    return List.generate(maps.length, (i) {
      return ReadingComicBookCaseModel.fromMap(maps[i]);
    });
  }
  
  Future<int> updateReadingComicBookCase(
      int id, ReadingComicBookCaseModel comic) async {
    final db = await database;
    return await db.update(
      'readingComicBookCase',
      comic.toJson(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ReadingComicBookCaseModel>> getReadingComicBookCasesByUid(
      String uid) async {
    final db = await database;
    // Query the database filtering by `uid`
    List<Map<String, dynamic>> maps = await db.query(
      'readingComicBookCase',
      where: 'uid = ?',
      whereArgs: [uid],
      orderBy: 'readingDate DESC',
    );

    return List.generate(maps.length, (i) {
      return ReadingComicBookCaseModel.fromMap(maps[i]);
    });
  }

  // Delete ReadingComicBookCaseModel from the database
  Future<int> deleteReadingComicBookCase(
      ReadingComicBookCaseModel comic) async {
    final db = await database;
    return await db.delete(
      'readingComicBookCase',
      where: 'slug = ?',
      whereArgs: [comic.slug],
    );
  }

  // Clear all data from the tables
  Future<void> clearAllTables() async {
    final db = await database;
    await db.execute('DELETE FROM readingComicBookCase');
    await db.execute('DELETE FROM book');
  }

  Future<void> deleteDatabaseFile() async {
    String path = join(await getDatabasesPath(), 'bookara.db');
    await deleteDatabase(path);
    print("Database deleted");
  }
}
