// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:tick_note/core/services/service_locator.dart';
// // import 'package:tick_note/features/notes/presentation/controller/cubit/notes_cubit.dart';
// // import 'package:tick_note/features/notes/presentation/screens/notes_page.dart';
// // import 'package:tick_note/features/todo/presentation/controller/cubit/todo_cubit.dart';
// // import 'package:tick_note/features/todo/presentation/screens/todo_screen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

// // import 'package:tick_note/features/notes/presentation/controller/cubit/notes_cubit.dart';
// // import 'package:tick_note/features/todo/presentation/controller/cubit/todo_cubit.dart';

// // class MainScreen extends StatefulWidget {
// //   const MainScreen({super.key});

// //   @override
// //   State<MainScreen> createState() => _MainScreenState();
// // }

// // class _MainScreenState extends State<MainScreen> {
// //   int _currentIndex = 0;

// //   void _onTabTapped(int index) {
// //     setState(() {
// //       _currentIndex = index;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiBlocProvider(
// //       providers: [
// //         BlocProvider<NotesCubit>(
// //           create: (context) =>
// //               sl<NotesCubit>(), // assuming you have service locator
// //         ),
// //         BlocProvider<TodoCubit>(
// //           create: (context) =>
// //               sl<TodoCubit>(), // assuming you have service locator
// //         ),
// //       ],
// //       child: Scaffold(
// //         // بدون AppBar هنا - كل صفحة تدير الـ AppBar بتاعها
// //         body: IndexedStack(
// //           index: _currentIndex,
// //           children: const [NotesPage(), TodoScreen()],
// //         ),
// //         bottomNavigationBar: Container(
// //           decoration: BoxDecoration(
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black.withOpacity(0.1),
// //                 blurRadius: 8,
// //                 offset: const Offset(0, -2),
// //               ),
// //             ],
// //           ),
// //           child: BottomNavigationBar(
// //             currentIndex: _currentIndex,
// //             onTap: _onTabTapped,
// //             type: BottomNavigationBarType.fixed,
// //             selectedItemColor: Theme.of(context).primaryColor,
// //             unselectedItemColor: Colors.grey,
// //             selectedLabelStyle: const TextStyle(
// //               fontWeight: FontWeight.w600,
// //               fontSize: 12,
// //             ),
// //             unselectedLabelStyle: const TextStyle(
// //               fontWeight: FontWeight.w400,
// //               fontSize: 11,
// //             ),
// //             elevation: 0,
// //             backgroundColor: Colors.white,
// //             items: const [
// //               BottomNavigationBarItem(
// //                 icon: Icon(Icons.note_alt_outlined),
// //                 activeIcon: Icon(Icons.note_alt),
// //                 label: 'Notes',
// //               ),
// //               BottomNavigationBarItem(
// //                 icon: Icon(Icons.check_box_outlined),
// //                 activeIcon: Icon(Icons.check_box),
// //                 label: 'Todo',
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tick_note/core/services/service_locator.dart';
// import 'package:tick_note/features/notes/presentation/controller/cubit/notes_cubit.dart';
// import 'package:tick_note/features/notes/presentation/screens/notes_page.dart';
// import 'package:tick_note/features/todo/presentation/controller/cubit/todo_cubit.dart';
// import 'package:tick_note/features/todo/presentation/screens/todo_screen.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<NotesCubit>(create: (context) => sl<NotesCubit>()),
//         BlocProvider<TodoCubit>(create: (context) => sl<TodoCubit>()),
//       ],
//       child: Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: Text(
//             _currentIndex == 0 ? 'Notes' : 'Todo',
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//           centerTitle: true,
//           elevation: 0,
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
//           leading: IconButton(
//             icon: const Icon(Icons.menu_rounded),
//             onPressed: () => _scaffoldKey.currentState?.openDrawer(),
//             tooltip: 'Settings',
//           ),
//           actions: [
//             // يمكن إضافة أزرار إضافية هنا حسب الحاجة
//             IconButton(
//               icon: Icon(_currentIndex == 0 ? Icons.search : Icons.filter_list),
//               onPressed: () {
//                 // وظيفة البحث أو التصفية
//               },
//             ),
//           ],
//         ),
//         drawer: _buildSettingsDrawer(context),
//         body: IndexedStack(
//           index: _currentIndex,
//           children: const [NotesPage(), TodoScreen()],
//         ),
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 8,
//                 offset: const Offset(0, -2),
//               ),
//             ],
//           ),
//           child: BottomNavigationBar(
//             currentIndex: _currentIndex,
//             onTap: _onTabTapped,
//             type: BottomNavigationBarType.fixed,
//             selectedItemColor: Theme.of(context).primaryColor,
//             unselectedItemColor: Colors.grey,
//             selectedLabelStyle: const TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 12,
//             ),
//             unselectedLabelStyle: const TextStyle(
//               fontWeight: FontWeight.w400,
//               fontSize: 11,
//             ),
//             elevation: 0,
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.note_alt_outlined),
//                 activeIcon: Icon(Icons.note_alt),
//                 label: 'Notes',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.check_box_outlined),
//                 activeIcon: Icon(Icons.check_box),
//                 label: 'Todo',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSettingsDrawer(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           // Header جميل
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.fromLTRB(16, 60, 16, 20),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Theme.of(context).primaryColor,
//                   Theme.of(context).primaryColor.withOpacity(0.8),
//                 ],
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Icon(Icons.settings_rounded, color: Colors.white, size: 32),
//                 const SizedBox(height: 12),
//                 const Text(
//                   'الإعدادات',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Text(
//                   'Settings',
//                   style: TextStyle(color: Colors.white70, fontSize: 14),
//                 ),
//               ],
//             ),
//           ),

//           // قائمة الإعدادات
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               children: [
//                 _buildSettingsItem(
//                   context,
//                   icon: Icons.palette_rounded,
//                   titleAr: 'المظهر',
//                   titleEn: 'Theme',
//                   subtitle: 'تغيير المظهر الفاتح والداكن',
//                   onTap: () => _showThemeDialog(context),
//                 ),
//                 _buildSettingsItem(
//                   context,
//                   icon: Icons.language_rounded,
//                   titleAr: 'اللغة',
//                   titleEn: 'Language',
//                   subtitle: 'تغيير لغة التطبيق',
//                   onTap: () => _showLanguageDialog(context),
//                 ),
//                 _buildSettingsItem(
//                   context,
//                   icon: Icons.notifications_rounded,
//                   titleAr: 'الإشعارات',
//                   titleEn: 'Notifications',
//                   subtitle: 'إعدادات التنبيهات',
//                   onTap: () => _showNotificationSettings(context),
//                 ),
//                 _buildSettingsItem(
//                   context,
//                   icon: Icons.backup_rounded,
//                   titleAr: 'النسخ الاحتياطي',
//                   titleEn: 'Backup',
//                   subtitle: 'حفظ واستعادة البيانات',
//                   onTap: () => _showBackupOptions(context),
//                 ),
//                 const Divider(),
//                 _buildSettingsItem(
//                   context,
//                   icon: Icons.info_rounded,
//                   titleAr: 'حول التطبيق',
//                   titleEn: 'About',
//                   subtitle: 'معلومات التطبيق والإصدار',
//                   onTap: () => _showAboutDialog(context),
//                 ),
//                 _buildSettingsItem(
//                   context,
//                   icon: Icons.help_rounded,
//                   titleAr: 'المساعدة',
//                   titleEn: 'Help',
//                   subtitle: 'الدعم والأسئلة الشائعة',
//                   onTap: () => _showHelpDialog(context),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSettingsItem(
//     BuildContext context, {
//     required IconData icon,
//     required String titleAr,
//     required String titleEn,
//     required String subtitle,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Theme.of(context).primaryColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
//       ),
//       title: Row(
//         children: [
//           Text(titleAr, style: const TextStyle(fontWeight: FontWeight.w600)),
//           const SizedBox(width: 8),
//           Text(
//             titleEn,
//             style: TextStyle(color: Colors.grey[600], fontSize: 12),
//           ),
//         ],
//       ),
//       subtitle: Text(
//         subtitle,
//         style: TextStyle(color: Colors.grey[600], fontSize: 12),
//       ),
//       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//       onTap: onTap,
//     );
//   }

//   // وظائف الحوارات
//   void _showThemeDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('اختيار المظهر'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.light_mode),
//               title: const Text('فاتح'),
//               onTap: () {
//                 // تطبيق المظهر الفاتح
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.dark_mode),
//               title: const Text('داكن'),
//               onTap: () {
//                 // تطبيق المظهر الداكن
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.auto_mode),
//               title: const Text('تلقائي'),
//               onTap: () {
//                 // تطبيق المظهر التلقائي
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showLanguageDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('اختيار اللغة'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Text('🇪🇬'),
//               title: const Text('العربية'),
//               onTap: () {
//                 // تطبيق اللغة العربية
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Text('🇺🇸'),
//               title: const Text('English'),
//               onTap: () {
//                 // تطبيق اللغة الإنجليزية
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showNotificationSettings(BuildContext context) {
//     Navigator.pop(context);
//     // فتح صفحة إعدادات الإشعارات
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('إعدادات الإشعارات قريباً')));
//   }

//   void _showBackupOptions(BuildContext context) {
//     Navigator.pop(context);
//     // فتح خيارات النسخ الاحتياطي
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('خيارات النسخ الاحتياطي قريباً')),
//     );
//   }

//   void _showAboutDialog(BuildContext context) {
//     showAboutDialog(
//       context: context,
//       applicationName: 'TickNote',
//       applicationVersion: '1.0.0',
//       applicationLegalese: '© 2024 TickNote App',
//       children: [const Text('تطبيق للملاحظات وقوائم المهام')],
//     );
//   }

//   void _showHelpDialog(BuildContext context) {
//     Navigator.pop(context);
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('صفحة المساعدة قريباً')));
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_note/core/services/service_locator.dart';
import 'package:tick_note/features/notes/presentation/controller/cubit/notes_cubit.dart';
import 'package:tick_note/features/notes/presentation/screens/notes_page.dart';
import 'package:tick_note/features/todo/presentation/controller/cubit/todo_cubit.dart';
import 'package:tick_note/features/todo/presentation/screens/todo_screen.dart';

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
      // إيقاف البحث عند تغيير التاب
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
      // البحث في المهام
      context.read<TodoCubit>().searchTodos(query);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    // MultiBlocProvider(
    //   providers: [
    //     // BlocProvider<NotesCubit>(create: (context) => sl<NotesCubit>()),
    //     // BlocProvider<TodoCubit>(create: (context) => sl<TodoCubit>()),
    //   ],
    // child:
    Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: _isSearching
            ? _buildSearchBar()
            : Text(
                _currentIndex == 0 ? 'Notes' : 'Todo',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          tooltip: 'Settings',
        ),
        actions: _isSearching
            ? null
            : [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _startSearch,
                  tooltip: 'Search',
                ),
                IconButton(
                  icon: Icon(
                    _currentIndex == 0 ? Icons.filter_list : Icons.tune,
                  ),
                  onPressed: () {
                    // وظيفة التصفية
                  },
                  tooltip: 'Filter',
                ),
              ],
      ),
      drawer: _buildSettingsDrawer(context),
      body: IndexedStack(
        index: _currentIndex,
        children: const [NotesPage(), TodoScreen()],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 11,
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.note_alt_outlined),
              activeIcon: Icon(Icons.note_alt),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box_outlined),
              activeIcon: Icon(Icons.check_box),
              label: 'Todo',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        autofocus: true,
        decoration: InputDecoration(
          hintText: _currentIndex == 0
              ? 'البحث في الملاحظات...'
              : 'البحث في المهام...',
          prefixIcon: const Icon(Icons.search, size: 20),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: _stopSearch,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header جميل
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 60, 16, 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.settings_rounded, color: Colors.white, size: 32),
                const SizedBox(height: 12),
                const Text(
                  'الإعدادات',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Settings',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // قائمة الإعدادات
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildSettingsItem(
                  context,
                  icon: Icons.palette_rounded,
                  titleAr: 'المظهر',
                  titleEn: 'Theme',
                  subtitle: 'تغيير المظهر الفاتح والداكن',
                  onTap: () => _showThemeDialog(context),
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.language_rounded,
                  titleAr: 'اللغة',
                  titleEn: 'Language',
                  subtitle: 'تغيير لغة التطبيق',
                  onTap: () => _showLanguageDialog(context),
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.notifications_rounded,
                  titleAr: 'الإشعارات',
                  titleEn: 'Notifications',
                  subtitle: 'إعدادات التنبيهات',
                  onTap: () => _showNotificationSettings(context),
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.backup_rounded,
                  titleAr: 'النسخ الاحتياطي',
                  titleEn: 'Backup',
                  subtitle: 'حفظ واستعادة البيانات',
                  onTap: () => _showBackupOptions(context),
                ),
                const Divider(),
                _buildSettingsItem(
                  context,
                  icon: Icons.info_rounded,
                  titleAr: 'حول التطبيق',
                  titleEn: 'About',
                  subtitle: 'معلومات التطبيق والإصدار',
                  onTap: () => _showAboutDialog(context),
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.help_rounded,
                  titleAr: 'المساعدة',
                  titleEn: 'Help',
                  subtitle: 'الدعم والأسئلة الشائعة',
                  onTap: () => _showHelpDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String titleAr,
    required String titleEn,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
      ),
      title: Row(
        children: [
          Text(titleAr, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Text(
            titleEn,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  // وظائف الحوارات
  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اختيار المظهر'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: const Text('فاتح'),
              onTap: () {
                // تطبيق المظهر الفاتح
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('داكن'),
              onTap: () {
                // تطبيق المظهر الداكن
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_mode),
              title: const Text('تلقائي'),
              onTap: () {
                // تطبيق المظهر التلقائي
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اختيار اللغة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇪🇬'),
              title: const Text('العربية'),
              onTap: () {
                // تطبيق اللغة العربية
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Text('🇺🇸'),
              title: const Text('English'),
              onTap: () {
                // تطبيق اللغة الإنجليزية
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
    Navigator.pop(context);
    // فتح صفحة إعدادات الإشعارات
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('إعدادات الإشعارات قريباً')));
  }

  void _showBackupOptions(BuildContext context) {
    Navigator.pop(context);
    // فتح خيارات النسخ الاحتياطي
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('خيارات النسخ الاحتياطي قريباً')),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'TickNote',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 TickNote App',
      children: [const Text('تطبيق للملاحظات وقوائم المهام')],
    );
  }

  void _showHelpDialog(BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('صفحة المساعدة قريباً')));
  }
}
