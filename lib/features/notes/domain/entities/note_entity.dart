import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final int? id;
  final String title;
  final String? subtitle;
  final String date;
  final int color;
  final bool isPinned;

  const NoteEntity({
    this.id,
    required this.title,
    this.subtitle,
    required this.date,
    this.color = 0xFFFFFFFF,
    this.isPinned = false,
  });

  @override
  List<Object?> get props => [id, title, subtitle, date, color, isPinned];

  NoteEntity copyWith({
    int? id,
    String? title,
    String? subtitle,
    String? date,
    int? color,
    bool? isPinned,
  }) {
    return NoteEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      date: date ?? this.date,
      color: color ?? this.color,
      isPinned: isPinned ?? this.isPinned,
    );
  }
}