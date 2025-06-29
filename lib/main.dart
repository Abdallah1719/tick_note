import 'package:flutter/material.dart';
import 'package:tick_note/app.dart';
import 'package:tick_note/core/data_source/local_data_source/shared_preferences/cache_helper.dart';
import 'package:tick_note/core/data_source/local_data_source/sqflite/database_helper.dart';
import 'package:tick_note/core/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  await DatabaseHelper().database;
  setupServiceLocator();
  runApp(const TickNote());
}
