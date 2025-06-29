import 'package:tick_note/core/data_source/local_data_source/sqflite/database_constances.dart';
import 'package:tick_note/features/todo/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    super.id,
    required super.title,
    super.description,
    required super.isCompleted,
    required super.createdAt,
    super.dueDate,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map[DatabaseConstances.todoId] as int?,
      title: map[DatabaseConstances.todoTitle] as String,
      description: map[DatabaseConstances.todoDescription] as String?,
      isCompleted: (map[DatabaseConstances.todoIsCompleted] as int) == 1,
      createdAt: DateTime.parse(map[DatabaseConstances.todoCreatedAt] as String),
      dueDate: map[DatabaseConstances.todoDueDate] != null
          ? DateTime.parse(map[DatabaseConstances.todoDueDate] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) DatabaseConstances.todoId: id,
      DatabaseConstances.todoTitle: title,
      DatabaseConstances.todoDescription: description,
      DatabaseConstances.todoIsCompleted: isCompleted ? 1 : 0,
      DatabaseConstances.todoCreatedAt: createdAt.toIso8601String(),
      DatabaseConstances.todoDueDate: dueDate?.toIso8601String(),
    };
  }

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt,
      dueDate: entity.dueDate,
    );
  }

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}