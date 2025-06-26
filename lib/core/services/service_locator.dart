import 'package:get_it/get_it.dart';
import 'package:tick_note/core/data_source/local_data_source/cache_helper.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  //shared preferences
  getIt.registerSingleton<CacheHelper>(CacheHelper());
}
