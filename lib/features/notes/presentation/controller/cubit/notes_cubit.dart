import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_note/features/notes/domain/entities/note_entity.dart';
import 'package:tick_note/features/notes/domain/repository/notes_repo.dart';

import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesRepository notesRepository;

  NotesCubit({required this.notesRepository}) : super(NotesInitial());

  Future<void> getAllNotes() async {
    emit(NotesLoading());
    final result = await notesRepository.getAllNotes();
    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (notes) => emit(NotesLoaded(notes)),
    );
  }

  Future<void> addNote(NoteEntity note) async {
    emit(NotesLoading());
    final result = await notesRepository.addNote(note);
    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (id) {
        emit(NoteOperationSuccess('Note added successfully'));
        getAllNotes(); // Refresh the list
      },
    );
  }

  Future<void> updateNote(NoteEntity note) async {
    emit(NotesLoading());
    final result = await notesRepository.updateNote(note);
    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (affectedRows) {
        emit(NoteOperationSuccess('Note updated successfully'));
        getAllNotes(); // Refresh the list
      },
    );
  }

  Future<void> deleteNote(int id) async {
    emit(NotesLoading());
    final result = await notesRepository.deleteNote(id);
    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (affectedRows) {
        emit(NoteOperationSuccess('Note deleted successfully'));
        getAllNotes(); // Refresh the list
      },
    );
  }

  Future<void> deleteAllNotes() async {
    emit(NotesLoading());
    final result = await notesRepository.deleteAllNotes();
    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (affectedRows) {
        emit(NoteOperationSuccess('All notes deleted successfully'));
        getAllNotes(); // Refresh the list
      },
    );
  }

  Future<void> searchNotes(String query) async {
    if (query.isEmpty) {
      getAllNotes();
      return;
    }
    
    emit(NotesLoading());
    final result = await notesRepository.searchNotes(query);
    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (notes) => emit(NotesLoaded(notes)),
    );
  }

  Future<void> getPinnedNotes() async {
    emit(NotesLoading());
    final result = await notesRepository.getPinnedNotes();
    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (notes) => emit(NotesLoaded(notes)),
    );
  }

  Future<void> togglePinNote(NoteEntity note) async {
    final updatedNote = note.copyWith(isPinned: !note.isPinned);
    await updateNote(updatedNote);
  }
}
