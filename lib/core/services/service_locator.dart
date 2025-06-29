import 'package:get_it/get_it.dart';
import 'package:tick_note/core/data_source/local_data_source/shared_preferences/cache_helper.dart';
import 'package:tick_note/core/data_source/local_data_source/sqflite/database_helper.dart';
import 'package:tick_note/features/notes/data/data_source/notes_local_data_source.dart';
import 'package:tick_note/features/notes/data/repository/notes_repo_implement.dart';
import 'package:tick_note/features/notes/domain/repository/notes_repo.dart';
import 'package:tick_note/features/notes/presentation/controller/cubit/notes_cubit.dart';

final sl = GetIt.instance;
void setupServiceLocator() {
  //shared preferences
  sl.registerSingleton<CacheHelper>(CacheHelper());
  // ==================== DatabaseHelper ====================
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // ==================== Data Sources ====================
  sl.registerLazySingleton<NotesLocalDataSource>(
    () => NotesLocalDataSourceImpl(databaseHelper: sl()),
  );

  // ==================== Repositories ====================
  sl.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImpl(localDataSource: sl()),
  );

  // ==================== Cubits ====================
  sl.registerFactory(() => NotesCubit(notesRepository: sl()));
}
