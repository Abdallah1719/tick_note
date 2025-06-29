import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tick_note/core/storage/datebase/database_constances.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  // Database info
  static const String _databaseName = 'notes_todo_app.db';
  static const int _databaseVersion = 1;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create Notes table
    await db.execute('''
      CREATE TABLE ${DatabaseConstances.tableNotes} (
        ${DatabaseConstances.noteId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseConstances.noteTitle} TEXT NOT NULL,
        ${DatabaseConstances.noteSubtitle} TEXT,
        ${DatabaseConstances.noteDate} TEXT NOT NULL,
        ${DatabaseConstances.noteColor} INTEGER NOT NULL DEFAULT 0xFFFFFFFF,
        ${DatabaseConstances.noteIsPinned} INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // Create Todos table
    await db.execute('''
      CREATE TABLE ${DatabaseConstances.tableTodos} (
        ${DatabaseConstances.todoId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseConstances.todoTitle} TEXT NOT NULL,
        ${DatabaseConstances.todoDescription} TEXT,
        ${DatabaseConstances.todoIsCompleted} INTEGER NOT NULL DEFAULT 0,
        ${DatabaseConstances.todoCreatedAt} TEXT NOT NULL,
        ${DatabaseConstances.todoDueDate} TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Handle database schema upgrades here
    }
  }

  // ==================== GENERIC CRUD OPERATIONS ====================

  /// Generic Insert method
  Future<int> insert({
    required String tableName,
    required Map<String, dynamic> data,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    Database db = await database;
    return await db.insert(
      tableName,
      data,
      conflictAlgorithm: conflictAlgorithm ?? ConflictAlgorithm.replace,
    );
  }

  /// Generic Update method
  Future<int> update({
    required String tableName,
    required Map<String, dynamic> data,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    Database db = await database;
    return await db.update(tableName, data, where: where, whereArgs: whereArgs);
  }

  /// Generic Delete method
  Future<int> delete({
    required String tableName,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    Database db = await database;
    return await db.delete(tableName, where: where, whereArgs: whereArgs);
  }

  /// Generic Query method
  Future<List<Map<String, dynamic>>> query({
    required String tableName,
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    Database db = await database;
    return await db.query(
      tableName,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  /// Generic Raw Query method
  Future<List<Map<String, dynamic>>> rawQuery({
    required String sql,
    List<Object?>? arguments,
  }) async {
    Database db = await database;
    return await db.rawQuery(sql, arguments);
  }

  /// Generic Count method
  Future<int> getCount({
    required String tableName,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    Database db = await database;
    return Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM $tableName${where != null ? ' WHERE $where' : ''}',
            whereArgs,
          ),
        ) ??
        0;
  }

  /// Generic Get by ID method
  Future<Map<String, dynamic>?> getById({
    required String tableName,
    required String idColumn,
    required int id,
  }) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: '$idColumn = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  // ==================== UTILITY METHODS ====================

  /// Close Database
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  /// Delete Database (for testing or reset)
  Future<void> deleteDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }

  /// Get Database Path
  Future<String> getDatabasePath() async {
    String databasesPath = await getDatabasesPath();
    return join(databasesPath, _databaseName);
  }

  /// Get Database Size
  Future<int> getDatabaseSize() async {
    String path = await getDatabasePath();
    File dbFile = File(path);
    if (await dbFile.exists()) {
      return await dbFile.length();
    }
    return 0;
  }

  /// Clear all data from a table
  Future<int> clearTable(String tableName) async {
    Database db = await database;
    return await db.delete(tableName);
  }

  /// Check if table exists
  Future<bool> tableExists(String tableName) async {
    Database db = await database;
    var result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
    );
    return result.isNotEmpty;
  }
}
