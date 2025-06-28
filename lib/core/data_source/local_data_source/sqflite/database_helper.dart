import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tick_note/core/data_source/local_data_source/sqflite/database_constances.dart';

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
    // Handle database schema upgrades here
    if (oldVersion < newVersion) {
      // Example: Add new columns or tables
      // await db.execute('ALTER TABLE $tableNotes ADD COLUMN new_column TEXT');
    }
  }

  // ==================== NOTES CRUD OPERATIONS ====================

  // Insert Note
  Future<int> insertNote(Map<String, dynamic> note) async {
    Database db = await database;
    return await db.insert(
      DatabaseConstances.tableNotes,
      note,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get All Notes
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    Database db = await database;
    return await db.query(
      DatabaseConstances.tableNotes,
      orderBy:
          '${DatabaseConstances.noteIsPinned} DESC, ${DatabaseConstances.noteDate} DESC',
    );
  }

  // Get Note by ID
  Future<Map<String, dynamic>?> getNoteById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      DatabaseConstances.tableNotes,
      where: '${DatabaseConstances.noteId} = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Get Pinned Notes
  Future<List<Map<String, dynamic>>> getPinnedNotes() async {
    Database db = await database;
    return await db.query(
      DatabaseConstances.tableNotes,
      where: '${DatabaseConstances.noteIsPinned} = ?',
      whereArgs: [1],
      orderBy: '${DatabaseConstances.noteDate} DESC',
    );
  }

  // Search Notes
  Future<List<Map<String, dynamic>>> searchNotes(String query) async {
    Database db = await database;
    return await db.query(
      DatabaseConstances.tableNotes,
      where:
          '${DatabaseConstances.noteTitle} LIKE ? OR ${DatabaseConstances.noteSubtitle} LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy:
          '${DatabaseConstances.noteIsPinned} DESC, ${DatabaseConstances.noteDate} DESC',
    );
  }

  // Update Note
  Future<int> updateNote(int id, Map<String, dynamic> note) async {
    Database db = await database;
    return await db.update(
      DatabaseConstances.tableNotes,
      note,
      where: '${DatabaseConstances.noteId} = ?',
      whereArgs: [id],
    );
  }

  // Toggle Pin Status
  Future<int> toggleNotePin(int id) async {
    Database db = await database;
    Map<String, dynamic>? currentNote = await getNoteById(id);
    if (currentNote != null) {
      int currentPinStatus =
          currentNote[DatabaseConstances.noteIsPinned] as int;
      return await db.update(
        DatabaseConstances.tableNotes,
        {DatabaseConstances.noteIsPinned: currentPinStatus == 1 ? 0 : 1},
        where: '${DatabaseConstances.noteId} = ?',
        whereArgs: [id],
      );
    }
    return 0;
  }

  // Delete Note
  Future<int> deleteNote(int id) async {
    Database db = await database;
    return await db.delete(
      DatabaseConstances.tableNotes,
      where: '${DatabaseConstances.noteId} = ?',
      whereArgs: [id],
    );
  }

  // Delete All Notes
  Future<int> deleteAllNotes() async {
    Database db = await database;
    return await db.delete(DatabaseConstances.tableNotes);
  }

  // Get Notes Count
  Future<int> getNotesCount() async {
    Database db = await database;
    return Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM ${DatabaseConstances.tableNotes}',
          ),
        ) ??
        0;
  }

  // ==================== TODO CRUD OPERATIONS ====================

  // Insert Todo
  Future<int> insertTodo(Map<String, dynamic> todo) async {
    Database db = await database;
    return await db.insert(
      DatabaseConstances.tableTodos,
      todo,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get All Todos
  Future<List<Map<String, dynamic>>> getAllTodos() async {
    Database db = await database;
    return await db.query(
      DatabaseConstances.tableTodos,
      orderBy:
          '${DatabaseConstances.todoIsCompleted} ASC, ${DatabaseConstances.todoCreatedAt} DESC',
    );
  }

  // Get Todo by ID
  Future<Map<String, dynamic>?> getTodoById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      DatabaseConstances.tableTodos,
      where: '${DatabaseConstances.todoId} = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Update Todo
  Future<int> updateTodo(int id, Map<String, dynamic> todo) async {
    Database db = await database;
    return await db.update(
      DatabaseConstances.tableTodos,
      todo,
      where: '${DatabaseConstances.todoId} = ?',
      whereArgs: [id],
    );
  }

  // Toggle Todo Completion
  Future<int> toggleTodoCompletion(int id) async {
    Database db = await database;
    Map<String, dynamic>? currentTodo = await getTodoById(id);
    if (currentTodo != null) {
      int currentStatus =
          currentTodo[DatabaseConstances.todoIsCompleted] as int;
      return await db.update(
        DatabaseConstances.tableTodos,
        {DatabaseConstances.todoIsCompleted: currentStatus == 1 ? 0 : 1},
        where: '${DatabaseConstances.todoId} = ?',
        whereArgs: [id],
      );
    }
    return 0;
  }

  // Delete Todo
  Future<int> deleteTodo(int id) async {
    Database db = await database;
    return await db.delete(
      DatabaseConstances.tableTodos,
      where: '${DatabaseConstances.todoId} = ?',
      whereArgs: [id],
    );
  }

  // Delete All Todos
  Future<int> deleteAllTodos() async {
    Database db = await database;
    return await db.delete(DatabaseConstances.tableTodos);
  }

  // ==================== UTILITY METHODS ====================

  // Close Database
  Future<void> close() async {
    Database db = await database;
    await db.close();
  }

  // Delete Database (for testing or reset)
  Future<void> deleteDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }

  // Backup Database (returns the database file path)
  Future<String> getDatabasePath() async {
    String databasesPath = await getDatabasesPath();
    return join(databasesPath, _databaseName);
  }

  // Get Database Size
  Future<int> getDatabaseSize() async {
    String path = await getDatabasePath();
    File dbFile = File(path);
    if (await dbFile.exists()) {
      return await dbFile.length();
    }
    return 0;
  }
}
