import 'package:flutter/material.dart';
import 'package:tick_note/features/notes/presentation/widgets/custom_note_app_bar.dart';
import 'package:tick_note/features/notes/presentation/widgets/notes_body.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomNoteAppBar(), body: NotesBody());
  }
}
