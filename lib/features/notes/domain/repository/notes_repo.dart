import 'package:dartz/dartz.dart';
import 'package:tick_note/core/error/failure.dart';
import '../entities/note_entity.dart';

abstract class NotesRepository {
  Future<Either<Failure, List<NoteEntity>>> getAllNotes();
  Future<Either<Failure, NoteEntity?>> getNoteById(int id);
  Future<Either<Failure, int>> addNote(NoteEntity note);
  Future<Either<Failure, int>> updateNote(NoteEntity note);
  Future<Either<Failure, int>> deleteNote(int id);
  Future<Either<Failure, int>> deleteAllNotes();
  Future<Either<Failure, List<NoteEntity>>> searchNotes(String query);
  Future<Either<Failure, List<NoteEntity>>> getPinnedNotes();
}