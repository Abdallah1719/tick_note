import 'package:equatable/equatable.dart';
import 'package:tick_note/features/todo/domain/entities/todo_entity.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoEntity> todos;

  const TodoLoaded(this.todos);

  @override
  List<Object?> get props => [todos];
}

class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);

  @override
  List<Object?> get props => [message];
}

class TodoOperationSuccess extends TodoState {
  final String message;

  const TodoOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class TodoCounts extends TodoState {
  final int totalCount;
  final int completedCount;
  final int pendingCount;

  const TodoCounts({
    required this.totalCount,
    required this.completedCount,
    required this.pendingCount,
  });

  @override
  List<Object?> get props => [totalCount, completedCount, pendingCount];
}

class TodoDetails extends TodoState {
  final TodoEntity? todo;

  const TodoDetails(this.todo);

  @override
  List<Object?> get props => [todo];
}