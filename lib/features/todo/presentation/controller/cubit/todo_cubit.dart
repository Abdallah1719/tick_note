import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_note/features/todo/domain/entities/todo_entity.dart';
import 'package:tick_note/features/todo/domain/repository/todo_repo.dart';
import 'package:tick_note/features/todo/presentation/controller/cubit/todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _todoRepository;

  TodoCubit(this._todoRepository) : super(TodoInitial());
  // get All Todos
  Future<void> getAllTodos() async {
    emit(TodoLoading());
    final result = await _todoRepository.getAllTodos();
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todos) => emit(TodoLoaded(todos)),
    );
  }

  // insert Todo
  Future<void> insertTodo(TodoEntity todo) async {
    emit(TodoLoading());
    final result = await _todoRepository.insertTodo(todo);
    result.fold((failure) => emit(TodoError(failure.message)), (id) {
      emit(const TodoOperationSuccess('Todo added successfully'));
      getAllTodos(); // Refresh the list
    });
  }

  // update Todo
  Future<void> updateTodo(TodoEntity todo) async {
    emit(TodoLoading());
    final result = await _todoRepository.updateTodo(todo);
    result.fold((failure) => emit(TodoError(failure.message)), (rowsAffected) {
      emit(const TodoOperationSuccess('Todo updated successfully'));
      getAllTodos(); // Refresh the list
    });
  }

  // delete Todo
  Future<void> deleteTodo(int id) async {
    emit(TodoLoading());
    final result = await _todoRepository.deleteTodo(id);
    result.fold((failure) => emit(TodoError(failure.message)), (rowsAffected) {
      emit(const TodoOperationSuccess('Todo deleted successfully'));
      getAllTodos(); // Refresh the list
    });
  }

  Future<void> toggleTodoCompletion(TodoEntity todo) async {
    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    await updateTodo(updatedTodo);
  }

  // get Todo By Id
  Future<void> getTodoById(int id) async {
    emit(TodoLoading());
    final result = await _todoRepository.getTodoById(id);
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todo) => emit(TodoDetails(todo)),
    );
  }

  // get Completed Todos
  Future<void> getCompletedTodos() async {
    emit(TodoLoading());
    final result = await _todoRepository.getCompletedTodos();
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todos) => emit(TodoLoaded(todos)),
    );
  }

  // get Pending Todos
  Future<void> getPendingTodos() async {
    emit(TodoLoading());
    final result = await _todoRepository.getPendingTodos();
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todos) => emit(TodoLoaded(todos)),
    );
  }

  // get Todos By Date
  Future<void> getTodosByDate(DateTime date) async {
    emit(TodoLoading());
    final result = await _todoRepository.getTodosByDate(date);
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todos) => emit(TodoLoaded(todos)),
    );
  }

  // get Overdue Todos
  Future<void> getOverdueTodos() async {
    emit(TodoLoading());
    final result = await _todoRepository.getOverdueTodos();
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todos) => emit(TodoLoaded(todos)),
    );
  }

  // get Todos Counts
  Future<void> getTodosCounts() async {
    emit(TodoLoading());

    final totalResult = await _todoRepository.getTodosCount();
    final completedResult = await _todoRepository.getCompletedTodosCount();
    final pendingResult = await _todoRepository.getPendingTodosCount();

    if (totalResult.isLeft() ||
        completedResult.isLeft() ||
        pendingResult.isLeft()) {
      emit(const TodoError('Failed to get todos count'));
      return;
    }

    final totalCount = totalResult.getOrElse(() => 0);
    final completedCount = completedResult.getOrElse(() => 0);
    final pendingCount = pendingResult.getOrElse(() => 0);

    emit(
      TodoCounts(
        totalCount: totalCount,
        completedCount: completedCount,
        pendingCount: pendingCount,
      ),
    );
  }

  // clear All Todos
  Future<void> clearAllTodos() async {
    emit(TodoLoading());
    final result = await _todoRepository.clearAllTodos();
    result.fold((failure) => emit(TodoError(failure.message)), (rowsAffected) {
      emit(const TodoOperationSuccess('All todos cleared successfully'));
      getAllTodos(); // Refresh the list
    });
  }

  // search Todos
  void searchTodos(String query) async {
    try {
      emit(TodoLoading());
      if (query.isEmpty) {
        getAllTodos();
        return;
      }
      final todos = await _todoRepository.getAllTodos.call();
      todos.fold((failure) => emit(TodoError(failure.message)), (allTodos) {
        final filteredTodos = allTodos.where((todo) {
          final titleLower = todo.title.toLowerCase();
          final descriptionLower = (todo.description ?? '').toLowerCase();
          final queryLower = query.toLowerCase();

          return titleLower.contains(queryLower) ||
              descriptionLower.contains(queryLower);
        }).toList();

        emit(TodoLoaded(filteredTodos));
      });
    } catch (e) {
      emit(TodoError('An error occurred while searching todos: $e'));
    }
  }

  // Reset the state to initial
  void resetState() {
    emit(TodoInitial());
  }
}
