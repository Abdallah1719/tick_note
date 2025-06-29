import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_note/features/notes/presentation/controller/cubit/notes_cubit.dart';
import 'package:tick_note/features/notes/presentation/widgets/color_picker_widget.dart';
import 'package:tick_note/features/notes/domain/entities/note_entity.dart';

// class AddNotePage extends StatefulWidget {
//   const AddNotePage({super.key});

//   @override
//   State<AddNotePage> createState() => _AddNotePageState();
// }

// class _AddNotePageState extends State<AddNotePage> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _contentController = TextEditingController();
//   String _selectedColor = '#FFFFFF';

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _contentController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         _saveNote();
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               _saveNote();
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(
//                   hintText: 'العنوان',
//                   border: InputBorder.none,
//                   hintStyle: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 maxLines: null,
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: TextField(
//                   controller: _contentController,
//                   decoration: const InputDecoration(
//                     hintText: 'المحتوى',
//                     border: InputBorder.none,
//                     hintStyle: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   style: const TextStyle(fontSize: 16),
//                   maxLines: null,
//                   expands: true,
//                   textAlignVertical: TextAlignVertical.top,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ColorPickerWidget(
//                 selectedColor: _selectedColor,
//                 onColorSelected: (color) {
//                   setState(() {
//                     _selectedColor = color;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _saveNote() {
//     if (_titleController.text.trim().isEmpty && _contentController.text.trim().isEmpty) {
//       return;
//     }

//     final note = NoteEntity(
//       title: _titleController.text.trim().isEmpty ? 'Untitled' : _titleController.text.trim(),
//       content: _contentController.text.trim(),
//       color: _selectedColor,
//       createdAt: DateTime.now(),
//       updatedAt: DateTime.now(),
//       isPinned: false,
//     );

//     context.read<NotesCubit>().addNote(note);
//   }
// }

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _selectedColor = '#FFFFFF';

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          _saveNote();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // _saveNote();
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'العنوان',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: null,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    hintText: 'المحتوى',
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  style: const TextStyle(fontSize: 16),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
              const SizedBox(height: 16),
              ColorPickerWidget(
                selectedColor: _selectedColor,
                onColorSelected: (color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveNote() {
    if (_titleController.text.trim().isEmpty &&
        _contentController.text.trim().isEmpty) {
      return;
    }

    final note = NoteEntity(
      title: _titleController.text.trim().isEmpty
          ? 'Untitled'
          : _titleController.text.trim(),
      subtitle: _contentController.text.trim(),
      color: _colorFromHex(_selectedColor),
      // date: DateTime.now(),
      date: DateTime.now().toString(),
      isPinned: false,
    );

    context.read<NotesCubit>().addNote(note);
  }
}

int _colorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor'; // add alpha if not provided
  }
  return int.parse(hexColor, radix: 16);
}
