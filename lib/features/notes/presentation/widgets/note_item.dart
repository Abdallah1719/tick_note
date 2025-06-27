import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.note, color: Colors.white),
      ),
      title: Text('Note Title', style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text(
        'This is a brief description of the note.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          // Handle delete action
        },
      ),
    );
  }
}
