import 'package:dartz/dartz.dart';
import 'package:tick_note/core/error/failure.dart';
import 'package:tick_note/features/todo/data/data_source/todo_local_data_source.dart';
import 'package:tick_note/features/todo/data/models/todo_model.dart';
import 'package:tick_note/features/todo/domain/entities/todo_entity.dart';
import 'package:tick_note/features/todo/domain/repository/todo_repo.dart';


class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource _localDataSource;

  TodoRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, int>> insertTodo(TodoEntity todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      final result = await _localDataSource.insertTodo(todoModel);
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getAllTodos() async {
    try {
      final result = await _localDataSource.getAllTodos();
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TodoEntity?>> getTodoById(int id) async {
    try {
      final result = await _localDataSource.getTodoById(id);
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> updateTodo(TodoEntity todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      final result = await _localDataSource.updateTodo(todoModel);
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteTodo(int id) async {
    try {
      final result = await _localDataSource.deleteTodo(id);
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getCompletedTodos() async {
    try {
      final result = await _localDataSource.getCompletedTodos();
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getPendingTodos() async {
    try {
      final result = await _localDataSource.getPendingTodos();
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getTodosByDate(DateTime date) async {
    try {
      final result = await _localDataSource.getTodosByDate(date);
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getOverdueTodos() async {
    try {
      final result = await _localDataSource.getOverdueTodos();
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getTodosCount() async {
    try {
      final result = await _localDataSource.getTodosCount();
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getCompletedTodosCount() async {
    try {
      final result = await _localDataSource.getCompletedTodosCount();
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getPendingTodosCount() async {
    try {
      final result = await _localDataSource.getPendingTodosCount();
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> clearAllTodos() async {
    try {
      final result = await _localDataSource.clearAllTodos();
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}