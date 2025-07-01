import 'package:flutter/material.dart';
import 'package:tick_note/core/routes/routes_constances.dart';
import 'package:tick_note/features/notes/presentation/screens/add_note_page.dart';
import 'package:tick_note/features/notes/presentation/screens/notes_page.dart';
import 'package:tick_note/features/splash/presentation/screens/splash_screen.dart';
import 'package:tick_note/features/todo/presentation/screens/todo_screen.dart';
import 'package:tick_note/features/main/presentation/screens/main_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesConstances.splashPath:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RoutesConstances.notesPath:
        return MaterialPageRoute(builder: (_) => const NotesPage());
      case RoutesConstances.todoPath:
        return MaterialPageRoute(builder: (_) => const TodoScreen());
      case RoutesConstances.mainScreenPath:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case RoutesConstances.addNotePath:
        return MaterialPageRoute(builder: (_) => const AddNotePage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
