import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_note/features/todo/domain/entities/todo_entity.dart';
import 'package:tick_note/features/todo/presentation/controller/cubit/todo_cubit.dart';

class AddTodoBottomSheet extends StatefulWidget {
  final TodoEntity? todoToEdit;

  const AddTodoBottomSheet({super.key, this.todoToEdit});

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet>
    with SingleTickerProviderStateMixin {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );

    // If editing, populate fields
    if (widget.todoToEdit != null) {
      _titleController.text = widget.todoToEdit!.title;
      _descriptionController.text = widget.todoToEdit!.description ?? '';
      _selectedDate = widget.todoToEdit!.dueDate;
      if (widget.todoToEdit!.dueDate != null) {
        _selectedTime = TimeOfDay.fromDateTime(widget.todoToEdit!.dueDate!);
      }
    }

    _animationController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _animation.value) * 100),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title
                    Text(
                      widget.todoToEdit != null
                          ? 'تعديل المهمة'
                          : 'إضافة مهمة جديدة',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // Title field
                    _buildTextField(
                      controller: _titleController,
                      label: 'عنوان المهمة',
                      hint: 'أدخل عنوان المهمة...',
                      icon: Icons.title,
                      required: true,
                    ),
                    const SizedBox(height: 20),

                    // Description field
                    _buildTextField(
                      controller: _descriptionController,
                      label: 'وصف المهمة (اختياري)',
                      hint: 'أدخل وصف المهمة...',
                      icon: Icons.description,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),

                    // Date and Time section
                    _buildDateTimeSection(),
                    const SizedBox(height: 30),

                    // Save button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _saveTodo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              widget.todoToEdit != null
                                  ? 'حفظ التعديلات'
                                  : 'حفظ المهمة',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    bool required = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            if (required) const Text(' *', style: TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, size: 20, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                'موعد التذكير (اختياري)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              // Date picker
              Expanded(
                child: InkWell(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate != null
                              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                              : 'اختر التاريخ',
                          style: TextStyle(
                            color: _selectedDate != null
                                ? Colors.black87
                                : Colors.grey[500],
                          ),
                        ),
                        Icon(
                          Icons.calendar_month,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Time picker
              Expanded(
                child: InkWell(
                  onTap: _selectTime,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedTime != null
                              ? _selectedTime!.format(context)
                              : 'اختر الوقت',
                          style: TextStyle(
                            color: _selectedTime != null
                                ? Colors.black87
                                : Colors.grey[500],
                          ),
                        ),
                        Icon(
                          Icons.access_time,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          if (_selectedDate != null || _selectedTime != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.blue[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'سيتم إرسال تنبيه في الموعد المحدد',
                    style: TextStyle(fontSize: 12, color: Colors.blue[600]),
                  ),
                ),
                TextButton(
                  onPressed: _clearDateTime,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('مسح', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _clearDateTime() {
    setState(() {
      _selectedDate = null;
      _selectedTime = null;
    });
  }

  void _saveTodo() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('يرجى إدخال عنوان المهمة')));
      return;
    }

    DateTime? dueDate;
    if (_selectedDate != null && _selectedTime != null) {
      dueDate = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
    } else if (_selectedDate != null) {
      dueDate = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
      );
    }

    final todo = TodoEntity(
      id: widget.todoToEdit?.id,
      title: title,
      description: description.isEmpty ? null : description,
      dueDate: dueDate,
      isCompleted: widget.todoToEdit?.isCompleted ?? false,
      createdAt: widget.todoToEdit?.createdAt ?? DateTime.now(),
    );

    if (widget.todoToEdit == null) {
      context.read<TodoCubit>().insertTodo(todo);
    } else {
      context.read<TodoCubit>().updateTodo(todo);
    }

    Navigator.of(context).pop();
  }
}
