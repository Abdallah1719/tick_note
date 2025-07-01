// features/main/presentation/widgets/settings_drawer.dart

import 'package:flutter/material.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header جميل
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 60, 16, 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8),
                ],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.settings_rounded, color: Colors.white, size: 32),
                SizedBox(height: 12),
                Text(
                  'الإعدادات',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Settings',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // قائمة الإعدادات
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildSettingsItem(
                  context,
                  icon: Icons.palette_rounded,
                  titleAr: 'المظهر',
                  titleEn: 'Theme',
                  subtitle: 'تغيير المظهر الفاتح والداكن',
                  onTap: () => _showThemeDialog(context),
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.language_rounded,
                  titleAr: 'اللغة',
                  titleEn: 'Language',
                  subtitle: 'تغيير لغة التطبيق',
                  onTap: () => _showLanguageDialog(context),
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.notifications_rounded,
                  titleAr: 'الإشعارات',
                  titleEn: 'Notifications',
                  subtitle: 'إعدادات التنبيهات',
                  onTap: () => _showNotificationSettings(context),
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.backup_rounded,
                  titleAr: 'النسخ الاحتياطي',
                  titleEn: 'Backup',
                  subtitle: 'حفظ واستعادة البيانات',
                  onTap: () => _showBackupOptions(context),
                ),
                const Divider(),
                _buildSettingsItem(
                  context,
                  icon: Icons.info_rounded,
                  titleAr: 'حول التطبيق',
                  titleEn: 'About',
                  subtitle: 'معلومات التطبيق والإصدار',
                  onTap: () => _showAboutDialog(context),
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.help_rounded,
                  titleAr: 'المساعدة',
                  titleEn: 'Help',
                  subtitle: 'الدعم والأسئلة الشائعة',
                  onTap: () => _showHelpDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String titleAr,
    required String titleEn,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
      ),
      title: Row(
        children: [
          Text(titleAr, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Text(
            titleEn,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  // وظائف الحوارات
  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اختيار المظهر'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: const Text('فاتح'),
              onTap: () {
                // تطبيق المظهر الفاتح
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('داكن'),
              onTap: () {
                // تطبيق المظهر الداكن
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_mode),
              title: const Text('تلقائي'),
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

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اختيار اللغة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇪🇬'),
              title: const Text('العربية'),
              onTap: () {
                // تطبيق اللغة العربية
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Text('🇺🇸'),
              title: const Text('English'),
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

  void _showNotificationSettings(BuildContext context) {
    Navigator.pop(context);
    // فتح صفحة إعدادات الإشعارات
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('إعدادات الإشعارات قريباً')));
  }

  void _showBackupOptions(BuildContext context) {
    Navigator.pop(context);
    // فتح خيارات النسخ الاحتياطي
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('خيارات النسخ الاحتياطي قريباً')),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'TickNote',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 TickNote App',
      children: const [Text('تطبيق للملاحظات وقوائم المهام')],
    );
  }

  void _showHelpDialog(BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('صفحة المساعدة قريباً')));
  }
}
