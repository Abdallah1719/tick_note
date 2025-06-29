import 'package:flutter/material.dart';
import 'package:tick_note/features/todo/domain/entities/todo_entity.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoEntity todo;
  final Function(TodoEntity) onToggleComplete;
  final Function(int) onDelete;
  final Function(TodoEntity) onEdit;

  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.onToggleComplete,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final isOverdue = todo.dueDate != null && 
                      todo.dueDate!.isBefore(DateTime.now()) && 
                      !todo.isCompleted;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isOverdue 
                ? Colors.red.withOpacity(0.3)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: InkWell(
          onTap: () => _showTodoDetails(context),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with checkbox and actions
                Row(
                  children: [
                    // Checkbox
                    GestureDetector(
                      onTap: () => onToggleComplete(todo),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: todo.isCompleted 
                                ? Colors.green 
                                : Colors.grey[400]!,
                            width: 2,
                          ),
                          color: todo.isCompleted 
                              ? Colors.green 
                              : Colors.transparent,
                        ),
                        child: todo.isCompleted
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Title and status
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: todo.isCompleted 
                                  ? Colors.grey[500]
                                  : Colors.black87,
                              decoration: todo.isCompleted 
                                  ? TextDecoration.lineThrough 
                                  : TextDecoration.none,
                            ),
                          ),
                          if (isOverdue) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  size: 16,
                                  color: Colors.red[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'متأخرة',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    
                    // Actions
                    PopupMenuButton<String>(
                      onSelected: (value) => _handleAction(context, value),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 18, color: Colors.blue[600]),
                              const SizedBox(width: 8),
                              const Text('تعديل'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 18, color: Colors.red[600]),
                              const SizedBox(width: 8),
                              Text(
                                'حذف',
                                style: TextStyle(color: Colors.red[600]),
                              ),
                            ],
                          ),
                        ),
                      ],
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                
                // Description
                if (todo.description != null && todo.description!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    todo.description!,
                    style: TextStyle(
                      fontSize: 14,
                      color: todo.isCompleted 
                          ? Colors.grey[400]
                          : Colors.grey[600],
                      decoration: todo.isCompleted 
                          ? TextDecoration.lineThrough 
                          : TextDecoration.none,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                
                // Date and time info
                if (todo.dueDate != null || todo.createdAt != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (todo.dueDate != null) ...[
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: isOverdue 
                              ? Colors.red[600]
                              : Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDateTime(context, todo.dueDate!),
                          style: TextStyle(
                            fontSize: 12,
                            color: isOverdue 
                                ? Colors.red[600]
                                : Colors.grey[500],
                            fontWeight: isOverdue 
                                ? FontWeight.w500 
                                : FontWeight.normal,
                          ),
                        ),
                        const Spacer(),
                      ],
                      
                      if (todo.createdAt != null) ...[
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'أُنشئت ${_formatCreatedDate(todo.createdAt!)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
                
                // Status indicator
                if (todo.isCompleted) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.green[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'مكتملة',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleAction(BuildContext context, String action) {
    switch (action) {
      case 'edit':
        onEdit(todo);
        break;
      case 'delete':
        onDelete(todo.id?? 0);
        break;
    }
  }

  void _showTodoDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          todo.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (todo.description != null && todo.description!.isNotEmpty) ...[
                const Text(
                  'الوصف:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  todo.description!,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
              ],
              
              _buildDetailRow(
                icon: Icons.radio_button_checked,
                label: 'الحالة',
                value: todo.isCompleted ? 'مكتملة' : 'غير مكتملة',
                valueColor: todo.isCompleted ? Colors.green : Colors.orange,
              ),
              
              if (todo.dueDate != null) ...[
                const SizedBox(height: 12),
                _buildDetailRow(
                  icon: Icons.schedule,
                  label: 'موعد الاستحقاق',
                  value: _formatDateTime(context, todo.dueDate!),
                  valueColor: todo.dueDate!.isBefore(DateTime.now()) && !todo.isCompleted
                      ? Colors.red
                      : Colors.blue,
                ),
              ],
              
              if (todo.createdAt != null) ...[
                const SizedBox(height: 12),
                _buildDetailRow(
                  icon: Icons.access_time,
                  label: 'تاريخ الإنشاء',
                  value: _formatDateTime(context, todo.createdAt!),
                  valueColor: Colors.grey,
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إغلاق'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onEdit(todo);
            },
            child: const Text('تعديل'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: valueColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

String _formatDateTime(BuildContext context, DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final tomorrow = today.add(const Duration(days: 1));
  final itemDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

  String dateStr;
  if (itemDate == today) {
    dateStr = 'اليوم';
  } else if (itemDate == yesterday) {
    dateStr = 'أمس';
  } else if (itemDate == tomorrow) {
    dateStr = 'غداً';
  } else {
    dateStr = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  final timeStr = TimeOfDay.fromDateTime(dateTime).format(context);

  return '$dateStr في $timeStr';
}

  //   return '$dateStr في $timeStr';
  // }

  String _formatCreatedDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return 'منذ ${difference.inMinutes} دقيقة';
      }
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inDays == 1) {
      return 'أمس';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} أيام';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}