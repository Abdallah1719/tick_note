import 'package:flutter/material.dart';
import 'package:tick_note/features/notes/domain/entities/note_entity.dart';

// class NoteCard extends StatelessWidget {
//   final NoteEntity note;
//   final VoidCallback onTap;
//   final VoidCallback onDelete;
//   final VoidCallback onPin;

//   const NoteCard({
//     super.key,
//     required this.note,
//     required this.onTap,
//     required this.onDelete,
//     required this.onPin,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: ValueKey(note.id),
//       direction: DismissDirection.endToStart,
//       background: Container(
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.only(right: 20),
//         margin: const EdgeInsets.only(bottom: 8),
//         decoration: BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.push_pin, color: Colors.white),
//               onPressed: onPin,
//             ),
//             const SizedBox(width: 8),
//             IconButton(
//               icon: const Icon(Icons.delete, color: Colors.white),
//               onPressed: onDelete,
//             ),
//           ],
//         ),
//       ),
//       child: Card(
//         margin: const EdgeInsets.only(bottom: 8),
//         color: _getColorFromHex(note.color),
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(12),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         note.title,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     if (note.isPinned)
//                       const Icon(
//                         Icons.push_pin,
//                         size: 18,
//                         color: Colors.grey,
//                       ),
//                   ],
//                 ),
//                 if (note.content.isNotEmpty) ...[
//                   const SizedBox(height: 8),
//                   Text(
//                     note.content,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey,
//                     ),
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//                 const SizedBox(height: 12),
//                 Text(
//                   _formatDate(note.updatedAt),
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Color _getColorFromHex(String hexColor) {
//     try {
//       return Color(int.parse(hexColor.replaceFirst('#', '0xFF')));
//     } catch (e) {
//       return Colors.white;
//     }
//   }

//   String _formatDate(DateTime date) {
//     final now = DateTime.now();
//     final difference = now.difference(date);

//     if (difference.inDays > 0) {
//       return '${difference.inDays} days ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours} hours ago';
//     } else if (difference.inMinutes > 0) {
//       return '${difference.inMinutes} minutes ago';
//     } else {
//       return 'Just now';
//     }
//   }
// }

// // lib/features/notes/presentation/widgets/search_bar_widget.dart

class NoteCard extends StatelessWidget {
  final NoteEntity note;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onPin;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onDelete,
    required this.onPin,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(note.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        await Future.delayed(Duration(seconds: 2));
        return false; // Don't dismiss, just show actions
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                note.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                color: Colors.white,
              ),
              onPressed: onPin,
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        color: Color(note.color),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        note.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (note.isPinned)
                      const Icon(Icons.push_pin, size: 18, color: Colors.grey),
                  ],
                ),
                if ((note.subtitle ?? '').isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    note.subtitle ?? '',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  _formatDate(DateTime.parse(note.date)),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Color _getColorFromHex(String hexColor) {
  //   try {
  //     return Color(int.parse(hexColor.replaceFirst('#', '0xFF')));
  //   } catch (e) {
  //     return Colors.white;
  //   }
  // }

  // int _colorFromHex(String hexColor) {
  //   hexColor = hexColor.replaceAll('#', '');
  //   if (hexColor.length == 6) {
  //     hexColor = 'FF$hexColor'; // add alpha if not provided
  //   }
  //   return int.parse(hexColor, radix: 16);
  // }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
