import 'package:dartz/dartz.dart';
import 'package:tick_note/core/error/failure.dart';
import 'package:tick_note/features/todo/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<Either<Failure, int>> insertTodo(TodoEntity todo);
  Future<Either<Failure, List<TodoEntity>>> getAllTodos();
  Future<Either<Failure, TodoEntity?>> getTodoById(int id);
  Future<Either<Failure, int>> updateTodo(TodoEntity todo);
  Future<Either<Failure, int>> deleteTodo(int id);
  Future<Either<Failure, List<TodoEntity>>> getCompletedTodos();
  Future<Either<Failure, List<TodoEntity>>> getPendingTodos();
  Future<Either<Failure, List<TodoEntity>>> getTodosByDate(DateTime date);
  Future<Either<Failure, List<TodoEntity>>> getOverdueTodos();
  Future<Either<Failure, int>> getTodosCount();
  Future<Either<Failure, int>> getCompletedTodosCount();
  Future<Either<Failure, int>> getPendingTodosCount();
  Future<Either<Failure, int>> clearAllTodos();
}