import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  final int clientCount;
  final int productCount;

  final VoidCallback onNewClient;
  final VoidCallback onNewProduct;
  final VoidCallback onClients;
  final VoidCallback onProducts;

  const DashboardScreen({
    super.key,
    required this.clientCount,
    required this.productCount,
    required this.onNewClient,
    required this.onNewProduct,
    required this.onClients,
    required this.onProducts,
  });

  @override
  Widget build(BuildContext context) {
    final h = DateTime.now().hour;

    final greeting = h < 12
        ? 'Bom dia'
        : h < 18
            ? 'Boa tarde'
            : 'Boa noite';

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 22, 24, 42),
            decoration: const BoxDecoration(
              color: AppTheme.brand,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(36),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting,',
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Bem-vinda! 👋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Gerencie seus clientes e produtos',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              children: [
                Transform.translate(
                  offset: const Offset(0, -20),
                  child: Row(
                    children: [
                      Expanded(
                        child: _Stat(
                          icon: Icons.people_outline,
                          label: 'CLIENTES',
                          value: '$clientCount',
                          color: AppTheme.brandContainer,
                          onColor: AppTheme.onBrandContainer,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _Stat(
                          icon: Icons.inventory_2_outlined,
                          label: 'PRODUTOS',
                          value: '$productCount',
                          color: AppTheme.tertiaryContainer,
                          onColor: AppTheme.onTertiaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -10),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ações rápidas',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _Action(
                  icon: Icons.person_add_alt_1,
                  title: 'Novo cliente',
                  subtitle: 'Cadastrar um novo cliente',
                  color: AppTheme.brand,
                  onTap: onNewClient,
                ),
                const SizedBox(height: 10),
                _Action(
                  icon: Icons.add_box_outlined,
                  title: 'Novo produto',
                  subtitle: 'Adicionar um produto ao catálogo',
                  color: AppTheme.tertiary,
                  onTap: onNewProduct,
                ),
                const SizedBox(height: 22),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ir para',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _Go(
                        icon: Icons.people_outline,
                        label: 'Clientes',
                        color: AppTheme.brandContainer,
                        onColor: AppTheme.onBrandContainer,
                        onTap: onClients,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _Go(
                        icon: Icons.inventory_2_outlined,
                        label: 'Produtos',
                        color: AppTheme.tertiaryContainer,
                        onColor: AppTheme.onTertiaryContainer,
                        onTap: onProducts,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final Color onColor;

  const _Stat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.onColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: onColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: AppTheme.muted,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _Action({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppTheme.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppTheme.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Go extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color onColor;
  final VoidCallback onTap;

  const _Go({
    required this.icon,
    required this.label,
    required this.color,
    required this.onColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22),
          child: Column(
            children: [
              Icon(
                icon,
                size: 28,
                color: onColor,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: onColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}