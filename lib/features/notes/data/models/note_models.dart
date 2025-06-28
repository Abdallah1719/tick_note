// features/notes/data/models/note_model.dart
import 'package:tick_note/core/data_source/local_data_source/sqflite/database_constances.dart';
import 'package:tick_note/features/notes/domain/entity/note_entity.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    super.id,
    required super.title,
    super.subtitle,
    required super.date,
    super.color = 0xFFFFFFFF,
    super.isPinned = false,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json[DatabaseConstances.noteId] as int?,
      title: json[DatabaseConstances.noteTitle] as String,
      subtitle: json[DatabaseConstances.noteSubtitle] as String?,
      date: json[DatabaseConstances.noteDate] as String,
      color: json[DatabaseConstances.noteColor] as int? ?? 0xFFFFFFFF,
      isPinned: (json[DatabaseConstances.noteIsPinned] as int? ?? 0) == 1,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    
    if (id != null) {
      data[DatabaseConstances.noteId] = id;
    }
    data[DatabaseConstances.noteTitle] = title;
    if (subtitle != null) {
      data[DatabaseConstances.noteSubtitle] = subtitle;
    }
    data[DatabaseConstances.noteDate] = date;
    data[DatabaseConstances.noteColor] = color;
    data[DatabaseConstances.noteIsPinned] = isPinned ? 1 : 0;
    
    return data;
  }

  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      date: entity.date,
      color: entity.color,
      isPinned: entity.isPinned,
    );
  }

  NoteEntity toEntity() {
    return NoteEntity(
      id: id,
      title: title,
      subtitle: subtitle,
      date: date,
      color: color,
      isPinned: isPinned,
    );
  }
}