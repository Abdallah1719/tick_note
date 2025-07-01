// 1. shared_app_bar.dart
import 'package:flutter/material.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isSearching;
  final TextEditingController searchController;
  final VoidCallback onStartSearch;
  final VoidCallback onStopSearch;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSort;
  final VoidCallback onOpenDrawer;

  const SharedAppBar({
    Key? key,
    required this.title,
    required this.isSearching,
    required this.searchController,
    required this.onStartSearch,
    required this.onStopSearch,
    required this.onSearchChanged,
    required this.onSort,
    required this.onOpenDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearching ? _buildSearchBar(context) : Text(title),
      leading: IconButton(
        icon: const Icon(Icons.menu_rounded),
        onPressed: onOpenDrawer,
      ),
      actions: isSearching ? null : [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: onStartSearch,
        ),
        IconButton(
          icon: const Icon(Icons.sort),
          onPressed: onSort,
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: searchController,
        onChanged: onSearchChanged,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'البحث...',
          prefixIcon: const Icon(Icons.search, size: 20),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: onStopSearch,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
