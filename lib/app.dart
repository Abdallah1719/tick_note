import 'package:flutter/material.dart';

class TickNote extends StatelessWidget {
  const TickNote({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TickNote',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('TickNote')),
        body: Center(child: const Text('Welcome to TickNote!')),
      ),
    );
  }
}
