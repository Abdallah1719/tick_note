import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tick_note/features/notes/domain/entities/note_entity.dart';
import 'package:tick_note/features/notes/presentation/controller/cubit/notes_cubit.dart';
import 'package:tick_note/features/notes/presentation/controller/cubit/notes_state.dart';
import 'package:tick_note/features/notes/presentation/screens/add_note_page.dart';
import 'package:tick_note/features/notes/presentation/screens/edit_note_page.dart';
import 'package:tick_note/features/notes/presentation/widgets/note_card.dart';
import 'package:tick_note/features/notes/presentation/widgets/search_bar_widget.dart';

// class NotesPage extends StatefulWidget {
//   const NotesPage({Key? key}) : super(key: key);

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

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().getAllNotes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
    });
    _searchController.clear();
    context.read<NotesCubit>().getAllNotes();
  }

  void _onSearchChanged(String query) {
    context.read<NotesCubit>().searchNotes(query);
  }

  @override
  Widget build(BuildContext context) {
    return 
    // BlocProvider(
    //   create: (context) => sl<NotesCubit>(),
    //   child:
       Scaffold(
        appBar: AppBar(
          title: _isSearching
              ? SearchBarWidget(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  onClose: _stopSearch,
                )
              : const Text('Notes'),
          actions: _isSearching
              ? null
              : [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _startSearch,
                  ),
                ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocConsumer<NotesCubit, NotesState>(
          listener: (context, state) {
            if (state is NoteOperationSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is NotesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is NotesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotesLoaded) {
              if (state.notes.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.note_add, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No notes yet',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return NoteCard(
                    note: note,
                    onTap: () => _navigateToEditNote(note),
                    onDelete: () => _deleteNote(note.id!),
                    onPin: () => _togglePin(note),
                  );
                },
              );
            } else if (state is NotesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<NotesCubit>().getAllNotes(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToAddNote,
          child: const Icon(Icons.add),
        ),
      // ),
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

  void _deleteNote(int id) {
    context.read<NotesCubit>().deleteNote(id);
  }

  void _togglePin(NoteEntity note) {
    context.read<NotesCubit>().togglePinNote(note);
  }
}
