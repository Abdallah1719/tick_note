// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tick_note/features/todo/domain/entities/todo_entity.dart';
// import 'package:tick_note/features/todo/presentation/controller/cubit/todo_cubit.dart';
// import 'package:tick_note/features/todo/presentation/controller/cubit/todo_state.dart';
// import 'package:tick_note/features/todo/presentation/widgets/bottom_sheet.dart';
// import 'package:tick_note/features/todo/presentation/widgets/search.dart';
// import 'package:tick_note/features/todo/presentation/widgets/todo_item.dart';

// class TodoScreen extends StatefulWidget {
//   const TodoScreen({super.key});

//   @override
//   State<TodoScreen> createState() => _TodoScreenState();
// }

// class _TodoScreenState extends State<TodoScreen> {
//   bool _isSearching = false;
//   String _searchQuery = '';
//   List<TodoEntity> _filteredTodos = [];

//   @override
//   void initState() {
//     super.initState();
//     // Load todos when screen initializes
//     context.read<TodoCubit>().getAllTodos();
//   }

//   void _toggleSearch() {
//     setState(() {
//       _isSearching = !_isSearching;
//       if (!_isSearching) {
//         _searchQuery = '';
//         _filteredTodos = [];
//       }
//     });
//   }

//   void _onSearchChanged(String query, List<TodoEntity> allTodos) {
//     setState(() {
//       _searchQuery = query;
//       if (query.isEmpty) {
//         _filteredTodos = [];
//       } else {
//         _filteredTodos = allTodos
//             .where(
//               (todo) =>
//                   todo.title.toLowerCase().contains(query.toLowerCase()) ||
//                   (todo.description?.toLowerCase().contains(
//                         query.toLowerCase(),
//                       ) ??
//                       false),
//             )
//             .toList();
//       }
//     });
//   }

//   void _showAddTodoBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => AddTodoBottomSheet(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: SearchAppBar(
//         isSearching: _isSearching,
//         onSearchToggle: _toggleSearch,
//         onSearchChanged: (query) {
//           final currentState = context.read<TodoCubit>().state;
//           if (currentState is TodoLoaded) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               _onSearchChanged(query, currentState.todos);
//             });
//           }
//         },
//       ),
//       body: BlocConsumer<TodoCubit, TodoState>(
//         listener: (context, state) {
//           if (state is TodoOperationSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.green,
//               ),
//             );
//           } else if (state is TodoError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is TodoLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is TodoLoaded) {
//             final todosToShow = _isSearching && _searchQuery.isNotEmpty
//                 ? _filteredTodos
//                 : state.todos;

//             if (todosToShow.isEmpty) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       _isSearching && _searchQuery.isNotEmpty
//                           ? Icons.search_off
//                           : Icons.note_add,
//                       size: 80,
//                       color: Colors.grey[400],
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       _isSearching && _searchQuery.isNotEmpty
//                           ? 'لا توجد نتائج للبحث'
//                           : 'لا توجد مهام بعد',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     if (!_isSearching || _searchQuery.isEmpty) ...[
//                       const SizedBox(height: 8),
//                       Text(
//                         'اضغط على + لإضافة مهمة جديدة',
//                         style: TextStyle(fontSize: 14, color: Colors.grey[500]),
//                       ),
//                     ],
//                   ],
//                 ),
//               );
//             }

//             return RefreshIndicator(
//               onRefresh: () async {
//                 context.read<TodoCubit>().getAllTodos();
//               },
//               child: ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: todosToShow.length,
//                 itemBuilder: (context, index) {
//                   return TodoItemWidget(
//                     todo: todosToShow[index],
//                     onToggleComplete: (todo) {
//                       context.read<TodoCubit>().toggleTodoCompletion(todo);
//                     },
//                     onDelete: (id) {
//                       _showDeleteConfirmation(id);
//                     },
//                     onEdit: (todo) {
//                       _showEditTodoBottomSheet(todo);
//                     },
//                   );
//                 },
//               ),
//             );
//           } else if (state is TodoError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error_outline, size: 80, color: Colors.red[400]),
//                   const SizedBox(height: 16),
//                   Text(
//                     'حدث خطأ',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.red[600],
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     state.message,
//                     style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       context.read<TodoCubit>().getAllTodos();
//                     },
//                     child: const Text('إعادة المحاولة'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return const SizedBox.shrink();
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showAddTodoBottomSheet,
//         backgroundColor: Theme.of(context).primaryColor,
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }

//   void _showDeleteConfirmation(int id) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('تأكيد الحذف'),
//         content: const Text('هل أنت متأكد من حذف هذه المهمة؟'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('إلغاء'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               context.read<TodoCubit>().deleteTodo(id);
//             },
//             style: TextButton.styleFrom(foregroundColor: Colors.red),
//             child: const Text('حذف'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showEditTodoBottomSheet(TodoEntity todo) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => AddTodoBottomSheet(todoToEdit: todo),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_note/features/todo/domain/entities/todo_entity.dart';
import 'package:tick_note/features/todo/presentation/controller/cubit/todo_cubit.dart';
import 'package:tick_note/features/todo/presentation/controller/cubit/todo_state.dart';
import 'package:tick_note/features/todo/presentation/widgets/bottom_sheet.dart';
import 'package:tick_note/features/todo/presentation/widgets/todo_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    // Load todos when screen initializes
    context.read<TodoCubit>().getAllTodos();
  }

  void _showAddTodoBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTodoBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // بدون AppBar - يتم التحكم فيه من MainScreen
      body: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {
          if (state is TodoOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is TodoError) {
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
          if (state is TodoLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('جاري تحميل المهام...'),
                ],
              ),
            );
          } else if (state is TodoLoaded) {
            if (state.todos.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.task_alt_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'لا توجد مهام بعد',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'اضغط على زر + لإضافة مهمة جديدة',
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
                context.read<TodoCubit>().getAllTodos();
              },
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100), // مساحة للـ FAB
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  final todo = state.todos[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TodoItemWidget(
                      todo: todo,
                      onToggleComplete: (todo) {
                        context.read<TodoCubit>().toggleTodoCompletion(todo);
                      },
                      onDelete: (id) {
                        _showDeleteConfirmation(id);
                      },
                      onEdit: (todo) {
                        _showEditTodoBottomSheet(todo);
                      },
                    ),
                  );
                },
              ),
            );
          } else if (state is TodoError) {
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
                      onPressed: () => context.read<TodoCubit>().getAllTodos(),
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
        onPressed: _showAddTodoBottomSheet,
        icon: const Icon(Icons.add),
        label: const Text('مهمة جديدة'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _showDeleteConfirmation(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف المهمة'),
        content: const Text('هل أنت متأكد من حذف هذه المهمة؟ لا يمكن التراجع عن هذا الإجراء.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<TodoCubit>().deleteTodo(id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  void _showEditTodoBottomSheet(TodoEntity todo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTodoBottomSheet(todoToEdit: todo),
    );
  }
}