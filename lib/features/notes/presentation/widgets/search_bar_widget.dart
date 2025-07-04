// import 'package:flutter/material.dart';

// class SearchBarWidget extends StatelessWidget {
//   final TextEditingController controller;
//   final ValueChanged<String> onChanged;
//   final VoidCallback onClose;

//   const SearchBarWidget({
//     super.key,
//     required this.controller,
//     required this.onChanged,
//     required this.onClose,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: controller,
//             autofocus: true,
//             decoration: const InputDecoration(
//               hintText: 'Search notes...',
//               border: InputBorder.none,
//               hintStyle: TextStyle(color: Colors.grey),
//             ),
//             style: const TextStyle(fontSize: 16),
//             onChanged: onChanged,
//           ),
//         ),
//         IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: onClose,
//         ),
//       ],
//     );
//   }
// }
