import 'package:flutter/material.dart';

class CustomNoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNoteAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text('Notes'));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
