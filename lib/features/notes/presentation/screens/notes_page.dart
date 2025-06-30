// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:tick_note/features/notes/domain/entities/note_entity.dart';
// import 'package:tick_note/features/notes/presentation/controller/cubit/notes_cubit.dart';
// import 'package:tick_note/features/notes/presentation/controller/cubit/notes_state.dart';
// import 'package:tick_note/features/notes/presentation/screens/add_note_page.dart';
// import 'package:tick_note/features/notes/presentation/screens/edit_note_page.dart';
// import 'package:tick_note/features/notes/presentation/widgets/note_card.dart';
// import 'package:tick_note/features/notes/presentation/widgets/search_bar_widget.dart';


// class NotesPage extends StatefulWidget {
//   const NotesPage({super.key});

//   @override
//   State<NotesPage> createState() => _NotesPageState();
// }

// class _NotesPageState extends State<NotesPage> {
//   bool _isSearching = false;
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     context.read<NotesCubit>().getAllNotes();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _startSearch() {
//     setState(() {
//       _isSearching = true;
//     });
//   }

//   void _stopSearch() {
//     setState(() {
//       _isSearching = false;
//     });
//     _searchController.clear();
//     context.read<NotesCubit>().getAllNotes();
//   }

//   void _onSearchChanged(String query) {
//     context.read<NotesCubit>().searchNotes(query);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//     // BlocProvider(
//     //   create: (context) => sl<NotesCubit>(),
//     //   child:
//        Scaffold(
//         appBar: AppBar(
//           title: _isSearching
//               ? SearchBarWidget(
//                   controller: _searchController,
//                   onChanged: _onSearchChanged,
//                   onClose: _stopSearch,
//                 )
//               : const Text('Notes'),
//           actions: _isSearching
//               ? null
//               : [
//                   IconButton(
//                     icon: const Icon(Icons.search),
//                     onPressed: _startSearch,
//                   ),
//                 ],
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: BlocConsumer<NotesCubit, NotesState>(
//           listener: (context, state) {
//             if (state is NoteOperationSuccess) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.message)));
//             } else if (state is NotesError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is NotesLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is NotesLoaded) {
//               if (state.notes.isEmpty) {
//                 return const Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.note_add, size: 64, color: Colors.grey),
//                       SizedBox(height: 16),
//                       Text(
//                         'No notes yet',
//                         style: TextStyle(fontSize: 18, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//               return ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: state.notes.length,
//                 itemBuilder: (context, index) {
//                   final note = state.notes[index];
//                   return NoteCard(
//                     note: note,
//                     onTap: () => _navigateToEditNote(note),
//                     onDelete: () => _deleteNote(note.id!),
//                     onPin: () => _togglePin(note),
//                   );
//                 },
//               );
//             } else if (state is NotesError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.error, size: 64, color: Colors.red),
//                     const SizedBox(height: 16),
//                     Text(
//                       state.message,
//                       style: const TextStyle(fontSize: 16, color: Colors.red),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () => context.read<NotesCubit>().getAllNotes(),
//                       child: const Text('Retry'),
//                     ),
//                   ],
//                 ),
//               );
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _navigateToAddNote,
//           child: const Icon(Icons.add),
//         ),
//       // ),
//     );
//   }

//   void _navigateToAddNote() async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: context.read<NotesCubit>(),
//           child: const AddNotePage(),
//         ),
//       ),
//     );
//   }

//   void _navigateToEditNote(NoteEntity note) async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: context.read<NotesCubit>(),
//           child: EditNotePage(note: note),
//         ),
//       ),
//     );
//   }

//   void _deleteNote(int id) {
//     context.read<NotesCubit>().deleteNote(id);
//   }

//   void _togglePin(NoteEntity note) {
//     context.read<NotesCubit>().togglePinNote(note);
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tick_note/features/notes/domain/entities/note_entity.dart';
import 'package:tick_note/features/notes/presentation/controller/cubit/notes_cubit.dart';
import 'package:tick_note/features/notes/presentation/controller/cubit/notes_state.dart';
import 'package:tick_note/features/notes/presentation/screens/add_note_page.dart';
import 'package:tick_note/features/notes/presentation/screens/edit_note_page.dart';
import 'package:tick_note/features/notes/presentation/widgets/note_card.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // بدون AppBar - يتم التحكم فيه من MainScreen
      body: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {
          if (state is NoteOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is NotesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('جاري تحميل الملاحظات...'),
                ],
              ),
            );
          } else if (state is NotesLoaded) {
            if (state.notes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.note_add_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'لا توجد ملاحظات بعد',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'اضغط على زر + لإضافة ملاحظة جديدة',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<NotesCubit>().getAllNotes();
              },
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100), // مساحة للـ FAB
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: NoteCard(
                      note: note,
                      onTap: () => _navigateToEditNote(note),
                      onDelete: () => _showDeleteConfirmation(note),
                      onPin: () => _togglePin(note),
                    ),
                  );
                },
              ),
            );
          } else if (state is NotesError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red[300],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'حدث خطأ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.read<NotesCubit>().getAllNotes(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة المحاولة'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddNote,
        icon: const Icon(Icons.add),
        label: const Text('ملاحظة جديدة'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _navigateToAddNote() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<NotesCubit>(),
          child: const AddNotePage(),
        ),
      ),
    );
  }

  void _navigateToEditNote(NoteEntity note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<NotesCubit>(),
          child: EditNotePage(note: note),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(NoteEntity note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الملاحظة'),
        content: const Text('هل أنت متأكد من حذف هذه الملاحظة؟ لا يمكن التراجع عن هذا الإجراء.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteNote(note.id!);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  void _deleteNote(int id) {
    context.read<NotesCubit>().deleteNote(id);
  }

  void _togglePin(NoteEntity note) {
    context.read<NotesCubit>().togglePinNote(note);
  }
}