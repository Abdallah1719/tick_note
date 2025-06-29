import 'package:tick_note/core/storage/datebase/database_constances.dart';
import 'package:tick_note/core/storage/datebase/database_helper.dart';
import 'package:tick_note/features/todo/data/models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<int> insertTodo(TodoModel todo);
  Future<List<TodoModel>> getAllTodos();
  Future<TodoModel?> getTodoById(int id);
  Future<int> updateTodo(TodoModel todo);
  Future<int> deleteTodo(int id);
  Future<List<TodoModel>> getCompletedTodos();
  Future<List<TodoModel>> getPendingTodos();
  Future<List<TodoModel>> getTodosByDate(DateTime date);
  Future<List<TodoModel>> getOverdueTodos();
  Future<int> getTodosCount();
  Future<int> getCompletedTodosCount();
  Future<int> getPendingTodosCount();
  Future<int> clearAllTodos();
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final DatabaseHelper _databaseHelper;

  TodoLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<int> insertTodo(TodoModel todo) async {
    try {
      return await _databaseHelper.insert(
        tableName: DatabaseConstances.tableTodos,
        data: todo.toMap(),
      );
    } catch (e) {
      throw Exception('Failed to insert todo: $e');
    }
  }

  @override
  Future<List<TodoModel>> getAllTodos() async {
    try {
      final List<Map<String, dynamic>> maps = await _databaseHelper.query(
        tableName: DatabaseConstances.tableTodos,
        orderBy: '${DatabaseConstances.todoCreatedAt} DESC',
      );
      return maps.map((map) => TodoModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to get all todos: $e');
    }
  }

  @override
  Future<TodoModel?> getTodoById(int id) async {
    try {
      final Map<String, dynamic>? map = await _databaseHelper.getById(
        tableName: DatabaseConstances.tableTodos,
        idColumn: DatabaseConstances.todoId,
        id: id,
      );
      return map != null ? TodoModel.fromMap(map) : null;
    } catch (e) {
      throw Exception('Failed to get todo by id: $e');
    }
  }

  @override
  Future<int> updateTodo(TodoModel todo) async {
    try {
      return await _databaseHelper.update(
        tableName: DatabaseConstances.tableTodos,
        data: todo.toMap(),
        where: '${DatabaseConstances.todoId} = ?',
        whereArgs: [todo.id],
      );
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  @override
  Future<int> deleteTodo(int id) async {
    try {
      return await _databaseHelper.delete(
        tableName: DatabaseConstances.tableTodos,
        where: '${DatabaseConstances.todoId} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }

  @override
  Future<List<TodoModel>> getCompletedTodos() async {
    try {
      final List<Map<String, dynamic>> maps = await _databaseHelper.query(
        tableName: DatabaseConstances.tableTodos,
        where: '${DatabaseConstances.todoIsCompleted} = ?',
        whereArgs: [1],
        orderBy: '${DatabaseConstances.todoCreatedAt} DESC',
      );
      return maps.map((map) => TodoModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to get completed todos: $e');
    }
  }

  @override
  Future<List<TodoModel>> getPendingTodos() async {
    try {
      final List<Map<String, dynamic>> maps = await _databaseHelper.query(
        tableName: DatabaseConstances.tableTodos,
        where: '${DatabaseConstances.todoIsCompleted} = ?',
        whereArgs: [0],
        orderBy: '${DatabaseConstances.todoCreatedAt} DESC',
      );
      return maps.map((map) => TodoModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to get pending todos: $e');
    }
  }

  @override
  Future<List<TodoModel>> getTodosByDate(DateTime date) async {
    try {
      final String startDate = DateTime(date.year, date.month, date.day).toIso8601String();
      final String endDate = DateTime(date.year, date.month, date.day, 23, 59, 59).toIso8601String();
      
      final List<Map<String, dynamic>> maps = await _databaseHelper.query(
        tableName: DatabaseConstances.tableTodos,
        where: '${DatabaseConstances.todoCreatedAt} BETWEEN ? AND ?',
        whereArgs: [startDate, endDate],
        orderBy: '${DatabaseConstances.todoCreatedAt} DESC',
      );
      return maps.map((map) => TodoModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to get todos by date: $e');
    }
  }

  @override
  Future<List<TodoModel>> getOverdueTodos() async {
    try {
      final String currentDate = DateTime.now().toIso8601String();
      
      final List<Map<String, dynamic>> maps = await _databaseHelper.query(
        tableName: DatabaseConstances.tableTodos,
        where: '${DatabaseConstances.todoDueDate} < ? AND ${DatabaseConstances.todoIsCompleted} = ?',
        whereArgs: [currentDate, 0],
        orderBy: '${DatabaseConstances.todoDueDate} ASC',
      );
      return maps.map((map) => TodoModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to get overdue todos: $e');
    }
  }

  @override
  Future<int> getTodosCount() async {
    try {
      return await _databaseHelper.getCount(
        tableName: DatabaseConstances.tableTodos,
      );
    } catch (e) {
      throw Exception('Failed to get todos count: $e');
    }
  }

  @override
  Future<int> getCompletedTodosCount() async {
    try {
      return await _databaseHelper.getCount(
        tableName: DatabaseConstances.tableTodos,
        where: '${DatabaseConstances.todoIsCompleted} = ?',
        whereArgs: [1],
      );
    } catch (e) {
      throw Exception('Failed to get completed todos count: $e');
    }
  }

  @override
  Future<int> getPendingTodosCount() async {
    try {
      return await _databaseHelper.getCount(
        tableName: DatabaseConstances.tableTodos,
        where: '${DatabaseConstances.todoIsCompleted} = ?',
        whereArgs: [0],
      );
    } catch (e) {
      throw Exception('Failed to get pending todos count: $e');
    }
  }

  @override
  Future<int> clearAllTodos() async {
    try {
      return await _databaseHelper.clearTable(DatabaseConstances.tableTodos);
    } catch (e) {
      throw Exception('Failed to clear all todos: $e');
    }
  }
}