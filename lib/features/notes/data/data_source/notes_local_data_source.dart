
import 'package:flutter/material.dart';
import 'package:tick_note/core/data_source/local_data_source/sqflite/database_constances.dart';
import 'package:tick_note/core/data_source/local_data_source/sqflite/database_helper.dart';
import 'package:tick_note/core/error/failure.dart';
import 'package:tick_note/features/notes/data/models/note_models.dart';

abstract class NotesLocalDataSource {
  Future<List<NoteModel>> getAllNotes();
  Future<NoteModel?> getNoteById(int id);
  Future<int> addNote(NoteModel note);
  Future<int> updateNote(NoteModel note);
  Future<int> deleteNote(int id);
  Future<int> deleteAllNotes();
  Future<List<NoteModel>> searchNotes(String query);
  Future<List<NoteModel>> getPinnedNotes();
}

class NotesLocalDataSourceImpl implements NotesLocalDataSource {
  final DatabaseHelper databaseHelper;

  NotesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<NoteModel>> getAllNotes() async {
    try {
      final result = await databaseHelper.query(
        tableName: DatabaseConstances.tableNotes,
        orderBy: '${DatabaseConstances.noteIsPinned} DESC, ${DatabaseConstances.noteDate} DESC',
      );
      return result.map((map) => NoteModel.fromMap(map)).toList();
    } catch (e) {
      throw DatabaseException('Failed to get all notes: ${e.toString()}');
    }
  }

  @override
  Future<NoteModel?> getNoteById(int id) async {
    try {
      final result = await databaseHelper.getById(
        tableName: DatabaseConstances.tableNotes,
        idColumn: DatabaseConstances.noteId,
        id: id,
      );
      return result != null ? NoteModel.fromMap(result) : null;
    } catch (e) {
      throw DatabaseException('Failed to get note by id: ${e.toString()}');
    }
  }

  @override
  Future<int> addNote(NoteModel note) async {
    try {
      return await databaseHelper.insert(
        tableName: DatabaseConstances.tableNotes,
        data: note.toMap(),
      );
    } catch (e) {
      throw DatabaseException('Failed to add note: ${e.toString()}');
    }
  }

  @override
  Future<int> updateNote(NoteModel note) async {
    try {
      if (note.id == null) {
        throw DatabaseException('Cannot update note without id');
      }
      return await databaseHelper.update(
        tableName: DatabaseConstances.tableNotes,
        data: note.toMap(),
        where: '${DatabaseConstances.noteId} = ?',
        whereArgs: [note.id],
      );
    } catch (e) {
      throw DatabaseException('Failed to update note: ${e.toString()}');
    }
  }

  @override
  Future<int> deleteNote(int id) async {
    try {
      return await databaseHelper.delete(
        tableName: DatabaseConstances.tableNotes,
        where: '${DatabaseConstances.noteId} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw DatabaseException('Failed to delete note: ${e.toString()}');
    }
  }

  @override
  Future<int> deleteAllNotes() async {
    try {
      return await databaseHelper.clearTable(DatabaseConstances.tableNotes);
    } catch (e) {
      throw DatabaseException('Failed to delete all notes: ${e.toString()}');
    }
  }

  @override
  Future<List<NoteModel>> searchNotes(String query) async {
    try {
      final result = await databaseHelper.query(
        tableName: DatabaseConstances.tableNotes,
        where: '${DatabaseConstances.noteTitle} LIKE ? OR ${DatabaseConstances.noteSubtitle} LIKE ?',
        whereArgs: ['%$query%', '%$query%'],
        orderBy: '${DatabaseConstances.noteIsPinned} DESC, ${DatabaseConstances.noteDate} DESC',
      );
      return result.map((map) => NoteModel.fromMap(map)).toList();
    } catch (e) {
      throw DatabaseException('Failed to search notes: ${e.toString()}');
    }
  }

  @override
  Future<List<NoteModel>> getPinnedNotes() async {
    try {
      final result = await databaseHelper.query(
        tableName: DatabaseConstances.tableNotes,
        where: '${DatabaseConstances.noteIsPinned} = ?',
        whereArgs: [1],
        orderBy: '${DatabaseConstances.noteDate} DESC',
      );
      return result.map((map) => NoteModel.fromMap(map)).toList();
    } catch (e) {
      throw DatabaseException('Failed to get pinned notes: ${e.toString()}');
    }
  }
}
