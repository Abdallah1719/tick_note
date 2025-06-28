import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:tick_note/core/data_source/local_data_source/shared_preferences/cache_helper.dart';
import 'package:tick_note/generated/l10n.dart';

class LocaleCubit extends Cubit<String> {
  LocaleCubit() : super('en');

  static List<LocalizationsDelegate> localizationsDelegates = [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }

  void toggleLocale() async {
    final newLocale = state == 'en' ? 'ar' : 'en';
    await CacheHelper().saveData(key: 'locale', value: newLocale);
    emit(newLocale);
  }

  void loadSavedLocale() async {
    final savedLocale = await CacheHelper().getData(key: 'locale') ?? 'en';
    emit(savedLocale);
  }
}
