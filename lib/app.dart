// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:tick_note/generated/l10n.dart';

// class TickNote extends StatelessWidget {
//   const TickNote({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       localizationsDelegates: [
//         S.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: S.delegate.supportedLocales,
//       locale: const Locale('en', ''), // Default locale
//       title: 'TickNote',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: Scaffold(
//         appBar: AppBar(title: Text(S.of(context).title)),
//         body: Center(child: const Text('Welcome to TickNote!')),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tick_note/generated/l10n.dart';

class TickNote extends StatelessWidget {
  const TickNote({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('en', ''),
      title: 'TickNote',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(), // صفحة منفصلة
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).title)), // هنا هيشتغل
      body: const Center(child: Text('Welcome to TickNote!')),
    );
  }
}
