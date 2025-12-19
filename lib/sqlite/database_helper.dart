import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/user_model.dart';
import '../models/notes_model.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper _instance = DatabaseHelper._createInstance();

  // Single database instance
  static Database? _database;

  // Table and column names
  final String userTable = 'user_table';
  final String colId = 'id';
  final String colEmail = 'email';
  final String colPassword = 'password';
  final String colName = 'name';

  final String notesTable = 'notes_table';
  final String colNoteId = 'id';
  final String colNoteUserId = 'user_id';
  final String colNoteTitle = 'title';
  final String colNoteContent = 'content';
  final String colNoteColorHex = 'color_hex';
  final String colNoteCreatedAt = 'created_at';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'noteale.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDb,
      onUpgrade: _onUpgrade,
    );
  }

  FutureOr<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $userTable(
        $colId TEXT PRIMARY KEY,
        $colName TEXT NOT NULL,
        $colEmail TEXT NOT NULL,
        $colPassword TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $notesTable(
        $colNoteId TEXT PRIMARY KEY,
        $colNoteUserId TEXT NOT NULL,
        $colNoteTitle TEXT NOT NULL,
        $colNoteContent TEXT NOT NULL,
        $colNoteColorHex TEXT NOT NULL,
        $colNoteCreatedAt INTEGER NOT NULL,
        FOREIGN KEY($colNoteUserId) REFERENCES $userTable($colId)
      )
    ''');
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $notesTable(
          $colNoteId TEXT PRIMARY KEY,
          $colNoteUserId TEXT NOT NULL,
          $colNoteTitle TEXT NOT NULL,
          $colNoteContent TEXT NOT NULL,
          $colNoteColorHex TEXT NOT NULL,
          $colNoteCreatedAt INTEGER NOT NULL,
          FOREIGN KEY($colNoteUserId) REFERENCES $userTable($colId)
        )
      ''');
    }
  }

  Future<int> insertUser(UserModel user) async {
    final db = await database;
    return await db.insert(
      userTable,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await database;
    final maps = await db.query(
      userTable,
      where: '$colEmail = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<UserModel?> getUserById(String id) async {
    final db = await database;
    final maps = await db.query(
      userTable,
      where: '$colId = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateUser(UserModel user) async {
    final db = await database;
    return await db.update(
      userTable,
      user.toMap(),
      where: '$colId = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(String id) async {
    final db = await database;
    return await db.delete(userTable, where: '$colId = ?', whereArgs: [id]);
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await database;
    final result = await db.query(userTable);
    return result.map((m) => UserModel.fromMap(m)).toList();
  }

  Future<int> getUserCount() async {
    final db = await database;
    final x = await db.rawQuery('SELECT COUNT (*) from $userTable');
    return Sqflite.firstIntValue(x) ?? 0;
  }

  // Notes CRUD
  Future<int> insertNote(NotesModel note) async {
    final db = await database;
    return await db.insert(
      notesTable,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NotesModel>> getNotesForUser(String userId) async {
    final db = await database;
    final result = await db.query(
      notesTable,
      where: '$colNoteUserId = ?',
      whereArgs: [userId],
      orderBy: '$colNoteCreatedAt DESC',
    );
    return result.map((m) => NotesModel.fromMap(m)).toList();
  }

  Future<int> updateNote(NotesModel note) async {
    final db = await database;
    return await db.update(
      notesTable,
      note.toMap(),
      where: '$colNoteId = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(String id) async {
    final db = await database;
    return await db.delete(
      notesTable,
      where: '$colNoteId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteNotesForUser(String userId) async {
    final db = await database;
    return await db.delete(
      notesTable,
      where: '$colNoteUserId = ?',
      whereArgs: [userId],
    );
  }
}
