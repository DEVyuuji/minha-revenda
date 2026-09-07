import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ClientDetailScreen extends StatelessWidget {
  final Client client;
  final VoidCallback onEdit, onDelete;
  const ClientDetailScreen({
    super.key,
    required this.client,
    required this.onEdit,
    required this.onDelete,
  });
  Widget row(IconData icon, String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppTheme.brandContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 18, color: AppTheme.onBrandContainer),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  color: AppTheme.muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value.isEmpty ? 'Não informado' : value,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  @override
  Widget build(BuildContext c) => Column(
    children: [
      AppHeader(
        title: 'Detalhes do cliente',
        onBack: () => Navigator.pop(c),
        actions: [
          IconButton(onPressed: onEdit, icon: const Icon(Icons.edit_outlined)),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, color: AppTheme.error),
          ),
        ],
      ),
      Expanded(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppTheme.brand,
                  child: Text(
                    initials(client.name),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  client.name,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.brandContainer,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Cliente',
                    style: TextStyle(
                      color: AppTheme.onBrandContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        row(Icons.phone_outlined, 'Telefone', client.phone),
                        const Divider(height: 1),
                        row(Icons.email_outlined, 'E-mail', client.email),
                        const Divider(height: 1),
                        row(Icons.badge_outlined, 'CPF', client.cpf),
                        const Divider(height: 1),
                        row(
                          Icons.location_on_outlined,
                          'Endereço',
                          client.address,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
