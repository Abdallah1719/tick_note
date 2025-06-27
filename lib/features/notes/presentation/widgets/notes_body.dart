import 'package:flutter/material.dart';
import 'package:tick_note/features/notes/presentation/widgets/note_item.dart';

class NotesBody extends StatelessWidget {
  const NotesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return NoteItem();
      },
      itemCount: 20,
      padding: const EdgeInsets.all(8.0),
    );
  }
}
