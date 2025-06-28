// import 'dart:async';
// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:tick_note/core/data_source/local_data_source/sqflite/database_constances.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   DatabaseHelper._internal();

//   static Database? _database;
//   // Database info
//   static const String _databaseName = 'notes_todo_app.db';
//   static const int _databaseVersion = 1;

//   Future<Database> get database async {
//     _database ??= await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     String databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, _databaseName);
//     return await openDatabase(
//       path,
//       version: _databaseVersion,
//       onCreate: _onCreate,
//       onUpgrade: _onUpgrade,
//     );
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     // Create Notes table
//     await db.execute('''
//   CREATE TABLE ${DatabaseConstances.tableNotes} (
//     ${DatabaseConstances.noteId} INTEGER PRIMARY KEY AUTOINCREMENT,
//     ${DatabaseConstances.noteTitle} TEXT NOT NULL,
//     ${DatabaseConstances.noteSubtitle} TEXT,
//     ${DatabaseConstances.noteDate} TEXT NOT NULL,
//     ${DatabaseConstances.noteColor} INTEGER NOT NULL DEFAULT 0xFFFFFFFF,
//     ${DatabaseConstances.noteIsPinned} INTEGER NOT NULL DEFAULT 0
//   )
// ''');

//     // Create Todos table
//     await db.execute('''
//       CREATE TABLE ${DatabaseConstances.tableTodos} (
//         ${DatabaseConstances.todoId} INTEGER PRIMARY KEY AUTOINCREMENT,
//         ${DatabaseConstances.todoTitle} TEXT NOT NULL,
//         ${DatabaseConstances.todoDescription} TEXT,
//         ${DatabaseConstances.todoIsCompleted} INTEGER NOT NULL DEFAULT 0,
//         ${DatabaseConstances.todoCreatedAt} TEXT NOT NULL,
//         ${DatabaseConstances.todoDueDate} TEXT
//       )
//     ''');
//     print('Database created with tables: ${DatabaseConstances.tableNotes}, ${DatabaseConstances.tableTodos}');
//   }

//   Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     // Handle database schema upgrades here
//     if (oldVersion < newVersion) {
//       // Example: Add new columns or tables
//       // await db.execute('ALTER TABLE $tableNotes ADD COLUMN new_column TEXT');
//     }
//   }

//   // ==================== NOTES CRUD OPERATIONS ====================

//   // Insert Note
//   Future<int> insertNote(Map<String, dynamic> note) async {
//     Database db = await database;
//     return await db.insert(
//       DatabaseConstances.tableNotes,
//       note,
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // Get All Notes
//   Future<List<Map<String, dynamic>>> getAllNotes() async {
//     Database db = await database;
//     return await db.query(
//       DatabaseConstances.tableNotes,
//       orderBy:
//           '${DatabaseConstances.noteIsPinned} DESC, ${DatabaseConstances.noteDate} DESC',
//     );
//   }

//   // Get Note by ID
//   Future<Map<String, dynamic>?> getNoteById(int id) async {
//     Database db = await database;
//     List<Map<String, dynamic>> result = await db.query(
//       DatabaseConstances.tableNotes,
//       where: '${DatabaseConstances.noteId} = ?',
//       whereArgs: [id],
//       limit: 1,
//     );
//     return result.isNotEmpty ? result.first : null;
//   }

//   // Get Pinned Notes
//   Future<List<Map<String, dynamic>>> getPinnedNotes() async {
//     Database db = await database;
//     return await db.query(
//       DatabaseConstances.tableNotes,
//       where: '${DatabaseConstances.noteIsPinned} = ?',
//       whereArgs: [1],
//       orderBy: '${DatabaseConstances.noteDate} DESC',
//     );
//   }

//   // Search Notes
//   Future<List<Map<String, dynamic>>> searchNotes(String query) async {
//     Database db = await database;
//     return await db.query(
//       DatabaseConstances.tableNotes,
//       where:
//           '${DatabaseConstances.noteTitle} LIKE ? OR ${DatabaseConstances.noteSubtitle} LIKE ?',
//       whereArgs: ['%$query%', '%$query%'],
//       orderBy:
//           '${DatabaseConstances.noteIsPinned} DESC, ${DatabaseConstances.noteDate} DESC',
//     );
//   }

//   // Update Note
//   Future<int> updateNote(int id, Map<String, dynamic> note) async {
//     Database db = await database;
//     return await db.update(
//       DatabaseConstances.tableNotes,
//       note,
//       where: '${DatabaseConstances.noteId} = ?',
//       whereArgs: [id],
//     );
//   }

//   // Toggle Pin Status
//   Future<int> toggleNotePin(int id) async {
//     Database db = await database;
//     Map<String, dynamic>? currentNote = await getNoteById(id);
//     if (currentNote != null) {
//       int currentPinStatus =
//           currentNote[DatabaseConstances.noteIsPinned] as int;
//       return await db.update(
//         DatabaseConstances.tableNotes,
//         {DatabaseConstances.noteIsPinned: currentPinStatus == 1 ? 0 : 1},
//         where: '${DatabaseConstances.noteId} = ?',
//         whereArgs: [id],
//       );
//     }
//     return 0;
//   }

//   // Delete Note
//   Future<int> deleteNote(int id) async {
//     Database db = await database;
//     return await db.delete(
//       DatabaseConstances.tableNotes,
//       where: '${DatabaseConstances.noteId} = ?',
//       whereArgs: [id],
//     );
//   }

//   // Delete All Notes
//   Future<int> deleteAllNotes() async {
//     Database db = await database;
//     return await db.delete(DatabaseConstances.tableNotes);
//   }

//   // Get Notes Count
//   Future<int> getNotesCount() async {
//     Database db = await database;
//     return Sqflite.firstIntValue(
//           await db.rawQuery(
//             'SELECT COUNT(*) FROM ${DatabaseConstances.tableNotes}',
//           ),
//         ) ??
//         0;
//   }

//   // ==================== TODO CRUD OPERATIONS ====================

//   // Insert Todo
//   Future<int> insertTodo(Map<String, dynamic> todo) async {
//     Database db = await database;
//     return await db.insert(
//       DatabaseConstances.tableTodos,
//       todo,
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // Get All Todos
//   Future<List<Map<String, dynamic>>> getAllTodos() async {
//     Database db = await database;
//     return await db.query(
//       DatabaseConstances.tableTodos,
//       orderBy:
//           '${DatabaseConstances.todoIsCompleted} ASC, ${DatabaseConstances.todoCreatedAt} DESC',
//     );
//   }

//   // Get Todo by ID
//   Future<Map<String, dynamic>?> getTodoById(int id) async {
//     Database db = await database;
//     List<Map<String, dynamic>> result = await db.query(
//       DatabaseConstances.tableTodos,
//       where: '${DatabaseConstances.todoId} = ?',
//       whereArgs: [id],
//       limit: 1,
//     );
//     return result.isNotEmpty ? result.first : null;
//   }

//   // Update Todo
//   Future<int> updateTodo(int id, Map<String, dynamic> todo) async {
//     Database db = await database;
//     return await db.update(
//       DatabaseConstances.tableTodos,
//       todo,
//       where: '${DatabaseConstances.todoId} = ?',
//       whereArgs: [id],
//     );
//   }

//   // Toggle Todo Completion
//   Future<int> toggleTodoCompletion(int id) async {
//     Database db = await database;
//     Map<String, dynamic>? currentTodo = await getTodoById(id);
//     if (currentTodo != null) {
//       int currentStatus =
//           currentTodo[DatabaseConstances.todoIsCompleted] as int;
//       return await db.update(
//         DatabaseConstances.tableTodos,
//         {DatabaseConstances.todoIsCompleted: currentStatus == 1 ? 0 : 1},
//         where: '${DatabaseConstances.todoId} = ?',
//         whereArgs: [id],
//       );
//     }
//     return 0;
//   }

//   // Delete Todo
//   Future<int> deleteTodo(int id) async {
//     Database db = await database;
//     return await db.delete(
//       DatabaseConstances.tableTodos,
//       where: '${DatabaseConstances.todoId} = ?',
//       whereArgs: [id],
//     );
//   }

//   // Delete All Todos
//   Future<int> deleteAllTodos() async {
//     Database db = await database;
//     return await db.delete(DatabaseConstances.tableTodos);
//   }

//   // ==================== UTILITY METHODS ====================

//   // Close Database
//   Future<void> close() async {
//     Database db = await database;
//     await db.close();
//   }

//   // Delete Database (for testing or reset)
//   Future<void> deleteDatabase() async {
//     String databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, _databaseName);
//     await databaseFactory.deleteDatabase(path);
//     _database = null;
//   }

//   // Backup Database (returns the database file path)
//   Future<String> getDatabasePath() async {
//     String databasesPath = await getDatabasesPath();
//     return join(databasesPath, _databaseName);
//   }

//   // Get Database Size
//   Future<int> getDatabaseSize() async {
//     String path = await getDatabasePath();
//     File dbFile = File(path);
//     if (await dbFile.exists()) {
//       return await dbFile.length();
//     }
//     return 0;
//   }
// }

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
    print(
      'Database created with tables: ${DatabaseConstances.tableNotes}, ${DatabaseConstances.tableTodos}',
    );
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
