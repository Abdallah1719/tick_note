import 'package:flutter/material.dart';
import 'package:tick_note/app.dart';
import 'package:tick_note/core/data_source/local_data_source/shared_preferences/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  runApp(const TickNote());
}
