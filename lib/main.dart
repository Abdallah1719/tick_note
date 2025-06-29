import 'package:flutter/material.dart';
import 'package:tick_note/app.dart';
import 'package:tick_note/core/storage/shared_preferences/cache_helper.dart';
import 'package:tick_note/core/storage/datebase/database_helper.dart';
import 'package:tick_note/core/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  await DatabaseHelper().database;
  setupServiceLocator();
  runApp(const TickNote());
}
