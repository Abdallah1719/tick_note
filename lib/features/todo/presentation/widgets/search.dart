import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isSearching;
  final VoidCallback onSearchToggle;
  final ValueChanged<String> onSearchChanged;

  const SearchAppBar({
    Key? key,
    required this.isSearching,
    required this.onSearchToggle,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar>
    with SingleTickerProviderStateMixin {
  late TextEditingController _searchController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(SearchAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSearching != oldWidget.isSearching) {
      if (widget.isSearching) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        _searchController.clear();
        widget.onSearchChanged('');
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      title: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return widget.isSearching
              ? FadeTransition(
                  opacity: _animation,
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'البحث في المهام...',
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onChanged: widget.onSearchChanged,
                  ),
                )
              : FadeTransition(
                  opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_animation),
                  child: const Text(
                    'المهام',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
        },
      ),
      actions: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return widget.isSearching
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_searchController.text.isNotEmpty)
                        FadeTransition(
                          opacity: _animation,
                          child: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              widget.onSearchChanged('');
                            },
                            tooltip: 'مسح البحث',
                          ),
                        ),
                      FadeTransition(
                        opacity: _animation,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: widget.onSearchToggle,
                          tooltip: 'إغلاق البحث',
                        ),
                      ),
                    ],
                  )
                : FadeTransition(
                    opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_animation),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: widget.onSearchToggle,
                          tooltip: 'البحث',
                        ),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) {
                            _handleMenuSelection(context, value);
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'refresh',
                              child: Row(
                                children: [
                                  Icon(Icons.refresh, size: 20),
                                  SizedBox(width: 8),
                                  Text('تحديث'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'filter',
                              child: Row(
                                children: [
                                  Icon(Icons.filter_list, size: 20),
                                  SizedBox(width: 8),
                                  Text('تصفية'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'clear_all',
                              child: Row(
                                children: [
                                  Icon(Icons.clear_all, size: 20, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('مسح الكل', style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
          },
        ),
      ],
    );
  }

  void _handleMenuSelection(BuildContext context, String value) {
    switch (value) {
      case 'refresh':
        // This will be handled by the parent widget
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('جاري التحديث...'),
            duration: Duration(seconds: 1),
          ),
        );
        break;
      case 'filter':
        _showFilterOptions(context);
        break;
      case 'clear_all':
        _showClearAllConfirmation(context);
        break;
    }
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'تصفية المهام',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('جميع المهام'),
              onTap: () {
                Navigator.pop(context);
                // Handle filter selection
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text('المهام المكتملة'),
              onTap: () {
                Navigator.pop(context);
                // Handle filter selection
              },
            ),
            ListTile(
              leading: const Icon(Icons.radio_button_unchecked, color: Colors.orange),
              title: const Text('المهام المُعلقة'),
              onTap: () {
                Navigator.pop(context);
                // Handle filter selection
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning, color: Colors.red),
              title: const Text('المهام المتأخرة'),
              onTap: () {
                Navigator.pop(context);
                // Handle filter selection
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showClearAllConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد مسح جميع المهام'),
        content: const Text(
          'هل أنت متأكد من حذف جميع المهام؟ هذا الإجراء لا يمكن التراجع عنه.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Handle clear all action
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم مسح جميع المهام'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('مسح الكل'),
          ),
        ],
      ),
    );
  }
}