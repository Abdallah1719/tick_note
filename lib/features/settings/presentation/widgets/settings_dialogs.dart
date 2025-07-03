// // features/main/presentation/widgets/settings_dialogs.dart

// import 'package:flutter/material.dart';
// import 'package:tick_note/generated/l10n.dart';

// class SettingsDialogs {
//   static void showThemeDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(S.of(context).selectTheme),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildThemeOption(
//               context,
//               icon: Icons.light_mode,
//               title: S.of(context).lightTheme,
//               onTap: () {
//                 // تطبيق المظهر الفاتح
//                 Navigator.pop(context);
//               },
//             ),
//             _buildThemeOption(
//               context,
//               icon: Icons.dark_mode,
//               title: S.of(context).darkTheme,
//               onTap: () {
//                 // تطبيق المظهر الداكن
//                 Navigator.pop(context);
//               },
//             ),
//             _buildThemeOption(
//               context,
//               icon: Icons.auto_mode,
//               title: S.of(context).autoTheme,
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

//   static void showLanguageDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(S.of(context).selectLanguage),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildLanguageOption(
//               context,
//               flag: '🇪🇬',
//               title: S.of(context).arabicLanguage,
//               onTap: () {
//                 // تطبيق اللغة العربية
//                 Navigator.pop(context);
//               },
//             ),
//             _buildLanguageOption(
//               context,
//               flag: '🇺🇸',
//               title: S.of(context).englishLanguage,
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

//   static void showNotificationSettings(BuildContext context) {
//     Navigator.pop(context);
//     _showSnackBar(context, S.of(context).notificationSettingsComingSoon);
//   }

//   static void showBackupOptions(BuildContext context) {
//     Navigator.pop(context);
//     _showSnackBar(context, S.of(context).backupOptionsComingSoon);
//   }

//   static void showAboutDialog(BuildContext context) {
//     showAboutDialog(
//       context: context,
//       applicationName: S.of(context).appName,
//       applicationVersion: '1.0.0',
//       applicationLegalese: S.of(context).appLegalese,
//       children: [Text(S.of(context).appDescription)],
//     );
//   }

//   static void showHelpDialog(BuildContext context) {
//     Navigator.pop(context);
//     _showSnackBar(context, S.of(context).helpPageComingSoon);
//   }

//   // Helper Methods
//   static Widget _buildThemeOption(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title),
//       onTap: onTap,
//     );
//   }

//   static Widget _buildLanguageOption(
//     BuildContext context, {
//     required String flag,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Text(flag),
//       title: Text(title),
//       onTap: onTap,
//     );
//   }

//   static void _showSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
// }
// features/main/presentation/widgets/settings_dialogs.dart

import 'package:flutter/material.dart';
import 'package:tick_note/generated/l10n.dart';

class SettingsDialogs {
  static void showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).selectTheme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(
              context,
              icon: Icons.light_mode,
              title: S.of(context).lightTheme,
              onTap: () {
                // تطبيق المظهر الفاتح
                Navigator.pop(context);
              },
            ),
            _buildThemeOption(
              context,
              icon: Icons.dark_mode,
              title: S.of(context).darkTheme,
              onTap: () {
                // تطبيق المظهر الداكن
                Navigator.pop(context);
              },
            ),
            _buildThemeOption(
              context,
              icon: Icons.auto_mode,
              title: S.of(context).autoTheme,
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

  static void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).selectLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(
              context,
              flag: '🇪🇬',
              title: S.of(context).arabicLanguage,
              onTap: () {
                // تطبيق اللغة العربية
                Navigator.pop(context);
              },
            ),
            _buildLanguageOption(
              context,
              flag: '🇺🇸',
              title: S.of(context).englishLanguage,
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

  static void showNotificationSettings(BuildContext context) {
    Navigator.pop(context);
    _showSnackBar(context, S.of(context).notificationSettingsComingSoon);
  }

  static void showBackupOptions(BuildContext context) {
    Navigator.pop(context);
    _showSnackBar(context, S.of(context).backupOptionsComingSoon);
  }

  static void showAppAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: S.of(context).appName,
      applicationVersion: '1.0.0',
      applicationLegalese: S.of(context).appLegalese,
      children: [Text(S.of(context).appDescription)],
    );
  }

  static void showHelpDialog(BuildContext context) {
    Navigator.pop(context);
    _showSnackBar(context, S.of(context).helpPageComingSoon);
  }

  // Helper Methods
  static Widget _buildThemeOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  static Widget _buildLanguageOption(
    BuildContext context, {
    required String flag,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Text(flag),
      title: Text(title),
      onTap: onTap,
    );
  }

  static void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}