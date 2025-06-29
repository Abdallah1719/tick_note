import 'package:dartz/dartz.dart';
import 'package:tick_note/core/error/failure.dart';
import 'package:tick_note/features/notes/data/data_source/notes_local_data_source.dart';
import 'package:tick_note/features/notes/data/models/note_models.dart';
import 'package:tick_note/features/notes/domain/entities/note_entity.dart';
import 'package:tick_note/features/notes/domain/repository/notes_repo.dart';


class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDataSource localDataSource;

  NotesRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<NoteEntity>>> getAllNotes() async {
    try {
      final result = await localDataSource.getAllNotes();
      return Right(result.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, NoteEntity?>> getNoteById(int id) async {
    try {
      final result = await localDataSource.getNoteById(id);
      return Right(result?.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> addNote(NoteEntity note) async {
    try {
      final noteModel = NoteModel.fromEntity(note);
      final result = await localDataSource.addNote(noteModel);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> updateNote(NoteEntity note) async {
    try {
      final noteModel = NoteModel.fromEntity(note);
      final result = await localDataSource.updateNote(noteModel);
      if (result == 0) {
        return Left(NotFoundFailure('Note not found'));
      }
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> deleteNote(int id) async {
    try {
      final result = await localDataSource.deleteNote(id);
      if (result == 0) {
        return Left(NotFoundFailure('Note not found'));
      }
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> deleteAllNotes() async {
    try {
      final result = await localDataSource.deleteAllNotes();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> searchNotes(String query) async {
    try {
      final result = await localDataSource.searchNotes(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> getPinnedNotes() async {
    try {
      final result = await localDataSource.getPinnedNotes();
      return Right(result.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
