import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class MoreScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const MoreScreen({
    super.key,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
      children: [
        const Text(
          'Mais',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 18),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppTheme.brandContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: AppTheme.onBrandContainer,
                  ),
                ),
                const SizedBox(width: 14),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Minha Revenda',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Gerencie sua revenda com praticidade',
                      style: TextStyle(
                        color: AppTheme.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Card(
          child: Column(
            children: [
              _item(
                Icons.settings_outlined,
                'Configurações',
              ),
              _item(
                Icons.info_outline,
                'Informações do aplicativo',
                sub: 'Versão 1.0.0',
              ),
              _item(
                Icons.smartphone_outlined,
                'Aplicativo mobile',
              ),
              _item(
                Icons.logout,
                'Sair',
                danger: true,
                onTap: onLogout,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _item(
    IconData icon,
    String label, {
    String? sub,
    bool danger = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: danger
              ? AppTheme.errorContainer
              : AppTheme.surfaceVariant,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          icon,
          color: danger ? AppTheme.error : AppTheme.muted,
        ),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: danger
              ? AppTheme.error
              : AppTheme.onSurface,
        ),
      ),
      subtitle: sub == null ? null : Text(sub),
      trailing: danger
          ? null
          : const Icon(
              Icons.chevron_right,
              color: AppTheme.outline,
            ),
    );
  }
}