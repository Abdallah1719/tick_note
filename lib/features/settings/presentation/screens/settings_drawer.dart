// // features/main/presentation/widgets/settings_drawer.dart
// import 'package:flutter/material.dart';
// import 'package:tick_note/features/settings/presentation/widgets/settings_dialogs.dart';
// import 'package:tick_note/features/settings/presentation/widgets/settings_drawer_header.dart';
// import 'package:tick_note/features/settings/presentation/widgets/settings_drawer_item.dart';
// import 'package:tick_note/generated/l10n.dart';

// class SettingsDrawer extends StatelessWidget {
//   const SettingsDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           const SettingsDrawerHeader(),
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               children: [
//                 SettingsDrawerItem(
//                   icon: Icons.palette_rounded,
//                   title: S.of(context).theme,
//                   subtitle: S.of(context).themeSubtitle,
//                   onTap: () => SettingsDialogs.showThemeDialog(context),
//                 ),
//                 SettingsDrawerItem(
//                   icon: Icons.language_rounded,
//                   title: S.of(context).language,
//                   subtitle: S.of(context).languageSubtitle,
//                   onTap: () => SettingsDialogs.showLanguageDialog(context),
//                 ),
//                 SettingsDrawerItem(
//                   icon: Icons.notifications_rounded,
//                   title: S.of(context).notifications,
//                   subtitle: S.of(context).notificationsSubtitle,
//                   onTap: () => SettingsDialogs.showNotificationSettings(context),
//                 ),
//                 SettingsDrawerItem(
//                   icon: Icons.backup_rounded,
//                   title: S.of(context).backup,
//                   subtitle: S.of(context).backupSubtitle,
//                   onTap: () => SettingsDialogs.showBackupOptions(context),
//                 ),
//                 const Divider(),
//                 SettingsDrawerItem(
//                   icon: Icons.info_rounded,
//                   title: S.of(context).about,
//                   subtitle: S.of(context).aboutSubtitle,
//                   onTap: () => SettingsDialogs.showAboutDialog(context),
//                 ),
//                 SettingsDrawerItem(
//                   icon: Icons.help_rounded,
//                   title: S.of(context).help,
//                   subtitle: S.of(context).helpSubtitle,
//                   onTap: () => SettingsDialogs.showHelpDialog(context),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }// features/main/presentation/widgets/settings_drawer.dart

import 'package:flutter/material.dart';
import 'package:tick_note/features/settings/presentation/widgets/settings_dialogs.dart';
import 'package:tick_note/features/settings/presentation/widgets/settings_drawer_header.dart';
import 'package:tick_note/features/settings/presentation/widgets/settings_drawer_item.dart';
import 'package:tick_note/generated/l10n.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SettingsDrawerHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                SettingsDrawerItem(
                  icon: Icons.palette_rounded,
                  title: S.of(context).theme,
                  subtitle: S.of(context).themeSubtitle,
                  onTap: () => SettingsDialogs.showThemeDialog(context),
                ),
                SettingsDrawerItem(
                  icon: Icons.language_rounded,
                  title: S.of(context).language,
                  subtitle: S.of(context).languageSubtitle,
                  onTap: () => SettingsDialogs.showLanguageDialog(context),
                ),
                SettingsDrawerItem(
                  icon: Icons.notifications_rounded,
                  title: S.of(context).notifications,
                  subtitle: S.of(context).notificationsSubtitle,
                  onTap: () =>
                      SettingsDialogs.showNotificationSettings(context),
                ),
                SettingsDrawerItem(
                  icon: Icons.backup_rounded,
                  title: S.of(context).backup,
                  subtitle: S.of(context).backupSubtitle,
                  onTap: () => SettingsDialogs.showBackupOptions(context),
                ),
                const Divider(),
                SettingsDrawerItem(
                  icon: Icons.info_rounded,
                  title: S.of(context).about,
                  subtitle: S.of(context).aboutSubtitle,
                  onTap: () => SettingsDialogs.showAppAboutDialog(context),
                ),
                SettingsDrawerItem(
                  icon: Icons.help_rounded,
                  title: S.of(context).help,
                  subtitle: S.of(context).helpSubtitle,
                  onTap: () => SettingsDialogs.showHelpDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
