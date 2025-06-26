import 'package:flutter/material.dart';
import 'package:tick_note/core/routes/routes_constances.dart';
import 'package:tick_note/features/notes/presentation/screens/notes_screen.dart';
import 'package:tick_note/features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesConstances.splashPath:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RoutesConstances.notesPath:
        return MaterialPageRoute(builder: (_) => const NotesScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
