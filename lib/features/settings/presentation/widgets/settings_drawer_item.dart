// features/main/presentation/widgets/settings_drawer_item.dart

import 'package:flutter/material.dart';

class SettingsDrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SettingsDrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildIconContainer(context),
      title: _buildTitle(context),
      subtitle: _buildSubtitle(context),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildIconContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title, 
      style: const TextStyle(fontWeight: FontWeight.w600)
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      subtitle,
      style: TextStyle(color: Colors.grey[600], fontSize: 12),
    );
  }
}