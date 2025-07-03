import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_note/features/main/presentation/widgets/settings_drawer.dart';
import 'package:tick_note/features/main/presentation/widgets/shared_app_bar.dart';
import 'package:tick_note/features/main/presentation/widgets/shared_bottom_nav.dart';
import 'package:tick_note/features/notes/presentation/controller/cubit/notes_cubit.dart';
import 'package:tick_note/features/notes/presentation/screens/add_note_page.dart';
import 'package:tick_note/features/notes/presentation/screens/notes_page.dart';
import 'package:tick_note/features/settings/presentation/screens/settings_drawer.dart';
import 'package:tick_note/features/todo/presentation/controller/cubit/todo_cubit.dart';
import 'package:tick_note/features/todo/presentation/screens/todo_screen.dart';
import 'package:tick_note/features/todo/presentation/widgets/bottom_sheet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_isSearching) {
        _stopSearch();
      }
    });
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

    // إعادة تحميل البيانات حسب الصفحة النشطة
    if (_currentIndex == 0) {
      context.read<NotesCubit>().getAllNotes();
    } else {
      context.read<TodoCubit>().getAllTodos();
    }
  }

  void _onSearchChanged(String query) {
    if (_currentIndex == 0) {
      context.read<NotesCubit>().searchNotes(query);
    } else {
      context.read<TodoCubit>().searchTodos(query);
    }
  }

  void _onSort() {
    // هنا هنضيف منطق الـ Sort
    if (_currentIndex == 0) {
      _showNotesSortOptions();
    } else {
      _showTodosSortOptions();
    }
  }

  void _showNotesSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('ترتيب حسب التاريخ'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Add sort by date logic for notes
                context.read<NotesCubit>().getAllNotes(); // Temporary
              },
            ),
            ListTile(
              leading: const Icon(Icons.title),
              title: const Text('ترتيب حسب العنوان'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Add sort by title logic for notes
                context.read<NotesCubit>().getAllNotes(); // Temporary
              },
            ),
            ListTile(
              leading: const Icon(Icons.push_pin),
              title: const Text('المثبتة أولاً'),
              onTap: () {
                Navigator.pop(context);
                context.read<NotesCubit>().getPinnedNotes();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTodosSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('ترتيب حسب التاريخ'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Add sort by date logic for todos
                context.read<TodoCubit>().getAllTodos(); // Temporary
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text('المكتملة'),
              onTap: () {
                Navigator.pop(context);
                context.read<TodoCubit>().getCompletedTodos();
              },
            ),
            ListTile(
              leading: const Icon(Icons.pending),
              title: const Text('المعلقة'),
              onTap: () {
                Navigator.pop(context);
                context.read<TodoCubit>().getPendingTodos();
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning),
              title: const Text('المتأخرة'),
              onTap: () {
                Navigator.pop(context);
                context.read<TodoCubit>().getOverdueTodos();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onAddPressed() {
    if (_currentIndex == 0) {
      _navigateToAddNote();
    } else {
      _showAddTodoBottomSheet();
    }
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

  void _showAddTodoBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTodoBottomSheet(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: SharedAppBar(
        title: _currentIndex == 0 ? 'Notes' : 'Todo',
        isSearching: _isSearching,
        searchController: _searchController,
        onStartSearch: _startSearch,
        onStopSearch: _stopSearch,
        onSearchChanged: _onSearchChanged,
        onSort: _onSort,
        onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: const SettingsDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: const [NotesPage(), TodoScreen()],
      ),
      bottomNavigationBar: SharedBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onAddPressed,
        icon: const Icon(Icons.add),
        label: Text(_currentIndex == 0 ? 'ملاحظة جديدة' : 'مهمة جديدة'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
