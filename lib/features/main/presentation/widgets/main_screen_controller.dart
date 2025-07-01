// 4. main_screen_controller.dart (بدلاً من Cubit)
import 'package:flutter/material.dart';

class MainScreenController {
  int _currentIndex = 0;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  int get currentIndex => _currentIndex;
  bool get isSearching => _isSearching;
  TextEditingController get searchController => _searchController;

  void setCurrentIndex(int index) {
    _currentIndex = index;
  }

  void startSearch() {
    _isSearching = true;
  }

  void stopSearch() {
    _isSearching = false;
    _searchController.clear();
  }

  void dispose() {
    _searchController.dispose();
  }
}